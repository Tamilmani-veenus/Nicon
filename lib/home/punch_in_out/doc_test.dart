import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

// ============ background work (runs off the main thread) ============

/// Camera page calls this: fixes rotation, crops to the guide frame,
/// makes the full image and a small thumbnail.
Map<String, dynamic> prepareScanImage(Map<String, dynamic> a) {
  var image = img.decodeImage(File(a['path'] as String).readAsBytesSync())!;
  image = img.bakeOrientation(image);
  if (image.width > image.height) {
    image = img.copyRotate(image, 90);
  }

  final x = ((a['l'] as double) * image.width).round();
  final y = ((a['t'] as double) * image.height).round();
  final w = (((a['r'] as double) - (a['l'] as double)) * image.width).round();
  final h = (((a['b'] as double) - (a['t'] as double)) * image.height).round();
  image = img.copyCrop(image, x, y, w, h);

  const maxSide = 2400;
  if (image.height > maxSide) {
    image = img.copyResize(image, height: maxSide);
  }
  final thumb = img.copyResize(image, height: min(900, image.height));

  return {
    'bytes': Uint8List.fromList(img.encodeJpg(image, quality: 93)),
    'thumb': Uint8List.fromList(img.encodeJpg(thumb, quality: 90)),
    'w': image.width,
    'h': image.height,
  };
}

img.Image _warp(Uint8List bytes, List<double> p, double maxSide, int turns) {
  var src = img.decodeImage(bytes)!;
  if (turns % 4 != 0) {
    src = img.copyRotate(src, 90.0 * (turns % 4));
  }
  final sw = src.width.toDouble();
  final sh = src.height.toDouble();

  final x0 = p[0] * sw, y0 = p[1] * sh;
  final x1 = p[2] * sw, y1 = p[3] * sh;
  final x2 = p[4] * sw, y2 = p[5] * sh;
  final x3 = p[6] * sw, y3 = p[7] * sh;

  double dist(double ax, double ay, double bx, double by) =>
      sqrt((ax - bx) * (ax - bx) + (ay - by) * (ay - by));

  final outWd = max(dist(x0, y0, x1, y1), dist(x3, y3, x2, y2));
  final outHd = max(dist(x0, y0, x3, y3), dist(x1, y1, x2, y2));
  final k = min(1.0, maxSide / max(outWd, outHd));
  final outW = max(2, (outWd * k).round());
  final outH = max(2, (outHd * k).round());

  final dx1 = x1 - x2, dx2 = x3 - x2, dx3 = x0 - x1 + x2 - x3;
  final dy1 = y1 - y2, dy2 = y3 - y2, dy3 = y0 - y1 + y2 - y3;
  double g = 0, h = 0;
  final den = dx1 * dy2 - dx2 * dy1;
  if (den.abs() > 1e-9 && (dx3 != 0 || dy3 != 0)) {
    g = (dx3 * dy2 - dx2 * dy3) / den;
    h = (dx1 * dy3 - dx3 * dy1) / den;
  }
  final ca = x1 - x0 + g * x1, cb = x3 - x0 + h * x3, cc = x0;
  final cd = y1 - y0 + g * y1, ce = y3 - y0 + h * y3, cf = y0;

  final out = img.Image(outW, outH);
  for (int y = 0; y < outH; y++) {
    final v = y / (outH - 1);
    for (int x = 0; x < outW; x++) {
      final u = x / (outW - 1);
      final w = g * u + h * v + 1;
      final sx = ((ca * u + cb * v + cc) / w).clamp(0.0, sw - 1.01).toDouble();
      final sy = ((cd * u + ce * v + cf) / w).clamp(0.0, sh - 1.01).toDouble();
      out.setPixel(x, y, src.getPixelLinear(sx, sy));
    }
  }
  return out;
}

