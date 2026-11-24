import '../../app_theme/app_colors.dart';
import 'package:nicon/models/mrnreq_tracker_reportmodel.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';

class TrackerStep {
  final String title;
  final String? no, date, time, by, extra;
  final bool isCancelled;
  const TrackerStep({
    required this.title,
    this.no,
    this.date,
    this.time,
    this.by,
    this.extra,
    this.isCancelled = false,
  });
}

// returns null for empty or "-" values
String? _c(dynamic v) {
  final s = v?.toString().trim();
  return (s == null || s.isEmpty || s == "-") ? null : s;
}

class MrnReqTrackerPopup extends StatelessWidget {
  const MrnReqTrackerPopup._({
    Key? key,
    required this.header,
    required this.steps,
    this.material,
    this.unit,
  }) : super(key: key);

  final String header;
  final String? material;
  final String? unit;
  final List<TrackerStep> steps;

  // ---------------------------------------------------------------
  // 1) From ReqTrackResult (your existing logic, unchanged)
  // ---------------------------------------------------------------
  factory MrnReqTrackerPopup.fromTrack({
    Key? key,
    required ReqTrackResult list,
    required List approvalLevelList,
  }) {
    bool level(int i, String k) =>
        approvalLevelList.length > i && approvalLevelList[i][k] == true;

    bool anyStatusNotY() =>
        list.mrnVerifyStatus != "Y" ||
            list.mrnPreApproveStatus != "Y" ||
            list.mrnApproveStatus != "Y" ||
            list.poVerifyStatus != "Y" ||
            list.poApproveStatus != "Y" ||
            list.quoteVerifyStatus != "Y" ||
            list.quoteApproveStatus != "Y";

    TrackerStep step(String title, dynamic date, dynamic time, dynamic by) {
      final d = _c(date), t = _c(time), b = _c(by);
      final cancelled = (title == "PO Made" || title == "Inward" || anyStatusNotY()) &&
          d == null &&
          t == null &&
          b == null;
      return TrackerStep(
          title: title, date: d, time: t, by: b, isCancelled: cancelled);
    }

    final steps = <TrackerStep>[
      step("MRN Made", list.mrnDate, list.mrnTime, list.mrnPreparedBy),
      if (level(0, "isVerification"))
        step("MRN Verified", list.verifyDate, list.verifyTime, list.verifyBy),
      if (level(0, "isPreApproval"))
        step("MRN Pre-Approved", list.preAppovedDate, list.preApprovedTime,
            list.preApprovedBy),
      if (level(0, "isApproval"))
        step("MRN Final Approved", list.approveDate, list.approvedTime,
            list.approvedBy),
      if (list.quoteNo != "-" && list.mrnApproveType == "Q") ...[
        step("Quote Made", list.quoteCreatedDate, list.quoteCreatedTime,
            list.quoteCreatedByName),
        if (level(5, "isVerification"))
          step("Quote Verified", list.quoteVerifyDate, list.quoteVerifyTime,
              list.quoteVerifyByName),
        if (level(5, "isApproval"))
          step("Quote Approved", list.quoteApproveDate, list.quoteApprovedTime,
              list.quoteApprovedByName),
      ],
      step("PO Made", list.poDate, list.poTime, list.poBy),
      if (level(1, "isVerification"))
        step("PO Verified", list.poVerifyDate, list.poVerifyTime,
            list.poVerifyBy),
      if (level(1, "isApproval"))
        step("PO Approved", list.poAppDate, list.poApprovedTime, list.poAppBy),
      step("Inward", list.inwardDate, list.grnCreatedTime, list.inwardBy),
    ];

    return MrnReqTrackerPopup._(
      key: key,
      header: (list.mrnNo ?? "").toString().trim(),
      material: list.material?.toString(),
      unit: list.unit?.toString(),
      steps: steps,
    );
  }

