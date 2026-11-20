import '../../app_theme/app_colors.dart';
import 'package:nicon/models/mrnreq_tracker_reportmodel.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';

class mrnReqTrackerPopup extends StatelessWidget {
  mrnReqTrackerPopup(
      {Key? key, required this.list, required this.approvalLevelList})
      : super(key: key);
  final ReqTrackResult list;
  final List approvalLevelList;

  @override
  Widget build(BuildContext context) {
    final trackerSteps = [
      {
        "title": "MRN Made",
        "date": list.mrnDate,
        "time": list.mrnTime,
        "by": list.mrnPreparedBy,
      },
      if (approvalLevelList.length > 0 &&
          approvalLevelList[0]["isVerification"] == true)
        {
          "title": "MRN Verified",
          "date": list.verifyDate,
          "time": list.verifyTime,
          "by": list.verifyBy,
        },
      if (approvalLevelList.length > 0 &&
          approvalLevelList[0]["isPreApproval"] == true)
        {
          "title": "MRN Pre-Approved",
          "date": list.preAppovedDate,
          "time": list.preApprovedTime,
          "by": list.preApprovedBy,
        },
      if (approvalLevelList.length > 0 &&
          approvalLevelList[0]["isApproval"] == true)
        {
          "title": "MRN Final Approved",
          "date": list.approveDate,
          "time": list.approvedTime,
          "by": list.approvedBy,
        },
      if (list.quoteNo != "-" && list.mrnApproveType=="Q")...[
        {
          "title": "Quote Made",
          "date": list.quoteCreatedDate,
          "time": list.quoteCreatedTime,
          "by": list.quoteCreatedByName,
        },
        if (approvalLevelList.length > 5 &&
            approvalLevelList[5]["isVerification"] == true)
          {
            "title": "Quote Verified",
            "date": list.quoteVerifyDate,
            "time": list.quoteVerifyTime,
            "by": list.quoteVerifyByName,
          },
        if (approvalLevelList.length > 5 &&
            approvalLevelList[5]["isApproval"] == true)
          {
            "title": "Quote Approved",
            "date": list.quoteApproveDate,
            "time": list.quoteApprovedTime,
            "by": list.quoteApprovedByName,
          }
      ],
      {
        "title": "PO Made",
        "date": list.poDate,
        "time": list.poTime,
        "by": list.poBy,
      },
      if (approvalLevelList.length > 1 &&
          approvalLevelList[1]["isVerification"] == true)
        {
          "title": "PO Verified",
          "date": list.poVerifyDate,
          "time": list.poVerifyTime,
          "by": list.poVerifyBy,
        },
      if (approvalLevelList.length > 1 &&
          approvalLevelList[1]["isApproval"] == true)
        {
          "title": "PO Approved",
          "date": list.poAppDate,
          "time": list.poApprovedTime,
          "by": list.poAppBy,
        },
      {
        "title": "Inward",
        "date": list.inwardDate,
        "time": list.grnCreatedTime,
        "by": list.inwardBy,
      }
    ];

    return AlertDialog(
      backgroundColor: Setmybackground,
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
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
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10), blurRadius: 3, color: Colors.white),
              ],
            ),
            child: Text("MRN - Request Tracker",
                style: TextStyle(color: Colors.white))),

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

                    // MRN Header
                    Text(
                      list.mrnNo.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Material Name + Unit
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: list.material.toString(),
                          ),
                          TextSpan(
                            text: " (${list.unit})",
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),

                    const SizedBox(height: 10),

                    // Tracker Steps
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: trackerSteps.asMap().entries.map((entry) {
                            final index = entry.key;
                            final step = entry.value;
                            final isLast = index == trackerSteps.length - 1;

                            final isCancelled = (
                                step["title"] == "PO Made" ||
                                    step["title"] == "Inward" ||
                                    list.mrnVerifyStatus != "Y" ||
                                    list.mrnPreApproveStatus != "Y" ||
                                    list.mrnApproveStatus != "Y" ||
                                    list.poVerifyStatus != "Y" ||
                                    list.poApproveStatus != "Y" ||
                                    list.quoteVerifyStatus != "Y" ||
                                    list.quoteApproveStatus != "Y"
                            ) &&
                                step["date"] == "-" &&
                                (step["time"] == "-" || step["time"] == "") &&
                                (step["by"] == "-" || step["by"] == "");

                            return IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Timeline
                                    Column(
                                      children: [
                                        Icon(
                                          isCancelled
                                              ? Icons.cancel
                                              : Icons.check_circle,
                                          color: isCancelled
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

                                    // Content
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              step["title"]!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),

                                            const SizedBox(height: 5),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${step["date"] ?? "-"}",
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${step["time"] ?? "-"}",
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            if (step["by"] != null &&
                                                step["by"]
                                                    .toString()
                                                    .isNotEmpty &&
                                                step["by"] != "-")
                                              Text(
                                                "By : ${step["by"]}",
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                ),
                                              ),
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
        )

      ]),
    );
  }
}