/// "Clear": removes shadows, white paper, dark sharp text (like a scanner app)
/// "Clear": document scanner look (white paper, dark text, no haze)
img.Image _clear(img.Image source) {
  final image = img.Image.from(source);
  final w = image.width, h = image.height;
  final d = image.data;

  // 1. grayscale
  final gray = Uint8List(w * h);
  for (int i = 0; i < d.length; i++) {
    final c = d[i];
    gray[i] = ((c & 0xff) * 299 +
        ((c >> 8) & 0xff) * 587 +
        ((c >> 16) & 0xff) * 114) ~/
        1000;
  }

  // 2. small map of the paper brightness (average of each cell)
  final cell = max(2, min(w, h) ~/ 300);
  final sw = (w / cell).ceil();
  final sh = (h / cell).ceil();
  var map = Uint8List(sw * sh);
  for (int cy = 0; cy < sh; cy++) {
    for (int cx = 0; cx < sw; cx++) {
      int sum = 0, n = 0;
      final y1 = min(h, (cy + 1) * cell);
      final x1 = min(w, (cx + 1) * cell);
      for (int y = cy * cell; y < y1; y++) {
        final row = y * w;
        for (int x = cx * cell; x < x1; x++) {
          sum += gray[row + x];
          n++;
        }
      }
      map[cy * sw + cx] = sum ~/ n;
    }
  }

  // 3. remove the text from the map: dilate (max) then erode (min)
  const r = 3;
  Uint8List sweep(Uint8List src, bool horizontal, bool useMax) {
    final out = Uint8List(src.length);
    for (int y = 0; y < sh; y++) {
      for (int x = 0; x < sw; x++) {
        int best = useMax ? 0 : 255;
        for (int k = -r; k <= r; k++) {
          final xx = horizontal ? (x + k).clamp(0, sw - 1).toInt() : x;
          final yy = horizontal ? y : (y + k).clamp(0, sh - 1).toInt();
          final v = src[yy * sw + xx];
          if (useMax ? v > best : v < best) best = v;
        }
        out[y * sw + x] = best;
      }
    }
    return out;
  }

  map = sweep(sweep(map, true, true), false, true); // dilate
  map = sweep(sweep(map, true, false), false, false); // erode

  // light smoothing so there are no patches
      {
    final out = Uint8List(map.length);
    for (int y = 0; y < sh; y++) {
      for (int x = 0; x < sw; x++) {
        int sum = 0, n = 0;
        for (int dy = -1; dy <= 1; dy++) {
          final yy = y + dy;
          if (yy < 0 || yy >= sh) continue;
          for (int dx = -1; dx <= 1; dx++) {
            final xx = x + dx;
            if (xx < 0 || xx >= sw) continue;
            sum += map[yy * sw + xx];
            n++;
          }
        }
        out[y * sw + x] = sum ~/ n;
      }
    }
    map = out;
  }

  // 4. levels: dark text stays dark, paper becomes pure white
  const low = 40;
  const high = 250;
  final lut = List<int>.filled(256, 0);
  for (int i = 0; i < 256; i++) {
    lut[i] = ((i - low) * 255 / (high - low)).round().clamp(0, 255).toInt();
  }

  // 5. divide by the paper brightness (smooth upscale), then apply levels
  final result = Uint8List(w * h);
  for (int y = 0; y < h; y++) {
    final fy = ((y + 0.5) / cell - 0.5).clamp(0.0, sh - 1.0).toDouble();
    final y0 = fy.floor();
    final y1 = min(sh - 1, y0 + 1);
    final ty = fy - y0;
    for (int x = 0; x < w; x++) {
      final fx = ((x + 0.5) / cell - 0.5).clamp(0.0, sw - 1.0).toDouble();
      final x0 = fx.floor();
      final x1 = min(sw - 1, x0 + 1);
      final tx = fx - x0;
      final top = map[y0 * sw + x0] * (1 - tx) + map[y0 * sw + x1] * tx;
      final bot = map[y1 * sw + x0] * (1 - tx) + map[y1 * sw + x1] * tx;
      final bg = max(1.0, top * (1 - ty) + bot * ty);
      final v = min(255, (gray[y * w + x] * 255 / bg).round());
// mix: 55% cleaned + 45% original (after shadow removal)
      result[y * w + x] = (lut[v] * 0.55 + v * 0.45).round().clamp(0, 255).toInt();    }
  }

  // 6. very soft sharpen (no halos)
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      final i = y * w + x;
      int v;
      if (x == 0 || y == 0 || x == w - 1 || y == h - 1) {
        v = result[i];
      } else {
        final sum = result[i - 1] + result[i + 1] + result[i - w] + result[i + w];
        v = ((result[i] * 2.0) - sum * 0.25).round().clamp(0, 255).toInt();
      }
      d[i] = (0xff << 24) | (v << 16) | (v << 8) | v;
    }
  }
  return image;
}
/// Returns both versions (original and clear) of the cropped page.
Uint8List _encodeUnder(img.Image image, {int maxBytes = 900 * 1024}) {
  var current = image;
  int quality = 90;
  while (true) {
    final data = Uint8List.fromList(img.encodeJpg(current, quality: quality));
    if (data.length <= maxBytes || current.width < 500) return data;
    if (quality > 60) {
      quality -= 8; // first lower the quality
    } else {
      // then shrink the picture a little
      current = img.copyResize(current, width: (current.width * 0.85).round());
      quality = 75;
    }
  }
}
Map<String, Uint8List> _process(Map<String, dynamic> a) {
  final warped = _warp(
    a['bytes'] as Uint8List,
    (a['pts'] as List).cast<double>(),
    a['maxSide'] as double,
    a['turns'] as int,
  );
  final orig = Uint8List.fromList(img.encodeJpg(warped, quality: 92));
  final clear = Uint8List.fromList(img.encodeJpg(_clear(warped), quality: 92));
  return {'orig': orig, 'clear': clear};
}

