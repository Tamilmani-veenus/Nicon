// To parse this JSON data, do
//
//     final repairConsumptionGetAllRes = repairConsumptionGetAllResFromJson(jsonString);

import 'dart:convert';

RepairConsumptionGetAllRes repairConsumptionGetAllResFromJson(String str) => RepairConsumptionGetAllRes.fromJson(json.decode(str));

String repairConsumptionGetAllResToJson(RepairConsumptionGetAllRes data) => json.encode(data.toJson());

class RepairConsumptionGetAllRes {
  bool? success;
  List<Result>? result;
  String? message;

  RepairConsumptionGetAllRes({
    this.success,
    this.result,
    this.message
  });

  factory RepairConsumptionGetAllRes.fromJson(Map<String, dynamic> json) => RepairConsumptionGetAllRes(
    success: json["success"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
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
  dynamic repairDetLink;

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    repairDetLink: json["repairDetLink"],
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
    "repairDetLink": repairDetLink,
  };
}
