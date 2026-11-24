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
    mrnDate: json["mrnDate"] ?? json["mrnCreatedDate"],
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

  // MRN
  String? mrnCreatedDate;
  String? mrnCreatedTime;
  String? mrnPreparedby;
  String? mrnVerifydate;
  String? mrnVerifyTime;
  String? mrnVerifiedBy;
  String? mrnVerifyStatus;
  String? mrnPreApproveStatus;
  String? mrnApproveStatus;
  String? mrnPreApproveDate;
  String? mrnPreApproveTime;
  String? mrnPreApprovedby;
  String? mrnApprovedDate;
  String? mrnApprovedTime;
  String? mrnApprovedBy;
  String? mrnApproveType;

  // Quote
  String? quoteNo;
  String? quoteCreatedName;
  String? quoteCreatedDate;
  String? quoteCreatedTime;
  String? quoteVerifyByName;
  String? quoteVerifyDate;
  String? quoteVerifyTime;
  String? quoteVerifyStatus;
  String? quoteApproveName;
  String? quoteApprovedDt;
  String? quoteApprovedTime;
  String? quoteApproveStatus;

  // PO
  String? purchaseOrdNo;
  String? poCreatedDate;
  String? poTime;
  String? poPreparedby;
  String? poVerifyById;
  String? poVerifyDate;
  String? poVerifyTime;
  String? poVerifyStatus;
  String? poApprovedDate;
  String? poApprovedTime;
  String? poApprovedBy;
  String? poApproveStatus;

  // Inward / GRN
  String? grnCreatedDate;
  String? grnCreatedTime;
  String? inwardno; // not in your sample, see note below
  String? inwardDate; // not in your sample, see note below
  String? inwPreparedby; // not in your sample, see note below
  String? invoiceno; // not in your sample, see note below

  TransferModel({
    this.reqordno,
    this.mrnCreatedDate,
    this.mrnCreatedTime,
    this.mrnPreparedby,
    this.mrnVerifydate,
    this.mrnVerifyTime,
    this.mrnVerifiedBy,
    this.mrnVerifyStatus,
    this.mrnPreApproveStatus,
    this.mrnApproveStatus,
    this.mrnPreApproveDate,
    this.mrnPreApproveTime,
    this.mrnPreApprovedby,
    this.mrnApprovedDate,
    this.mrnApprovedTime,
    this.mrnApprovedBy,
    this.mrnApproveType,
    this.quoteNo,
    this.quoteCreatedName,
    this.quoteCreatedDate,
    this.quoteCreatedTime,
    this.quoteVerifyByName,
    this.quoteVerifyDate,
    this.quoteVerifyTime,
    this.quoteVerifyStatus,
    this.quoteApproveName,
    this.quoteApprovedDt,
    this.quoteApprovedTime,
    this.quoteApproveStatus,
    this.purchaseOrdNo,
    this.poCreatedDate,
    this.poTime,
    this.poPreparedby,
    this.poVerifyById,
    this.poVerifyDate,
    this.poVerifyTime,
    this.poVerifyStatus,
    this.poApprovedDate,
    this.poApprovedTime,
    this.poApprovedBy,
    this.poApproveStatus,
    this.grnCreatedDate,
    this.grnCreatedTime,
    this.inwardno,
    this.inwardDate,
    this.inwPreparedby,
    this.invoiceno,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      reqordno: json['reqordno'],
      mrnCreatedDate: json['mrnCreatedDate'],
      mrnCreatedTime: json['mrnCreatedTime'],
      mrnPreparedby: json['mrnPreparedby'],
      mrnVerifydate: json['mrnVerifydate'],
      mrnVerifyTime: json['mrnVerifyTime'],
      mrnVerifiedBy: json['mrnVerifiedBy'],
      mrnVerifyStatus: json['mrnVerifyStatus'],
      mrnPreApproveStatus: json['mrnPreApproveStatus'],
      mrnApproveStatus: json['mrnApproveStatus'],
      mrnPreApproveDate: json['mrnPreApproveDate'],
      mrnPreApproveTime: json['mrnPreApproveTime'],
      mrnPreApprovedby: json['mrnPreApprovedby'],
      mrnApprovedDate: json['mrnApprovedDate'],
      mrnApprovedTime: json['mrnApprovedTime'],
      mrnApprovedBy: json['mrnApprovedBy'],
      mrnApproveType: json['mrnApproveType'],
      quoteNo: json['quoteNo'],
      quoteCreatedName: json['quoteCreatedName'],
      quoteCreatedDate: json['quoteCreatedDate'],
      quoteCreatedTime: json['quoteCreatedTime'],
      quoteVerifyByName: json['quoteVerifyByName'],
      quoteVerifyDate: json['quoteVerifyDate'],
      quoteVerifyTime: json['quoteVerifyTime'],
      quoteVerifyStatus: json['quoteVerifyStatus'],
      quoteApproveName: json['quoteApproveName'],
      quoteApprovedDt: json['quoteApprovedDt'],
      quoteApprovedTime: json['quoteApprovedTime'],
      quoteApproveStatus: json['quoteApproveStatus'],
      purchaseOrdNo: json['purchaseOrdNo'],
      poCreatedDate: json['poCreatedDate'],
      poTime: json['poTime'],
      poPreparedby: json['poPreparedby'],
      poVerifyById: json['poVerifyById'],
      poVerifyDate: json['poVerifyDate'],
      poVerifyTime: json['poVerifyTime'],
      poVerifyStatus: json['poVerifyStatus'],
      poApprovedDate: json['poApprovedDate'],
      poApprovedTime: json['poApprovedTime'],
      poApprovedBy: json['poApprovedBy'],
      poApproveStatus: json['poApproveStatus'],
      grnCreatedDate: json['grnCreatedDate'],
      grnCreatedTime: json['grnCreatedTime'],
      inwardno: json['inwardno'],
      inwardDate: json['inwardDate'],
      inwPreparedby: json['inwPreparedby'],
      invoiceno: json['invoiceno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reqordno': reqordno,
      'mrnCreatedDate': mrnCreatedDate,
      'mrnCreatedTime': mrnCreatedTime,
      'mrnPreparedby': mrnPreparedby,
      'mrnVerifydate': mrnVerifydate,
      'mrnVerifyTime': mrnVerifyTime,
      'mrnVerifiedBy': mrnVerifiedBy,
      'mrnVerifyStatus': mrnVerifyStatus,
      'mrnPreApproveStatus': mrnPreApproveStatus,
      'mrnApproveStatus': mrnApproveStatus,
      'mrnPreApproveDate': mrnPreApproveDate,
      'mrnPreApproveTime': mrnPreApproveTime,
      'mrnPreApprovedby': mrnPreApprovedby,
      'mrnApprovedDate': mrnApprovedDate,
      'mrnApprovedTime': mrnApprovedTime,
      'mrnApprovedBy': mrnApprovedBy,
      'mrnApproveType': mrnApproveType,
      'quoteNo': quoteNo,
      'quoteCreatedName': quoteCreatedName,
      'quoteCreatedDate': quoteCreatedDate,
      'quoteCreatedTime': quoteCreatedTime,
      'quoteVerifyByName': quoteVerifyByName,
      'quoteVerifyDate': quoteVerifyDate,
      'quoteVerifyTime': quoteVerifyTime,
      'quoteVerifyStatus': quoteVerifyStatus,
      'quoteApproveName': quoteApproveName,
      'quoteApprovedDt': quoteApprovedDt,
      'quoteApprovedTime': quoteApprovedTime,
      'quoteApproveStatus': quoteApproveStatus,
      'purchaseOrdNo': purchaseOrdNo,
      'poCreatedDate': poCreatedDate,
      'poTime': poTime,
      'poPreparedby': poPreparedby,
      'poVerifyById': poVerifyById,
      'poVerifyDate': poVerifyDate,
      'poVerifyTime': poVerifyTime,
      'poVerifyStatus': poVerifyStatus,
      'poApprovedDate': poApprovedDate,
      'poApprovedTime': poApprovedTime,
      'poApprovedBy': poApprovedBy,
      'poApproveStatus': poApproveStatus,
      'grnCreatedDate': grnCreatedDate,
      'grnCreatedTime': grnCreatedTime,
      'inwardno': inwardno,
      'inwardDate': inwardDate,
      'inwPreparedby': inwPreparedby,
      'invoiceno': invoiceno,
    };
  }
}