// ========================== screen ==========================

class ScanEditPage extends StatefulWidget {
  final Map<String, dynamic> data; // from prepareScanImage
  const ScanEditPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ScanEditPage> createState() => _ScanEditPageState();
}

class _ScanEditPageState extends State<ScanEditPage> {
  late final Uint8List _bytes = widget.data['bytes'] as Uint8List;
  late final Uint8List _thumb = widget.data['thumb'] as Uint8List;
  late final Size _srcSize = Size(
    (widget.data['w'] as int).toDouble(),
    (widget.data['h'] as int).toDouble(),
  );
  int _turns = 0; // quarter turns, applied on screen only (instant)
  int _stage = 0; // 0 = crop, 1 = filter
  int _filter = 1;
  bool _cropMode = false;// 0 Original, 1 Clear
  bool _starting = false;
  bool _saving = false;
  bool _nextLoading = false;
  Map<String, Uint8List>? _preview;
  Future<Map<String, Uint8List>>? _full;

  Color get _primary => Theme.of(context).primaryColor;

  Size get _dispSize =>
      _turns.isOdd ? Size(_srcSize.height, _srcSize.width) : _srcSize;

  List<Offset> _pts = _fullPts(); // TL, TR, BR, BL (0..1)

  static List<Offset> _fullPts() => [
    const Offset(0, 0),
    const Offset(1, 0),
    const Offset(1, 1),
    const Offset(0, 1),
  ];

  static List<Offset> _insetPts() => [
    const Offset(0.04, 0.04),
    const Offset(0.96, 0.04),
    const Offset(0.96, 0.96),
    const Offset(0.04, 0.96),
  ];

  void _toggleCrop() {
    setState(() {
      _cropMode = !_cropMode;
      _pts = _cropMode ? _insetPts() : _fullPts();
    });
  }

  List<double> _flatPts() {
    final pts = <double>[];
    for (final p in _pts) {
      pts.add(p.dx);
      pts.add(p.dy);
    }
    return pts;
  }

  // instant: no image work, only turns the picture and the corners
  void _rotate() {
    Offset m(Offset o) => Offset(1 - o.dy, o.dx);
    setState(() {
      _turns = (_turns + 1) % 4;
      _pts = [m(_pts[3]), m(_pts[0]), m(_pts[1]), m(_pts[2])];
    });
  }

  Future<void> _next() async {
    if (_starting) return;
    _starting = true;
    setState(() => _nextLoading = true);
    try {
      final pts = _flatPts();
      final turns = _turns;

      // small preview (uses the small thumbnail, so it is fast)
      final preview = await compute(_process, {
        'bytes': _thumb, 'pts': pts, 'maxSide': 800.0, 'turns': turns,
      });
      if (!mounted) return;
      setState(() {
        _preview = preview;
        _stage = 1;
      });

      // full quality is prepared in the background while you view the preview
      _full = compute(_process, {
        'bytes': _bytes, 'pts': pts, 'maxSide': 2000.0, 'turns': turns,
      });
    } catch (e) {
      debugPrint("Scan crop error: $e");
    } finally {
      _starting = false;
      if (mounted) setState(() => _nextLoading = false);
    }
  }

