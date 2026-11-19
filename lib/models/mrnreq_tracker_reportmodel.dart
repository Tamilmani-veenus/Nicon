// To parse this JSON data, do
//
//     final mrnReqTrackerListModel = mrnReqTrackerListModelFromJson(jsonString);

import 'dart:convert';

MrnReqTrackerListModel mrnReqTrackerListModelFromJson(
    String str, {
      String rptType = "",
    }) =>
    MrnReqTrackerListModel.fromJson(
      json.decode(str),
      rptType: rptType,
    );
String mrnReqTrackerListModelToJson(MrnReqTrackerListModel data) => json.encode(data.toJson());

class MrnReqTrackerListModel {
  bool? success;
  String? message;
  List<ReqTrackResult>? result;
  List<ProjectModel>? abstractResult;

  MrnReqTrackerListModel({
    this.success,
    this.message,
    this.result,
    this.abstractResult,
  });

  factory MrnReqTrackerListModel.fromJson(
      Map<String, dynamic> json, {
        String rptType = "",
      }) {
    if (rptType.toUpperCase() == "A") {
      // ABSTRACT API
      return MrnReqTrackerListModel(
        success: json["success"],
        message: json["message"],
        result: [],
        abstractResult: json["result"] == null
            ? []
            : List<ProjectModel>.from(
          json["result"].map((x) => ProjectModel.fromJson(x)),
        ),
      );
    } else {
      // DETAIL API
      return MrnReqTrackerListModel(
        success: json["success"],
        message: json["message"],
        abstractResult: [],
        result: json["result"] == null
            ? []
            : List<ReqTrackResult>.from(
          json["result"].map((x) => ReqTrackResult.fromJson(x)),
        ),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
    "abstractResult": abstractResult == null
        ? []
        : List<dynamic>.from(abstractResult!.map((x) => x.toJson())),
  };
}

class ReqTrackResult {
  String? projectName;
  String? siteName;
  String? mrnNo;
  int? sno;
  String? material;
  String? unit;
  double? reqQty;
  String? mrnDate;
  String? mrnTime;
  String? mrnPreparedBy;
  String? verifyDate;
  String? verifyTime;
  String? verifyBy;
  String? preAppovedDate;
  String? preApprovedTime;
  String? preApprovedBy;
  String? approveDate;
  String? approvedTime;
  String? approvedBy;
  double? appQty;
  String? poDate;
  String? poTime;
  String? poNo;
  double? poQty;
  String? poBy;
  String? poVerifyDate;
  String? poVerifyTime;
  String? poVerifyBy;
  String? poAppDate;
  String? poAppBy;
  String? poApprovedTime;
  String? invoiceDate;
  String? invoiceNo;
  int? inwardMasId;
  String? inwardDate;
  String? grnCreatedTime;
  String? inwardNo;
  double? inwQty;
  String? inwardBy;
  int? supplierQuoteMasId;
  String? quoteNo;
  String? mrnApproveType;
  String? quoteDate;
  int? quoteDetId;
  int? materialReqOrdDetId;
  int? materialId;
  int? quoteCreatedBy;
  String? quoteCreatedByName;
  String? quoteCreatedDate;
  String? quoteCreatedTime;
  String? quoteVerifyStatus;
  String? quoteVerifyDate;
  String? quoteVerifyTime;
  int? quoteVerifyBy;
  String? quoteVerifyByName;
  String? quoteApproveStatus;
  String? quoteApproveDate;
  String? quoteApprovedTime;
  String? quoteApprovedByName;
  int? quoteApproveBy;
  String? mrnVerifyStatus;
  String? mrnPreApproveStatus;
  String? mrnApproveStatus;
  String? poVerifyStatus;
  String? poApproveStatus;

  ReqTrackResult({
    this.projectName,
    this.siteName,
    this.mrnNo,
    this.sno,
    this.material,
    this.unit,
    this.reqQty,
    this.mrnDate,
    this.mrnTime,
    this.mrnPreparedBy,
    this.verifyDate,
    this.verifyTime,
    this.verifyBy,
    this.preAppovedDate,
    this.preApprovedTime,
    this.preApprovedBy,
    this.approveDate,
    this.mrnApproveType,
    this.approvedTime,
    this.approvedBy,
    this.appQty,
    this.poDate,
    this.poTime,
    this.poNo,
    this.poQty,
    this.poBy,
    this.poVerifyDate,
    this.poVerifyTime,
    this.poApprovedTime,
    this.poVerifyBy,
    this.poAppDate,
    this.poAppBy,
    this.invoiceDate,
    this.invoiceNo,
    this.inwardMasId,
    this.inwardDate,
    this.grnCreatedTime,
    this.inwardNo,
    this.inwQty,
    this.inwardBy,
    this.supplierQuoteMasId,
    this.quoteNo,
    this.quoteDate,
    this.quoteDetId,
    this.materialReqOrdDetId,
    this.materialId,
    this.quoteCreatedBy,
    this.quoteCreatedByName,
    this.quoteCreatedDate,
    this.quoteCreatedTime,
    this.quoteVerifyTime,
    this.quoteVerifyStatus,
    this.quoteVerifyDate,
    this.quoteVerifyBy,
    this.quoteVerifyByName,
    this.quoteApproveStatus,
    this.quoteApproveDate,
    this.quoteApproveBy,
    this.quoteApprovedTime,
    this.quoteApprovedByName,
    this.mrnVerifyStatus,
    this.mrnPreApproveStatus,
    this.mrnApproveStatus,
    this.poVerifyStatus,
    this.poApproveStatus,
  });

  factory ReqTrackResult.fromJson(Map<String, dynamic> json) => ReqTrackResult(
    projectName: json["projectName"],
    siteName: json["siteName"],
    mrnNo: json["mrnNo"],
    sno: json["sno"],
    material: json["material"],
    unit: json["unit"],
    reqQty: json["reqQty"],
    mrnDate: json["mrnDate"],
    mrnTime: json["mrnTime"],
    mrnPreparedBy: json["mrnPreparedBy"],
    mrnApproveType: json["mrnApproveType"],
    verifyDate: json["verifyDate"],
    verifyTime: json["verifyTime"],
    verifyBy: json["verifyBy"],
    preAppovedDate: json["preAppovedDate"],
    preApprovedTime: json["preApprovedTime"],
    preApprovedBy: json["preApprovedBy"],
    approveDate: json["approveDate"],
    approvedTime: json["approvedTime"],
    approvedBy: json["approvedBy"],
    appQty: json["appQty"],
    poDate: json["poDate"],
    poTime: json["poTime"],
    poNo: json["poNo"],
    poQty: json["poQty"],
    poBy: json["poBy"],
    poVerifyDate: json["poVerifyDate"],
    poVerifyTime: json["poVerifyTime"],
    poVerifyBy: json["poVerifyBy"],
    poAppDate: json["poAppDate"],
    poApprovedTime: json["poApprovedTime"],
    poAppBy: json["poAppBy"],
    invoiceDate: json["invoiceDate"],
    invoiceNo: json["invoiceNo"],
    inwardMasId: json["inwardMasID"],
    inwardDate: json["inwardDate"],
    inwardNo: json["inwardNo"],
    grnCreatedTime: json["grnCreatedTime"],
    inwQty: json["inwQty"],
    inwardBy: json["inwardBy"],
    supplierQuoteMasId: json["supplierQuoteMasId"],
    quoteNo: json["quoteNo"],
    quoteDate: json["quoteDate"],
    quoteDetId: json["quoteDetId"],
    materialReqOrdDetId: json["materialReqOrdDetId"],
    materialId: json["materialId"],
    quoteCreatedBy: json["quoteCreatedBy"],
    quoteCreatedByName: json["quoteCreatedByName"],
    quoteCreatedDate: json["quoteCreatedDate"],
    quoteCreatedTime: json["quoteCreatedTime"],
    quoteVerifyStatus: json["quoteVerifyStatus"],
    quoteVerifyDate: json["quoteVerifyDate"],
    quoteVerifyByName: json["quoteVerifyByName"],
    quoteVerifyBy: json["quoteVerifyBy"],
    quoteVerifyTime: json["quoteVerifyTime"],
    quoteApproveStatus: json["quoteApproveStatus"],
    quoteApproveDate: json["quoteApproveDate"],
    quoteApprovedTime: json["quoteApprovedTime"],
    quoteApprovedByName: json["quoteApprovedByName"],
    quoteApproveBy: json["quoteApproveBy"],
    mrnVerifyStatus: json["mrnVerifyStatus"],
    mrnPreApproveStatus: json["mrnPreApproveStatus"],
    mrnApproveStatus: json["mrnApproveStatus"],
    poVerifyStatus: json["poVerifyStatus"],
    poApproveStatus: json["poApproveStatus"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "siteName": siteName,
    "mrnNo": mrnNo,
    "sno": sno,
    "material": material,
    "unit": unit,
    "reqQty": reqQty,
    "mrnDate": mrnDate,
    "mrnTime": mrnTime,
    "mrnPreparedBy": mrnPreparedBy,
    "verifyDate": verifyDate,
    "verifyTime": verifyTime,
    "verifyBy": verifyBy,
    "preAppovedDate": preAppovedDate,
    "preApprovedTime": preApprovedTime,
    "mrnApproveType": mrnApproveType,
    "preApprovedBy": preApprovedBy,
    "poApprovedTime": poApprovedTime,
    "approveDate": approveDate,
    "approvedTime": approvedTime,
    "grnCreatedTime": grnCreatedTime,
    "approvedBy": approvedBy,
    "appQty": appQty,
    "poDate": poDate,
    "poTime": poTime,
    "poNo": poNo,
    "poQty": poQty,
    "poBy": poBy,
    "poVerifyDate": poVerifyDate,
    "poVerifyTime": poVerifyTime,
    "poVerifyBy": poVerifyBy,
    "poAppDate": poAppDate,
    "poAppBy": poAppBy,
    "invoiceDate": invoiceDate,
    "invoiceNo": invoiceNo,
    "inwardMasID": inwardMasId,
    "inwardDate": inwardDate,
    "inwardNo": inwardNo,
    "inwQty": inwQty,
    "inwardBy": inwardBy,
    "supplierQuoteMasId": supplierQuoteMasId,
    "quoteNo": quoteNo,
    "quoteDate": quoteDate,
    "quoteDetId": quoteDetId,
    "materialReqOrdDetId": materialReqOrdDetId,
    "materialId": materialId,
    "quoteCreatedBy": quoteCreatedBy,
    "quoteCreatedByName": quoteCreatedByName,
    "quoteCreatedDate": quoteCreatedDate,
    "quoteCreatedTime": quoteCreatedTime,
    "quoteVerifyStatus": quoteVerifyStatus,
    "quoteVerifyByName": quoteVerifyByName,
    "quoteApprovedTime": quoteApprovedTime,
    "quoteApprovedByName": quoteApprovedByName,
    "quoteVerifyDate": quoteVerifyDate,
    "quoteVerifyTime": quoteVerifyTime,
    "quoteVerifyBy": quoteVerifyBy,
    "quoteApproveStatus": quoteApproveStatus,
    "quoteApproveDate": quoteApproveDate,
    "quoteApproveBy": quoteApproveBy,
    "mrnVerifyStatus": mrnVerifyStatus,
    "mrnPreApproveStatus": mrnPreApproveStatus,
    "mrnApproveStatus": mrnApproveStatus,
    "poVerifyStatus": poVerifyStatus,
    "poApproveStatus": poApproveStatus,
  };
}

class ProjectModel {
  String? projectName;
  List<SiteModel>? siteName;

  ProjectModel({
    this.projectName,
    this.siteName,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectName: json['projectName'],
      siteName: (json['siteName'] as List?)
          ?.map((e) => SiteModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'siteName': siteName?.map((e) => e.toJson()).toList(),
    };
  }
}

class SiteModel {
  String? siteName;
  List<TransferModel>? transfers;

  SiteModel({
    this.siteName,
    this.transfers,
  });

  factory SiteModel.fromJson(Map<String, dynamic> json) {
    return SiteModel(
      siteName: json['siteName'],
      transfers: (json['transfers'] as List?)
          ?.map((e) => TransferModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'siteName': siteName,
      'transfers': transfers?.map((e) => e.toJson()).toList(),
    };
  }
}

class TransferModel {
  String? reqordno;
  String? reqorddate;
  String? mrnPreparedby;
  String? indentVerifydate;
  String? mrnVerifydate;
  String? mrnVerifyTime;
  String? mrnVerifiedBy;
  String? indentPreApproveDate;
  String? mrnPreApproveDate;
  String? mrnPreApproveTime;
  String? mrnPreApprovedby;
  String? indentApproveDate;
  String? mrnApprovedDate;
  String? mrnApprovedTime;
  String? mrnApprovedBy;
  String? purchaseOrdNo;
  String? purchaseOrdDate;
  String? poPreparedby;
  String? purchaseApprovedDate;
  String? poApprovedDate;
  String? poApprovedTime;
  String? poApprovedBy;
  String? inwardno;
  String? invoicedate;
  String? invoiceno;
  String? inwPreparedby;
  String? billNo;
  String? billEntryDate;
  String? billApproveBy;
  String? purBillApproveDate;
  String? billApprovedDt;
  String? billApprovedTime;
  String? billcreatedByName;
  String? billApprovedBYName;
  String? transferId;
  String? matReqMasId;
  String? transferNo;
  String? transferApproveStatus;
  String? transApproveDateTime;
  String? transferApprovedDt;
  String? transferApprovedTime;
  String? transferApprovedBy;
  String? transferCreatedBy;
  String? transCreatedDateTime;
  String? transferCreatedDt;
  String? transferCreatedTime;
  String? transferCreateBy;
  String? transferApproveName;
  String? quoteNo;
  String? quoteCreatedBy;
  String? quoteApprovedBy;
  String? quoteApproveDateTime;
  String? quoteApprovedDt;
  String? quoteApprovedTime;
  String? quoteApproveStatus;
  String? quoteCreatedName;
  String? quoteApproveName;

  TransferModel({
    this.reqordno,
    this.reqorddate,
    this.mrnPreparedby,
    this.indentVerifydate,
    this.mrnVerifydate,
    this.mrnVerifyTime,
    this.mrnVerifiedBy,
    this.indentPreApproveDate,
    this.mrnPreApproveDate,
    this.mrnPreApproveTime,
    this.mrnPreApprovedby,
    this.indentApproveDate,
    this.mrnApprovedDate,
    this.mrnApprovedTime,
    this.mrnApprovedBy,
    this.purchaseOrdNo,
    this.purchaseOrdDate,
    this.poPreparedby,
    this.purchaseApprovedDate,
    this.poApprovedDate,
    this.poApprovedTime,
    this.poApprovedBy,
    this.inwardno,
    this.invoicedate,
    this.invoiceno,
    this.inwPreparedby,
    this.billNo,
    this.billEntryDate,
    this.billApproveBy,
    this.purBillApproveDate,
    this.billApprovedDt,
    this.billApprovedTime,
    this.billcreatedByName,
    this.billApprovedBYName,
    this.transferId,
    this.matReqMasId,
    this.transferNo,
    this.transferApproveStatus,
    this.transApproveDateTime,
    this.transferApprovedDt,
    this.transferApprovedTime,
    this.transferApprovedBy,
    this.transferCreatedBy,
    this.transCreatedDateTime,
    this.transferCreatedDt,
    this.transferCreatedTime,
    this.transferCreateBy,
    this.transferApproveName,
    this.quoteNo,
    this.quoteCreatedBy,
    this.quoteApprovedBy,
    this.quoteApproveDateTime,
    this.quoteApprovedDt,
    this.quoteApprovedTime,
    this.quoteApproveStatus,
    this.quoteCreatedName,
    this.quoteApproveName,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      reqordno: json['reqordno'],
      reqorddate: json['reqorddate'],
      mrnPreparedby: json['mrnPreparedby'],
      indentVerifydate: json['indentVerifydate'],
      mrnVerifydate: json['mrnVerifydate'],
      mrnVerifyTime: json['mrnVerifyTime'],
      mrnVerifiedBy: json['mrnVerifiedBy'],
      indentPreApproveDate: json['indentPreApproveDate'],
      mrnPreApproveDate: json['mrnPreApproveDate'],
      mrnPreApproveTime: json['mrnPreApproveTime'],
      mrnPreApprovedby: json['mrnPreApprovedby'],
      indentApproveDate: json['indentApproveDate'],
      mrnApprovedDate: json['mrnApprovedDate'],
      mrnApprovedTime: json['mrnApprovedTime'],
      mrnApprovedBy: json['mrnApprovedBy'],
      purchaseOrdNo: json['purchaseOrdNo'],
      purchaseOrdDate: json['purchaseOrdDate'],
      poPreparedby: json['poPreparedby'],
      purchaseApprovedDate: json['purchaseApprovedDate'],
      poApprovedDate: json['poApprovedDate'],
      poApprovedTime: json['poApprovedTime'],
      poApprovedBy: json['poApprovedBy'],
      inwardno: json['inwardno'],
      invoicedate: json['invoicedate'],
      invoiceno: json['invoiceno'],
      inwPreparedby: json['inwPreparedby'],
      billNo: json['billNo'],
      billEntryDate: json['billEntryDate'],
      billApproveBy: json['billApproveBy'],
      purBillApproveDate: json['purBillApproveDate'],
      billApprovedDt: json['billApprovedDt'],
      billApprovedTime: json['billApprovedTime'],
      billcreatedByName: json['billcreatedByName'],
      billApprovedBYName: json['billApprovedBYName'],
      transferId: json['transferId']?.toString(),
      matReqMasId: json['matReqMasId']?.toString(),
      transferNo: json['transferNo'],
      transferApproveStatus: json['transferApproveStatus'],
      transApproveDateTime: json['transApproveDateTime'],
      transferApprovedDt: json['transferApprovedDt'],
      transferApprovedTime: json['transferApprovedTime'],
      transferApprovedBy: json['transferApprovedBy'],
      transferCreatedBy: json['transferCreatedBy'],
      transCreatedDateTime: json['transCreatedDateTime'],
      transferCreatedDt: json['transferCreatedDt'],
      transferCreatedTime: json['transferCreatedTime'],
      transferCreateBy: json['transferCreateBy'],
      transferApproveName: json['transferApproveName'],
      quoteNo: json['quoteNo'],
      quoteCreatedBy: json['quoteCreatedBy'],
      quoteApprovedBy: json['quoteApprovedBy'],
      quoteApproveDateTime: json['quoteApproveDateTime'],
      quoteApprovedDt: json['quoteApprovedDt'],
      quoteApprovedTime: json['quoteApprovedTime'],
      quoteApproveStatus: json['quoteApproveStatus'],
      quoteCreatedName: json['quoteCreatedName'],
      quoteApproveName: json['quoteApproveName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reqordno': reqordno,
      'reqorddate': reqorddate,
      'mrnPreparedby': mrnPreparedby,
      'indentVerifydate': indentVerifydate,
      'mrnVerifydate': mrnVerifydate,
      'mrnVerifyTime': mrnVerifyTime,
      'mrnVerifiedBy': mrnVerifiedBy,
      'indentPreApproveDate': indentPreApproveDate,
      'mrnPreApproveDate': mrnPreApproveDate,
      'mrnPreApproveTime': mrnPreApproveTime,
      'mrnPreApprovedby': mrnPreApprovedby,
      'indentApproveDate': indentApproveDate,
      'mrnApprovedDate': mrnApprovedDate,
      'mrnApprovedTime': mrnApprovedTime,
      'mrnApprovedBy': mrnApprovedBy,
      'purchaseOrdNo': purchaseOrdNo,
      'purchaseOrdDate': purchaseOrdDate,
      'poPreparedby': poPreparedby,
      'purchaseApprovedDate': purchaseApprovedDate,
      'poApprovedDate': poApprovedDate,
      'poApprovedTime': poApprovedTime,
      'poApprovedBy': poApprovedBy,
      'inwardno': inwardno,
      'invoicedate': invoicedate,
      'invoiceno': invoiceno,
      'inwPreparedby': inwPreparedby,
      'billNo': billNo,
      'billEntryDate': billEntryDate,
      'billApproveBy': billApproveBy,
      'purBillApproveDate': purBillApproveDate,
      'billApprovedDt': billApprovedDt,
      'billApprovedTime': billApprovedTime,
      'billcreatedByName': billcreatedByName,
      'billApprovedBYName': billApprovedBYName,
      'transferId': transferId,
      'matReqMasId': matReqMasId,
      'transferNo': transferNo,
      'transferApproveStatus': transferApproveStatus,
      'transApproveDateTime': transApproveDateTime,
      'transferApprovedDt': transferApprovedDt,
      'transferApprovedTime': transferApprovedTime,
      'transferApprovedBy': transferApprovedBy,
      'transferCreatedBy': transferCreatedBy,
      'transCreatedDateTime': transCreatedDateTime,
      'transferCreatedDt': transferCreatedDt,
      'transferCreatedTime': transferCreatedTime,
      'transferCreateBy': transferCreateBy,
      'transferApproveName': transferApproveName,
      'quoteNo': quoteNo,
      'quoteCreatedBy': quoteCreatedBy,
      'quoteApprovedBy': quoteApprovedBy,
      'quoteApproveDateTime': quoteApproveDateTime,
      'quoteApprovedDt': quoteApprovedDt,
      'quoteApprovedTime': quoteApprovedTime,
      'quoteApproveStatus': quoteApproveStatus,
      'quoteCreatedName': quoteCreatedName,
      'quoteApproveName': quoteApproveName,
    };
  }
}

