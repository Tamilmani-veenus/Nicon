import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controller/dailyentries_controller.dart';
import '../../controller/dailywrk_done_dpr_controller.dart';
import '../../controller/dailywrk_done_dprnew_controller.dart';
import '../../controller/inward_pending_controller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/sitevoucher_controller.dart';
import '../../controller/staffvoucher_controller.dart';
import '../../utilities/baseutitiles.dart';
import 'package:image/image.dart' as img;

import 'doc_test.dart';

class CameraCapturePage extends StatefulWidget {
  final String fromScreen;
  const CameraCapturePage({Key? key,required this.fromScreen}) : super(key: key);

  @override
  _CameraCapturePageState createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> with WidgetsBindingObserver {
  PunchInController punchInController = Get.put(PunchInController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  SiteVoucher_Controller siteVoucher_Controller = Get.put(SiteVoucher_Controller());
  InwardPending_Controller inwardPendingcontroller = Get.put(InwardPending_Controller());
  StaffVoucher_Controller staffVoucher_Controller =
  Get.put(StaffVoucher_Controller());
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;
  bool initial = false;
  int? newlyAddedIndex;
  bool _isCameraBusy = false;
  bool isFrontCamera = false;
  bool _isScanning = false;
  bool _scanMode = false;
  bool get _showScan => widget.fromScreen != "Punch In" && widget.fromScreen != "Punch Out";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissionAndInitCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  Future<void> _disposeCamera() async {
    final old = _controller;
    _controller = null;
    _initializeControllerFuture = null;
    if (mounted) setState(() {});      // 1. remove CameraPreview from the tree first
    await old?.dispose();              // 2. then dispose
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_isScanning) return;
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      if (_controller != null) await _disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller == null && !initial) await _initCamera();
    }
  }

  void _addImageToController(File file) {
    if(widget.fromScreen=="Subcontractor Attendance"){
      dailyEntriesController.imageFiles.add(file);
      newlyAddedIndex = dailyEntriesController.imageFiles.length - 1;
    }
    else if(widget.fromScreen=="DPR"){
      dailyWrkDone_DPR_Controller.imageFiles.add(file);
      newlyAddedIndex = dailyWrkDone_DPR_Controller.imageFiles.length - 1;
    }
    else if(widget.fromScreen=="DPR-NEW"){
      dailyWrkDone_DPRNEW_Controller.imageFiles.add(file);
      newlyAddedIndex = dailyWrkDone_DPRNEW_Controller.imageFiles.length - 1;
    }
    else if(widget.fromScreen=="Site Voucher"){
      siteVoucher_Controller.imageFiles.add(file);
      newlyAddedIndex = siteVoucher_Controller.imageFiles.length - 1;
    }
    else if(widget.fromScreen=="Staff Voucher"){
      staffVoucher_Controller.imageFiles.add(file);
      newlyAddedIndex = staffVoucher_Controller.imageFiles.length - 1;
    }
    else if(widget.fromScreen=="Inward"){
      inwardPendingcontroller.checkImgList.value = true;
      inwardPendingcontroller.imageFiles.add(file);
      newlyAddedIndex = inwardPendingcontroller.imageFiles.length - 1;
      inwardPendingcontroller.count = inwardPendingcontroller.count + 1;
      inwardPendingcontroller.pickedImageCount.value++;
    }
    else if(widget.fromScreen=="InwardAddButton"){
      inwardPendingcontroller.imageFiles.add(file);
      newlyAddedIndex = inwardPendingcontroller.imageFiles.length - 1;
      inwardPendingcontroller.count = inwardPendingcontroller.count + 1;
      inwardPendingcontroller.pickedImageCount.value++;
    }
  }

  /// Scan inside the app (no external scanner screen)
  Future<void> scanInApp() async {
    if (_isCameraBusy || _controller == null || !_controller!.value.isInitialized) return;

    // size of the preview box on screen, and of the camera picture
    final boxW = MediaQuery.sizeOf(context).width;
    final boxH = BaseUtitiles.getheightofPercentage(context, 65).toDouble();
    final ps = _controller!.value.previewSize!;
    final camAspect = ps.height / ps.width; // portrait
    final boxAspect = boxW / boxH;

    // part of the photo that is visible in the preview (BoxFit.cover)
    double vl = 0, vt = 0, vr = 1, vb = 1;
    if (boxAspect > camAspect) {
      final f = camAspect / boxAspect;
      vt = (1 - f) / 2;
      vb = 1 - vt;
    } else {
      final f = boxAspect / camAspect;
      vl = (1 - f) / 2;
      vr = 1 - vl;
    }
    // the guide frame is 3% to 97% of the preview box
    final cl = vl + (vr - vl) * 0.03;
    final cr = vl + (vr - vl) * 0.97;
    final ct = vt + (vb - vt) * 0.03;
    final cb = vt + (vb - vt) * 0.97;

    setState(() => _isCameraBusy = true);
    try {
      final shot = await _controller!.takePicture();

      final prepared = await compute(prepareScanImage, {
        'path': shot.path,
        'l': cl, 't': ct, 'r': cr, 'b': cb,
      });
      if (!mounted) return;

      final String? result = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (_) => ScanEditPage(data: prepared)),
      );

      if (result != null) {
        _addImageToController(File(result));
        if (mounted) Navigator.pop(context, "Camera");
        return;
      }
    } catch (e, s) {
      debugPrint("scanInApp error: $e\n$s");
    } finally {
      if (mounted) setState(() => _isCameraBusy = false);
    }
  }

  Future<File> addWatermark(File originalFile, {required bool flip}) async {
    final bytes = await originalFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes);

    if (image == null) return originalFile;

    if (flip) {
      image = img.flipHorizontal(image);
    }

    final text = punchInController.networkTime ?? DateTime.now().toString();

    img.drawString(
      image,
      img.arial_48,
      40,
      image.height - 280,
      text,
      color: img.getColor(255, 255, 255),
    );

    final newPath = originalFile.path.replaceFirst('.jpg', '_wm.jpg');
    final newFile = File(newPath)
      ..writeAsBytesSync(img.encodeJpg(image, quality: 85));

    return newFile;
  }

  Future<void> _checkPermissionAndInitCamera() async {
    try {
      final permissionStatus = await Permission.camera.status;

      if (permissionStatus.isDenied) {
        await Permission.camera.request();
      }

      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception("No camera available");
      }

      // Temporary camera to trigger iOS permission popup.
      final tempController = CameraController(
        cameras.first,
        ResolutionPreset.low,
        enableAudio: false,
      );

      try {
        await tempController.initialize();
      } finally {
        await tempController.dispose();
      }

      if (!mounted) return;

      // Initialize your actual camera.
      await _initCamera();

    } catch (e, s) {
      debugPrint("Camera permission error: $e\n$s");

      if (mounted) {
        BaseUtitiles.showToast("Camera permission is required");
        Navigator.pop(context);
      }
    }
  }


  Future<void> _toggleScan() async {
    final turningOn = !_scanMode;
    setState(() => _scanMode = turningOn);
    if (turningOn && isFrontCamera) {
      final back =
      cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);
      if (back != -1) {
        selectedCameraIndex = back;
        await _disposeCamera();
        await _initCamera();
      }
    }
  }

  Future<void> _initCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras.isEmpty || !mounted) {
        debugPrint("No camera available");
        return;
      }

      if (selectedCameraIndex >= cameras.length) {
        selectedCameraIndex = 0;
      }

      punchInController.getNetworkTime();

      final selectedCamera = cameras[selectedCameraIndex];

      isFrontCamera =
          selectedCamera.lensDirection == CameraLensDirection.front;

      _controller = CameraController(
        selectedCamera,
        ResolutionPreset.ultraHigh,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      _initializeControllerFuture = _controller!.initialize();

      await _initializeControllerFuture;
      try {
        await _controller!.setFocusMode(FocusMode.auto);
      } catch (_) {}

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  void _switchCamera() async {
    if (cameras.length < 2) return;

    selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;

    await _disposeCamera();
    await _initCamera();
  }

  Future<void> takePicture() async {
    if (_isCameraBusy || _controller == null || !_controller!.value.isInitialized) return;

    setState(() => _isCameraBusy = true);

    try {
      await _controller!.setFlashMode(FlashMode.off);

      final image = await _controller!.takePicture();

      final appDir = await getApplicationDocumentsDirectory();
      final targetPath =
          '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        image.path,
        targetPath,
        quality: 80,
        minWidth: 1000,
        minHeight: 1000,
        format: CompressFormat.jpeg,
      );

      if (compressedFile == null) {
        debugPrint('Compression failed.');
        return;
      }

      final originalKb = (await File(image.path).length()) / 1024;
      final compressedKb = (await File(compressedFile.path).length()) / 1024;

      final watermarkedFile = await addWatermark(
        File(compressedFile.path),
        flip: isFrontCamera,
      );

      final finalKb = (await watermarkedFile.length()) / 1024;
      debugPrint("NORMAL SIZE: camera=${originalKb.toStringAsFixed(0)} KB, "
          "compressed=${compressedKb.toStringAsFixed(0)} KB, "
          "final(watermarked)=${finalKb.toStringAsFixed(0)} KB "
          "(${(finalKb / 1024).toStringAsFixed(2)} MB)");
      if (!mounted) return;

      setState(() {
        initial = true;
        if (widget.fromScreen == "Punch In") {
          punchInController.isSelect.value = true;
          punchInController.imageFile.value = XFile(watermarkedFile.path);
        } else if (widget.fromScreen == "Punch Out") {
          punchInController.isSelect.value = true;
          punchInController.punchOutImageFile.value = XFile(watermarkedFile.path);
        } else {
          _addImageToController(watermarkedFile);
        }
      });
    } catch (e, s) {
      debugPrint("Error taking picture: $e\n$s");
    } finally {
      if (mounted) setState(() => _isCameraBusy = false);
    }
  }

  Future<void> takePictures() async {
    if (_isCameraBusy) return;

    setState(() => _isCameraBusy = true);

    try {
      await _initializeControllerFuture;
      await _controller!.setFlashMode(FlashMode.off);

      final image = await _controller!.takePicture();

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final originalFile = File(image.path);

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        '${appDir.path}/$fileName',
        quality: 80,
        minWidth: 1000,
        minHeight: 1000,
      );


      if (compressedFile == null) {
        debugPrint('Compression failed.');
        return;
      }

      final watermarkedFile = await addWatermark(
        File(compressedFile.path),
        flip: isFrontCamera,
      );

      setState(() {
        initial = true;
        if(widget.fromScreen=="Punch In"){
          punchInController.isSelect.value = true;
          punchInController.imageFile.value = XFile(watermarkedFile.path);
        }
        else if(widget.fromScreen=="Punch Out"){
          punchInController.isSelect.value = true;
          punchInController.punchOutImageFile.value = XFile(watermarkedFile.path);
        }
        else if(widget.fromScreen=="Subcontractor Attendance"){
          dailyEntriesController.imageFiles.add(watermarkedFile);
          newlyAddedIndex = dailyEntriesController.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="DPR"){
          dailyWrkDone_DPR_Controller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = dailyWrkDone_DPR_Controller.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="DPR-NEW"){
          dailyWrkDone_DPRNEW_Controller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = dailyWrkDone_DPRNEW_Controller.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="Site Voucher"){
          siteVoucher_Controller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = siteVoucher_Controller.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="Staff Voucher"){
          staffVoucher_Controller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = staffVoucher_Controller.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="Inward"){
          inwardPendingcontroller.checkImgList.value = true;
          inwardPendingcontroller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = inwardPendingcontroller.imageFiles.length - 1;
          inwardPendingcontroller.count = inwardPendingcontroller.count + 1;
          inwardPendingcontroller.pickedImageCount.value++;
        }
        else if(widget.fromScreen=="InwardAddButton"){
          inwardPendingcontroller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = inwardPendingcontroller.imageFiles.length - 1;
          inwardPendingcontroller.count = inwardPendingcontroller.count + 1;
          inwardPendingcontroller.pickedImageCount.value++;
        }
      });
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
    finally {
      setState(() => _isCameraBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return SizedBox( );
    }

    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async {
        if (widget.fromScreen == "Punch In") {
          punchInController.isSelect.value = false;
          punchInController.imageFile.value = null;
        }
        else if (widget.fromScreen == "Punch Out") {
          punchInController.isSelect.value = false;
          punchInController.punchOutImageFile.value = null;
        }
        else if (widget.fromScreen == "Subcontractor Attendance" && newlyAddedIndex != null) {
          dailyEntriesController.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "DPR" && newlyAddedIndex != null) {
          dailyWrkDone_DPR_Controller.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "DPR-NEW" && newlyAddedIndex != null) {
          dailyWrkDone_DPRNEW_Controller.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Site Voucher" && newlyAddedIndex != null) {
          siteVoucher_Controller.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Staff Voucher" && newlyAddedIndex != null) {
          staffVoucher_Controller.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Inward"  && newlyAddedIndex != null ) {
          inwardPendingcontroller.checkImgList.value = false;
          inwardPendingcontroller.imageFiles.removeAt(newlyAddedIndex!);
          inwardPendingcontroller.count = inwardPendingcontroller.count - 1;
          inwardPendingcontroller.pickedImageCount.value--;
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Inward"  && newlyAddedIndex == null ) {
          inwardPendingcontroller.checkImgList.value = false;
        }
        else if ( widget.fromScreen == "InwardAddButton"  && newlyAddedIndex != null ) {
          inwardPendingcontroller.imageFiles.removeAt(newlyAddedIndex!);
          inwardPendingcontroller.count = inwardPendingcontroller.count - 1;
          inwardPendingcontroller.pickedImageCount.value--;
          newlyAddedIndex = null;
        }
        return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("Camera"),
          ),
          body: Column(
            children: [
              if (initial == false)
                Column(
                  children: [
                    Container(
                      height: BaseUtitiles.getheightofPercentage(context, 65),
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FutureBuilder(
                            future: _initializeControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done &&
                                  _controller != null &&
                                  _controller!.value.isInitialized) {
                                return FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: _controller!.value.previewSize!.height,
                                    height: _controller!.value.previewSize!.width,
                                    child: CameraPreview(_controller!),
                                  ),
                                );
                              }
                              return const SizedBox();
                              },
                          ),
                          if (_scanMode)
                            IgnorePointer(
                                child: CustomPaint(
                                    painter: _ScanGuidePainter()
                                )
                            ),
                          if (_scanMode)
                            Positioned(
                              left: 16,
                              right: 16,
                              bottom: 12,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Fit the page in the frame",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _showScan
                              ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                              backgroundColor: Colors.black,
                              elevation: 4,
                            ),
                            onPressed: _isCameraBusy ? null : _toggleScan,
                            child: Icon(_scanMode ? Icons.close : Icons.document_scanner, size: 24),
                          )
                              : const SizedBox(),
                        ),

                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 4,
                            ),
                            onPressed: _isCameraBusy ? null : (_scanMode ? scanInApp : takePicture),
                            child: _isCameraBusy
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Icon(Icons.camera_alt, size: 24),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),                  // makes it round
                              padding: const EdgeInsets.all(18),            // controls size
                              backgroundColor: Colors.black,
                              elevation: 4,
                            ),
                            onPressed: (_isCameraBusy || _scanMode) ? null : _switchCamera,
                            child: const Icon(Icons.flip_camera_ios_sharp, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if(initial == true )...{
                if ((widget.fromScreen == "Punch In" && punchInController.imageFile.value != null) ||
                    (widget.fromScreen == "Punch Out" && punchInController.punchOutImageFile.value != null) ||
                    (widget.fromScreen == "Subcontractor Attendance" && dailyEntriesController.imageFiles != null) ||
                    (widget.fromScreen == "DPR" && dailyWrkDone_DPR_Controller.imageFiles.isNotEmpty) ||
                    (widget.fromScreen == "DPR-NEW" && dailyWrkDone_DPRNEW_Controller.imageFiles.isNotEmpty) ||
                    (widget.fromScreen == "Site Voucher" && siteVoucher_Controller.imageFiles.isNotEmpty) ||
                    (widget.fromScreen == "Staff Voucher" && staffVoucher_Controller.imageFiles.isNotEmpty) ||
                   ((widget.fromScreen == "Inward" || widget.fromScreen == "InwardAddButton" ) && inwardPendingcontroller.imageFiles.isNotEmpty))

              Column(
                    children: [
                      Builder(builder: (_) {
                        XFile? selectedImage;

                        if (widget.fromScreen == "Punch In") {
                          selectedImage = punchInController.imageFile.value;
                        }
                        else if (widget.fromScreen == "Punch Out") {
                          selectedImage = punchInController.punchOutImageFile.value;
                        }
                        else if(widget.fromScreen == "Subcontractor Attendance") {
                          if (dailyEntriesController.imageFiles.isNotEmpty) {
                            selectedImage = XFile(dailyEntriesController.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "DPR") {
                          if (dailyWrkDone_DPR_Controller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(dailyWrkDone_DPR_Controller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "DPR-NEW") {
                          if (dailyWrkDone_DPRNEW_Controller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(dailyWrkDone_DPRNEW_Controller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "Site Voucher") {
                          if (siteVoucher_Controller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(siteVoucher_Controller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "Staff Voucher") {
                          if (staffVoucher_Controller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(staffVoucher_Controller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "Inward" || widget.fromScreen == "InwardAddButton") {
                          if (inwardPendingcontroller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(inwardPendingcontroller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        if (selectedImage == null) {
                          return const SizedBox();
                        }
                        return Container(
                          height: BaseUtitiles.getheightofPercentage(
                              context, 65),
                          width: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.file(
                              File(selectedImage.path),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: MediaQuery
                          .sizeOf(context)
                          .height * 0.05,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor, // 🔹 Button background color
                            ),
                            onPressed: () {
                              setState(() {
                                initial = false;
                                if (widget.fromScreen == "Punch In"){
                                  punchInController.imageFile.value = null;
                                }
                                else if (widget.fromScreen == "Punch Out"){
                                  punchInController.punchOutImageFile.value = null;
                                }
                                else if (widget.fromScreen == "Subcontractor Attendance" && newlyAddedIndex != null) {
                                  dailyEntriesController.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if (widget.fromScreen == "DPR" && newlyAddedIndex != null) {
                                  dailyWrkDone_DPR_Controller.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if (widget.fromScreen == "DPR-NEW" && newlyAddedIndex != null) {
                                  dailyWrkDone_DPRNEW_Controller.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if (widget.fromScreen == "Site Voucher" && newlyAddedIndex != null) {
                                  siteVoucher_Controller.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if ((widget.fromScreen == "Inward" || widget.fromScreen == "InwardAddButton" ) && newlyAddedIndex != null) {
                                  inwardPendingcontroller.imageFiles.removeAt(newlyAddedIndex!);
                                  inwardPendingcontroller.count = inwardPendingcontroller.count - 1;
                                  inwardPendingcontroller.pickedImageCount.value--;
                                  newlyAddedIndex = null;
                                }
                              });
                              _initCamera();
                            },
                            child: const Text("Retry"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context, "Camera");
                              });
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ],
                  ),
              },
        
              if (cameras.length > 1 && initial == false)
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios_sharp),
                  onPressed: _switchCamera,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanGuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      size.width * 0.03,
      size.height * 0.03,
      size.width * 0.94,
      size.height * 0.94,
    );
    final outside = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8))),
    );
    canvas.drawPath(outside, Paint()..color = Colors.black38);

    final p = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    const len = 28.0;
    for (final c in [
      [rect.topLeft, 1.0, 1.0],
      [rect.topRight, -1.0, 1.0],
      [rect.bottomLeft, 1.0, -1.0],
      [rect.bottomRight, -1.0, -1.0],
    ]) {
      final o = c[0] as Offset;
      final sx = c[1] as double;
      final sy = c[2] as double;
      canvas.drawLine(o, o + Offset(len * sx, 0), p);
      canvas.drawLine(o, o + Offset(0, len * sy), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}