  Future<void> _done() async {
    if (_saving || _full == null) return;
    setState(() => _saving = true);
    try {
      final res = await _full!;
      final data = _filter == 0 ? res['orig']! : res['clear']!;
      final dir = await getApplicationDocumentsDirectory();
      final file =
      File('${dir.path}/scan_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await file.writeAsBytes(data);
      final kb = data.length / 1024;
      debugPrint("SCAN SIZE: ${kb.toStringAsFixed(0)} KB "
          "(${(kb / 1024).toStringAsFixed(2)} MB) - ${_filter == 0 ? 'Original' : 'Clear'}");
      if (mounted) Navigator.pop(context, file.path);
    } catch (e) {
      debugPrint("Scan save error: $e");
      if (mounted) setState(() => _saving = false);
    }
  }

  ButtonStyle get _fillStyle => ElevatedButton.styleFrom(
    backgroundColor: _primary,
    foregroundColor: Colors.white,
  );

  ButtonStyle get _outlineStyle => OutlinedButton.styleFrom(
    foregroundColor: Colors.white,
    side: BorderSide(color: _primary, width: 1.5),
  );

  Widget _handle(int i, Offset pos, double w, double h) {
    return Positioned(
      left: pos.dx - 28,
      top: pos.dy - 28,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (d) => setState(() {
          final p = _pts[i];
          _pts[i] = Offset(
            (p.dx + d.delta.dx / w).clamp(0.0, 1.0).toDouble(),
            (p.dy + d.delta.dy / h).clamp(0.0, 1.0).toDouble(),
          );
        }),
        child: Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: _primary, width: 3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _edgeHandle(int a, int b, Offset pos, double w, double h) {
    return Positioned(
      left: pos.dx - 28,
      top: pos.dy - 28,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (d) => setState(() {
          final dx = d.delta.dx / w;
          final dy = d.delta.dy / h;
          for (final i in [a, b]) {
            final p = _pts[i];
            _pts[i] = Offset(
              (p.dx + dx).clamp(0.0, 1.0).toDouble(),
              (p.dy + dy).clamp(0.0, 1.0).toDouble(),
            );
          }
        }),
        child: Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, int value) {
    return ChoiceChip(
      label: Text(label),
      selected: _filter == value,
      selectedColor: _primary,
      backgroundColor: Colors.grey.shade900,
      labelStyle: const TextStyle(color: Colors.white),
      checkmarkColor: Colors.white,
      onSelected: (_) => setState(() => _filter = value),
    );
  }

  Widget _cropStage() {
    final ds = _dispSize;
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(builder: (context, box) {
            final scale = min(box.maxWidth / ds.width, box.maxHeight / ds.height);
            final w = ds.width * scale;
            final h = ds.height * scale;
            final ox = (box.maxWidth - w) / 2;
            final oy = (box.maxHeight - h) / 2;
            final pos =
            _pts.map((p) => Offset(ox + p.dx * w, oy + p.dy * h)).toList();

            return Stack(
              children: [
                Positioned(
                  left: ox,
                  top: oy,
                  width: w,
                  height: h,
                  child: RotatedBox(
                    quarterTurns: _turns,
                    child: Image.memory(_bytes,
                        fit: BoxFit.fill, gaplessPlayback: true),
                  ),
                ),
                if (_cropMode) ...[
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(painter: _QuadPainter(pos, _primary)),
                    ),
                  ),
                  for (int i = 0; i < 4; i++)
                    _edgeHandle(i, (i + 1) % 4,
                        Offset.lerp(pos[i], pos[(i + 1) % 4], 0.5)!, w, h),
                  for (int i = 0; i < 4; i++) _handle(i, pos[i], w, h),
                ],
              ],
            );
          }),
        ),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_cropMode)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Drag the round corners, or the square middle points to move a whole side",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: _outlineStyle,
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                  if (_cropMode) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: _outlineStyle,
                        onPressed: () => setState(() => _pts = _insetPts()),
                        child: const Text("Reset"),
                      ),
                    ),
                  ],
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: _fillStyle,
                      onPressed: _nextLoading ? null : _next,
                      child: _nextLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Next"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterStage() {
    final shown = _filter == 0 ? _preview!['orig']! : _preview!['clear']!;
    return Column(
      children: [
        Expanded(
          child: InteractiveViewer(
            maxScale: 5,
            child: Center(
              child: Image.memory(shown,
                  fit: BoxFit.contain, gaplessPlayback: true),
            ),
          ),
        ),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  _chip("Original", 0),
                  _chip("Clear", 1),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: _outlineStyle,
                      onPressed:
                      _saving ? null : () => setState(() => _stage = 0),
                      child: const Text("Back"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: _fillStyle,
                      onPressed: _saving ? null : _done,
                      child: _saving
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                          : const Text("Done"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_stage == 1) {
          setState(() => _stage = 0);
          return false;
        }
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: _primary,
            title: Text(_stage == 0 ? "Edit" : "Filter"),
            actions: [
              if (_stage == 0)
                IconButton(
                  icon: Icon(Icons.crop, color: _cropMode ? Colors.amber : Colors.white),
                  onPressed: _toggleCrop,
                ),
              if (_stage == 0)
                IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: _rotate,
                ),
            ],
          ),
          body: _stage == 0 ? _cropStage() : _filterStage(),
        ),
      ),
    );
  }
}

class _QuadPainter extends CustomPainter {
  final List<Offset> pts;
  final Color color;
  _QuadPainter(this.pts, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final quad = Path()
      ..moveTo(pts[0].dx, pts[0].dy)
      ..lineTo(pts[1].dx, pts[1].dy)
      ..lineTo(pts[2].dx, pts[2].dy)
      ..lineTo(pts[3].dx, pts[3].dy)
      ..close();
    final outside = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      quad,
    );
    canvas.drawPath(outside, Paint()..color = Colors.black54);
    canvas.drawPath(
      quad,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(covariant _QuadPainter old) => true;
}