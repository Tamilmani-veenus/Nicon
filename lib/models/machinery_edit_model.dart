// To parse this JSON data, do
//
//     final machineryEditModel = machineryEditModelFromJson(jsonString);

import 'dart:convert';

MachineryEditModel machineryEditModelFromJson(String str) => MachineryEditModel.fromJson(json.decode(str));

String machineryEditModelToJson(MachineryEditModel data) => json.encode(data.toJson());

class MachineryEditModel {
  bool? success;
  String? message;
  Result? result;

  MachineryEditModel({
    this.success,
    this.message,
    this.result,
  });

  factory MachineryEditModel.fromJson(Map<String, dynamic> json) => MachineryEditModel(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  int? id;
  String? reqOrdNo;
  String? reqOrdDate;
  String? reqDueDate;
  String? requestType;
  int? projectId;
  int? siteId;
  String? reqRemarks;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  dynamic updatedDate;
  int? verifyBy;
  String? verifyStatus;
  dynamic verifyDate;
  String? approveRemarks;
  String? approveStatus;
  int? approveBy;
  dynamic approveDate;
  int? preApproveBy;
  String? preApproveStatus;
  dynamic preApproveDate;
  String? projectName;
  String? siteName;
  String? createdByName;
  dynamic updatedByName;
  dynamic verifyByName;
  dynamic approveByName;
  dynamic preApproveByName;
  bool? isEdit;
  List<MachineryReqOrdDetLink>? machineryReqOrdDetLink;

  Result({
   this.id,
   this.reqOrdNo,
   this.reqOrdDate,
   this.reqDueDate,
   this.requestType,
   this.projectId,
   this.siteId,
   this.reqRemarks,
   this.createdBy,
   this.createdDt,
   this.updatedBy,
   this.updatedDate,
   this.verifyBy,
   this.verifyStatus,
   this.verifyDate,
   this.approveRemarks,
   this.approveStatus,
   this.approveBy,
   this.approveDate,
   this.preApproveBy,
   this.preApproveStatus,
   this.preApproveDate,
   this.projectName,
   this.siteName,
   this.createdByName,
   this.updatedByName,
   this.verifyByName,
   this.approveByName,
   this.preApproveByName,
   this.isEdit,
   this.machineryReqOrdDetLink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    reqOrdNo: json["reqOrdNo"],
    reqOrdDate: json["reqOrdDate"],
    reqDueDate: json["reqDueDate"] ?? json["reqdueDate"],
    requestType: json["requestType"],
    projectId: json["projectId"] ?? json["projectID"],
    siteId: json["siteId"] ?? json["siteID"],
    reqRemarks: json["reqRemarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDate: json["updatedDate"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDate: json["verifyDate"],
    approveRemarks: json["approveRemarks"],
    approveStatus: json["approveStatus"],
    approveBy: json["approveBy"],
    approveDate: json["approveDate"],
    preApproveBy: json["preApproveBy"],
    preApproveStatus: json["preApproveStatus"],
    preApproveDate: json["preApproveDate"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    createdByName: json["createdByName"] ?? json["createdName"],
    updatedByName: json["updatedByName"],
    verifyByName: json["verifyByName"],
    approveByName: json["approveByName"],
    preApproveByName: json["preApproveByName"],
    isEdit: json["isEdit"],
    machineryReqOrdDetLink: List<MachineryReqOrdDetLink>.from(json["machineryReqOrdDetLink"].map((x) => MachineryReqOrdDetLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reqOrdNo": reqOrdNo,
    "reqOrdDate": reqOrdDate,
    "reqDueDate": reqDueDate,
    "requestType": requestType,
    "projectId": projectId,
    "siteId": siteId,
    "reqRemarks": reqRemarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDate": updatedDate,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDate": verifyDate,
    "approveRemarks": approveRemarks,
    "approveStatus": approveStatus,
    "approveBy": approveBy,
    "approveDate": approveDate,
    "preApproveBy": preApproveBy,
    "preApproveStatus": preApproveStatus,
    "preApproveDate": preApproveDate,
    "projectName": projectName,
    "siteName": siteName,
    "createdByName": createdByName,
    "updatedByName": updatedByName,
    "verifyByName": verifyByName,
    "approveByName": approveByName,
    "preApproveByName": preApproveByName,
    "isEdit": isEdit,
    "machineryReqOrdDetLink": List<dynamic>.from(machineryReqOrdDetLink!.map((x) => x.toJson())),
  };
}

class MachineryReqOrdDetLink {
  int? id;
  int? machineryReqOrdMasid;
  int? materialId;
  int? scaleId;
  double? reqQty;
  double? qty;
  String? remarks;
  String? reqDesc;
  String? scaleName;
  String? materialName;
  int? stockQty;
  double? balQty;

  MachineryReqOrdDetLink({
    this.id,
    this.machineryReqOrdMasid,
    this.materialId,
    this.scaleId,
    this.reqQty,
    this.qty,
    this.remarks,
    this.reqDesc,
    this.scaleName,
    this.materialName,
    this.stockQty,
    this.balQty,
  });

  factory MachineryReqOrdDetLink.fromJson(Map<String, dynamic> json) => MachineryReqOrdDetLink(
    id: json["id"],
    machineryReqOrdMasid: json["machineryReqOrdMasid"],
    materialId: json["machineryId"],
    scaleId: json["scaleID"],
    reqQty: json["reqQty"],
    qty: json["qty"],
    remarks: json["remarks"],
    reqDesc: json["reqDesc"] ?? json["description"],
    scaleName: json["scaleName"],
    materialName: json["machineryName"] ?? json["materialName"],
    stockQty: json["stockQty"],
    balQty: json["balQty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "machineryReqOrdMasid": machineryReqOrdMasid,
    "machineryId": materialId,
    "scaleID": scaleId,
    "reqQty": reqQty,
    "qty": qty,
    "remarks": remarks,
    "reqDesc": reqDesc,
    "scaleName": scaleName,
    "machineryName": materialName,
    "stockQty": stockQty,
    "balQty": balQty,
  };
}