class MrnReqTrackerAbstractPopup extends StatelessWidget {
  const MrnReqTrackerAbstractPopup({Key? key, required this.transfer})
      : super(key: key);

  final TransferModel transfer;

  // returns null for empty or "-" values
  String? _c(String? v) {
    final s = v?.trim();
    return (s == null || s.isEmpty || s == "-") ? null : s;
  }

  @override
  Widget build(BuildContext context) {
    final t = transfer;

    // required: always shown, red cross if no data. Others show only when they have data.
    final steps = <Map<String, dynamic>>[
      {
        "title": "MRN Made",
        "date": t.reqorddate,
        "by": t.mrnPreparedby,
        "required": true,
      },
      {
        "title": "MRN Verified",
        "date": t.mrnVerifydate ?? t.indentVerifydate,
        "time": t.mrnVerifyTime,
        "by": t.mrnVerifiedBy,
      },
      {
        "title": "MRN Pre-Approved",
        "date": t.mrnPreApproveDate ?? t.indentPreApproveDate,
        "time": t.mrnPreApproveTime,
        "by": t.mrnPreApprovedby,
      },
      {
        "title": "MRN Final Approved",
        "date": t.mrnApprovedDate ?? t.indentApproveDate,
        "time": t.mrnApprovedTime,
        "by": t.mrnApprovedBy,
      },
      {
        "title": "Quote Made",
        "no": t.quoteNo,
        "by": t.quoteCreatedName ?? t.quoteCreatedBy,
      },
      {
        "title": "Quote Approved",
        "date": t.quoteApprovedDt,
        "time": t.quoteApprovedTime,
        "by": t.quoteApproveName ?? t.quoteApprovedBy,
      },
      {
        "title": "PO Made",
        "no": t.purchaseOrdNo,
        "date": t.purchaseOrdDate,
        "by": t.poPreparedby,
        "required": true,
      },
      {
        "title": "PO Approved",
        "date": t.poApprovedDate ?? t.purchaseApprovedDate,
        "time": t.poApprovedTime,
        "by": t.poApprovedBy,
      },
      {
        "title": "Inward",
        "no": t.inwardno,
        "date": t.invoicedate,
        "by": t.inwPreparedby,
        "extra": t.invoiceno == null ? null : "Invoice No : ${t.invoiceno}",
        "required": true,
      },
    ].where((s) {
      final hasData = ["no", "date", "time", "by"].any((k) => _c(s[k]) != null);
      return hasData || s["required"] == true;
    }).toList();

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (t.reqordno ?? "").trim(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: steps.asMap().entries.map((entry) {
                            final index = entry.key;
                            final step = entry.value;
                            final isLast = index == steps.length - 1;

                            final no = _c(step["no"]);
                            final date = _c(step["date"]);
                            final time = _c(step["time"]);
                            final by = _c(step["by"]);
                            final extra = _c(step["extra"]);
                            final isCancelled =
                                no == null && date == null && by == null;

                            return IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          isCancelled
                                              ? Icons.cancel
                                              : Icons.check_circle,
                                          color: isCancelled
                                              ? Colors.red
                                              : Colors.green,
                                          size: 22,
                                        ),
                                        if (!isLast)
                                          Container(
                                            width: 2,
                                            height: 45,
                                            color: Colors.grey.shade400,
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
                                              step["title"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            if (no != null)
                                              Text(
                                                "$no".trim(),
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 13),
                                              ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    date ?? "-",
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    time ?? "-",
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (extra != null)
                                              Text(
                                                extra,
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 13),
                                              ),
                                            if (by != null)
                                              Text(
                                                "By : $by",
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 13),
                                              ),
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