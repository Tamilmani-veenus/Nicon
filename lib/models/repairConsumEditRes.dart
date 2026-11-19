// To parse this JSON data, do
//
//     final repairConsumEditModel = repairConsumEditModelFromJson(jsonString);

import 'dart:convert';

RepairConsumEditModel repairConsumEditModelFromJson(String str) => RepairConsumEditModel.fromJson(json.decode(str));

String repairConsumEditModelToJson(RepairConsumEditModel data) => json.encode(data.toJson());

class RepairConsumEditModel {
  bool? success;
  RepairConsumResult? result;
  String? message;

  RepairConsumEditModel({
    this.success,
    this.result,
    this.message
  });

  factory RepairConsumEditModel.fromJson(Map<String, dynamic> json) => RepairConsumEditModel(
    success: json["success"],
    result: json["result"] == null ? null : RepairConsumResult.fromJson(json["result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
    "message": message
  };
}

class RepairConsumResult {
  int? id;
  String? repairNo;
  String? repairType;
  int? projectid;
  int? siteid;
  int? supplierId;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? entryDt;
  int? updatedBy;
  String? updatedDt;
  String? projectName;
  String? siteName;
  dynamic subContractName;
  String? createdByName;
  String? supplierName;
  List<EditRepairDetLink>? repairDetLink;

  RepairConsumResult({
    this.id,
    this.repairNo,
    this.repairType,
    this.projectid,
    this.siteid,
    this.supplierId,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.entryDt,
    this.updatedBy,
    this.updatedDt,
    this.projectName,
    this.siteName,
    this.subContractName,
    this.createdByName,
    this.supplierName,
    this.repairDetLink,
  });

  factory RepairConsumResult.fromJson(Map<String, dynamic> json) => RepairConsumResult(
    id: json["id"],
    repairNo: json["repairNo"],
    repairType: json["repairType"],
    projectid: json["projectid"],
    siteid: json["siteid"],
    supplierId: json["supplierId"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    entryDt: json["entryDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractName: json["subContractName"],
    createdByName: json["createdByName"],
    supplierName: json["supplierName"],
    repairDetLink: json["repairDetLink"] == null ? [] : List<EditRepairDetLink>.from(json["repairDetLink"]!.map((x) => EditRepairDetLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "repairNo": repairNo,
    "repairType": repairType,
    "projectid": projectid,
    "siteid": siteid,
    "supplierId": supplierId,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "entryDt": entryDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "projectName": projectName,
    "siteName": siteName,
    "subContractName": subContractName,
    "createdByName": createdByName,
    "supplierName": supplierName,
    "repairDetLink": repairDetLink == null ? [] : List<dynamic>.from(repairDetLink!.map((x) => x.toJson())),
  };
}

class EditRepairDetLink {
  int? id;
  int? repairMasId;
  int? materialId;
  int? scaleId;
  double? qty;
  double? stockQty;
  double? rate;
  String? remarks;
  String? materialName;
  String? scaleName;

  EditRepairDetLink({
    this.id,
    this.repairMasId,
    this.materialId,
    this.scaleId,
    this.qty,
    this.stockQty,
    this.rate,
    this.remarks,
    this.materialName,
    this.scaleName,
  });

  factory EditRepairDetLink.fromJson(Map<String, dynamic> json) => EditRepairDetLink(
    id: json["id"],
    repairMasId: json["repairMasId"],
    materialId: json["materialId"],
    scaleId: json["scaleId"],
    qty: json["qty"],
    stockQty: json["stockQty"],
    rate: json["rate"],
    remarks: json["remarks"],
    materialName: json["materialName"],
    scaleName: json["scaleName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "repairMasId": repairMasId,
    "materialId": materialId,
    "scaleId": scaleId,
    "qty": qty,
    "stockQty": stockQty,
    "rate": rate,
    "remarks": remarks,
    "materialName": materialName,
    "scaleName": scaleName,
  };
}