  // ---------------------------------------------------------------
  // 2) From TransferModel (abstract screen)
  // ---------------------------------------------------------------
  factory MrnReqTrackerPopup.fromTransfer({
    Key? key,
    required TransferModel transfer,
    List approvalLevelList = const [],
    String? material,
    String? unit,
  }) {
    final t = transfer;

    bool level(int i, String k) =>
        approvalLevelList.length > i && approvalLevelList[i][k] == true;

    bool enabled(int i, String k, List<dynamic> values) =>
        approvalLevelList.isNotEmpty
            ? level(i, k)
            : values.any((v) => _c(v) != null);

    TrackerStep step(String title,
        {dynamic no, dynamic date, dynamic time, dynamic by, dynamic extra}) {
      final n = _c(no), d = _c(date), tm = _c(time), b = _c(by);
      return TrackerStep(
        title: title,
        no: n,
        date: d,
        time: tm,
        by: b,
        extra: _c(extra),
        isCancelled: n == null && d == null && tm == null && b == null,
      );
    }

    final mv = [t.mrnVerifydate, t.mrnVerifyTime, t.mrnVerifiedBy];
    final mp = [t.mrnPreApproveDate, t.mrnPreApproveTime, t.mrnPreApprovedby];
    final ma = [t.mrnApprovedDate, t.mrnApprovedTime, t.mrnApprovedBy];
    final qv = [t.quoteVerifyDate, t.quoteVerifyTime, t.quoteVerifyByName];
    final qa = [t.quoteApprovedDt, t.quoteApprovedTime, t.quoteApproveName];
    final pv = [t.poVerifyDate, t.poVerifyTime, t.poVerifyById];
    final pa = [t.poApprovedDate, t.poApprovedTime, t.poApprovedBy];

    final steps = <TrackerStep>[
      step("MRN Made",
          date: t.mrnCreatedDate, time: t.mrnCreatedTime, by: t.mrnPreparedby),
      if (enabled(0, "isVerification", mv))
        step("MRN Verified", date: mv[0], time: mv[1], by: mv[2]),
      if (enabled(0, "isPreApproval", mp))
        step("MRN Pre-Approved", date: mp[0], time: mp[1], by: mp[2]),
      if (enabled(0, "isApproval", ma))
        step("MRN Final Approved", date: ma[0], time: ma[1], by: ma[2]),
      if (_c(t.quoteNo) != null) ...[
        step("Quote Made",
            no: t.quoteNo,
            date: t.quoteCreatedDate,
            time: t.quoteCreatedTime,
            by: t.quoteCreatedName),
        if (enabled(5, "isVerification", qv))
          step("Quote Verified", date: qv[0], time: qv[1], by: qv[2]),
        if (enabled(5, "isApproval", qa))
          step("Quote Approved", date: qa[0], time: qa[1], by: qa[2]),
      ],
      step("PO Made",
          no: t.purchaseOrdNo,
          date: t.poCreatedDate,
          time: t.poTime,
          by: t.poPreparedby),
      if (enabled(1, "isVerification", pv))
        step("PO Verified", date: pv[0], time: pv[1], by: pv[2]),
      if (enabled(1, "isApproval", pa))
        step("PO Approved", date: pa[0], time: pa[1], by: pa[2]),
      step("Inward",
          no: t.inwardno,
          date: t.inwardDate ?? t.grnCreatedDate,
          time: t.grnCreatedTime,
          by: t.inwPreparedby),
    ];

    return MrnReqTrackerPopup._(
      key: key,
      header: (t.reqordno ?? "").trim(),
      material: material,
      unit: unit,
      steps: steps,
    );
  }

  // ---------------------------------------------------------------
  // Shared UI
  // ---------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    const detailStyle = TextStyle(color: Colors.black54, fontSize: 12);

    return AlertDialog(
      backgroundColor: Setmybackground,
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack(children: <Widget>[
        Container(
          height: BaseUtitiles.getheightofPercentage(context, 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 10), blurRadius: 3, color: Colors.white),
            ],
          ),
          child: const Text("MRN - Request Tracker",
              style: TextStyle(color: Colors.white)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          width: BaseUtitiles.getWidthtofPercentage(context, 80),
          height: BaseUtitiles.getheightofPercentage(context, 58),
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_c(material) != null) ...[
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(text: material),
                            if (_c(unit) != null)
                              TextSpan(
                                text: " ($unit)",
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    Divider(height: 1, color: Colors.grey.shade200),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: steps.asMap().entries.map((entry) {
                            final s = entry.value;
                            final isLast = entry.key == steps.length - 1;

                            return IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          s.isCancelled
                                              ? Icons.cancel
                                              : Icons.check_circle,
                                          color: s.isCancelled
                                              ? Colors.red
                                              : Colors.green,
                                          size: 22,
                                        ),
                                        if (!isLast)
                                          Container(
                                            width: 2,
                                            height: 45,
                                            color: Colors.grey.shade300,
                                          ),
                                      ],
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              s.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            if (s.no != null)
                                              Text(s.no!, style: detailStyle),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(s.date ?? "-",
                                                        style: detailStyle)),
                                                Expanded(
                                                    child: Text(s.time ?? "-",
                                                        style: detailStyle)),
                                              ],
                                            ),
                                            if (s.extra != null)
                                              Text(s.extra!,
                                                  style: detailStyle),
                                            if (s.by != null)
                                              Text("By : ${s.by}",
                                                  style: detailStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}