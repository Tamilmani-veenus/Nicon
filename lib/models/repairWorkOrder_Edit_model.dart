// To parse this JSON data, do
//
//     final repairWorkOrdeEditModel = repairWorkOrdeEditModelFromJson(jsonString);

import 'dart:convert';

RepairWorkOrdeEditModel repairWorkOrdeEditModelFromJson(String str) => RepairWorkOrdeEditModel.fromJson(json.decode(str));

String repairWorkOrdeEditModelToJson(RepairWorkOrdeEditModel data) => json.encode(data.toJson());

class RepairWorkOrdeEditModel {
  bool? success;
  Result? result;
  String? message;

  RepairWorkOrdeEditModel({
    this.success,
    this.result,
    this.message
  });

  factory RepairWorkOrdeEditModel.fromJson(Map<String, dynamic> json) => RepairWorkOrdeEditModel(
    success: json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
    "message": message
  };
}

class Result {
  int? id;
  String? workOrderNo;
  String? entryDate;
  String? entryType;
  int? projectId;
  int? siteId;
  int? supplierId;
  int? repairConsumptionId;
  double? roundOff;
  double? workOrderAmount;
  double? netAmount;
  String? remarks;
  String? termsCondition;
  String? workStatus;
  String? mailStatus;
  String? downloadStatus;
  String? active;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDt;
  int? approvedBy;
  String? approveStatus;
  String? approveDt;
  dynamic mailDate;
  String? projectName;
  String? siteName;
  dynamic subContractorName;
  String? supplierName;
  String? createdName;
  String? verifyName;
  String? approveName;
  String? repairConsumptionNo;
  List<RepairWorkOrderDetlink>? repairWorkOrderDetlink;
  List<RepairWorkOrderAddLessSetuplink>? repairWorkOrderAddLessSetuplink;

  Result({
    this.id,
    this.workOrderNo,
    this.entryDate,
    this.entryType,
    this.projectId,
    this.siteId,
    this.supplierId,
    this.repairConsumptionId,
    this.roundOff,
    this.workOrderAmount,
    this.netAmount,
    this.remarks,
    this.termsCondition,
    this.workStatus,
    this.mailStatus,
    this.downloadStatus,
    this.active,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.verifyDt,
    this.approvedBy,
    this.approveStatus,
    this.approveDt,
    this.mailDate,
    this.projectName,
    this.siteName,
    this.subContractorName,
    this.supplierName,
    this.createdName,
    this.verifyName,
    this.approveName,
    this.repairConsumptionNo,
    this.repairWorkOrderDetlink,
    this.repairWorkOrderAddLessSetuplink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workOrderNo: json["workOrderNo"],
    entryDate: json["entryDate"],
    entryType: json["entryType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    supplierId: json["supplierId"],
    repairConsumptionId: json["repairConsumptionId"],
    roundOff: json["roundOff"],
    workOrderAmount: json["workOrderAmount"],
    netAmount: json["netAmount"],
    remarks: json["remarks"],
    termsCondition: json["termsCondition"],
    workStatus: json["workStatus"],
    mailStatus: json["mailStatus"],
    downloadStatus: json["downloadStatus"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    mailDate: json["mailDate"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractorName: json["subContractorName"],
    supplierName: json["supplierName"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approveName: json["approveName"],
      repairConsumptionNo: json["repairConsumptionNo"],
    repairWorkOrderDetlink: json["repairWorkOrderDetlink"] == null ? [] : List<RepairWorkOrderDetlink>.from(json["repairWorkOrderDetlink"]!.map((x) => RepairWorkOrderDetlink.fromJson(x))),
    repairWorkOrderAddLessSetuplink: json["repairWorkOrderAddLessSetuplink"] == null ? [] : List<RepairWorkOrderAddLessSetuplink>.from(json["repairWorkOrderAddLessSetuplink"]!.map((x) => RepairWorkOrderAddLessSetuplink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workOrderNo": workOrderNo,
    "entryDate": entryDate,
    "entryType": entryType,
    "projectId": projectId,
    "siteId": siteId,
    "supplierId": supplierId,
    "repairConsumptionId": repairConsumptionId,
    "roundOff": roundOff,
    "workOrderAmount": workOrderAmount,
    "netAmount": netAmount,
    "remarks": remarks,
    "termsCondition": termsCondition,
    "workStatus": workStatus,
    "mailStatus": mailStatus,
    "downloadStatus": downloadStatus,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDt": verifyDt,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDt": approveDt,
    "mailDate": mailDate,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContractorName,
    "supplierName": supplierName,
    "createdName": createdName,
    "verifyName": verifyName,
    "approveName": approveName,
    "repairConsumptionNo": repairConsumptionNo,
    "repairWorkOrderDetlink": repairWorkOrderDetlink == null ? [] : List<dynamic>.from(repairWorkOrderDetlink!.map((x) => x.toJson())),
    "repairWorkOrderAddLessSetuplink": repairWorkOrderAddLessSetuplink == null ? [] : List<dynamic>.from(repairWorkOrderAddLessSetuplink!.map((x) => x.toJson())),
  };
}

class RepairWorkOrderAddLessSetuplink {
  int? id;
  int? repairWorkOrderMasId;
  String? workOrderNo;
  int? addLessId;
  double? percentValue;
  double? amount;

  RepairWorkOrderAddLessSetuplink({
    this.id,
    this.repairWorkOrderMasId,
    this.workOrderNo,
    this.addLessId,
    this.percentValue,
    this.amount,
  });

  factory RepairWorkOrderAddLessSetuplink.fromJson(Map<String, dynamic> json) => RepairWorkOrderAddLessSetuplink(
    id: json["id"],
    repairWorkOrderMasId: json["repairWorkOrderMasId"],
    workOrderNo: json["workOrderNo"],
    addLessId: json["addLessId"],
    percentValue: json["percentValue"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "repairWorkOrderMasId": repairWorkOrderMasId,
    "workOrderNo": workOrderNo,
    "addLessId": addLessId,
    "percentValue": percentValue,
    "amount": amount,
  };
}

class RepairWorkOrderDetlink {
  int? reqDetId;
  int? repairWorkOrderMasId;
  String? itemDescription;
  double? qty;
  String? unit;
  double? rate;
  double? amount;
  String? workRemarks;

  RepairWorkOrderDetlink({
    this.reqDetId,
    this.repairWorkOrderMasId,
    this.itemDescription,
    this.qty,
    this.unit,
    this.rate,
    this.amount,
    this.workRemarks,
  });

  factory RepairWorkOrderDetlink.fromJson(Map<String, dynamic> json) => RepairWorkOrderDetlink(
    reqDetId: json["id"],
    repairWorkOrderMasId: json["repairWorkOrderMasId"],
    itemDescription: json["itemDescription"],
    qty: json["qty"],
    unit: json["unit"],
    rate: json["rate"],
    amount: json["amount"],
    workRemarks: json["workRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": reqDetId,
    "repairWorkOrderMasId": repairWorkOrderMasId,
    "itemDescription": itemDescription,
    "qty": qty,
    "unit": unit,
    "rate": rate,
    "amount": amount,
    "workRemarks": workRemarks,
  };
}
