// To parse this JSON data, do
//
//     final machinerySaveModel = machinerySaveModelFromJson(jsonString);

import 'dart:convert';

MachinerySaveModel machinerySaveModelFromJson(String str) => MachinerySaveModel.fromJson(json.decode(str));

String machinerySaveModelToJson(MachinerySaveModel data) => json.encode(data.toJson());

class MachinerySaveModel {
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
  String? updatedDate;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDate;
  String? approveRemarks;
  String? approveStatus;
  int? approveBy;
  String? approveDate;
  int? preApproveBy;
  String? preApproveStatus;
  String? preApproveDate;
  bool? isEdit;
  List<MachineryReqOrdDetLink>? machineryReqOrdDetLink;

  MachinerySaveModel({
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
    this.isEdit,
    this.machineryReqOrdDetLink,
  });

  factory MachinerySaveModel.fromJson(Map<String, dynamic> json) => MachinerySaveModel(
    id: json["id"],
    reqOrdNo: json["reqOrdNo"],
    reqOrdDate: json["reqOrdDate"],
    reqDueDate: json["reqDueDate"],
    requestType: json["requestType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
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
    isEdit: json["isEdit"],
    machineryReqOrdDetLink: List<MachineryReqOrdDetLink>.from(json["machineryReqOrdDetLink"].map((x) => MachineryReqOrdDetLink.fromJson(x))),
  );

  Map<String, dynamic> toJson()  {
  final data = {
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
    "isEdit": isEdit,
    "machineryReqOrdDetLink":machineryReqOrdDetLink?.map((x) => x.toJson()).toList(),
  };

  data.removeWhere((key, value) => value == null);
  return data;
  }
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
  double? stockQty;
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
    this.stockQty,
    this.balQty,
  });

  factory MachineryReqOrdDetLink.fromJson(Map<String, dynamic> json) =>
      MachineryReqOrdDetLink(
        id: json["id"],
        machineryReqOrdMasid: json["machineryReqOrdMasid"],
        materialId: json["machineryId"],
        scaleId: json["scaleID"],
        reqQty: json["reqQty"],
        qty: json["qty"],
        remarks: json["remarks"],
        reqDesc: json["reqDesc"],
        stockQty: json["stockQty"],
        balQty: json["balQty"],
      );

  Map<String, dynamic> toJson()  {

  final data = {
    "id": id,
    "machineryReqOrdMasid": machineryReqOrdMasid,
    "machineryId": materialId,
    "scaleID": scaleId,
    "reqQty": reqQty,
    "qty": qty,
    "remarks": remarks,
    "reqDesc": reqDesc,
    "stockQty": stockQty,
    "balQty": balQty,
  };

  data.removeWhere((key, value) => value == null);
  return data;
}
}
