// To parse this JSON data, do
//
//     final machineryBillEdit = machineryBillEditFromJson(jsonString);

import 'dart:convert';

MachineryBillEdit machineryBillEditFromJson(String str) => MachineryBillEdit.fromJson(json.decode(str));

String machineryBillEditToJson(MachineryBillEdit data) => json.encode(data.toJson());

class MachineryBillEdit {
  bool? success;
  Result? result;
  String? message;

  MachineryBillEdit({
    this.success,
    this.result,
    this.message
  });

  factory MachineryBillEdit.fromJson(Map<String, dynamic> json) => MachineryBillEdit(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  int? id;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContractorId;
  int? workOrderId;
  double? netBillAmount;
  double? finalBillAmount;
  double? netPayAmount;
  double? roundOff;
  double? billAmount;
  double? creditAmount;
  String? creditRemarks;
  double? debitAmount;
  String? debitRemarks;
  String? paymentDate;
  String? remarks;
  int? createdBy;
  int? verifyBy;
  String? verifyStatus;
  int? approvedBy;
  String? approveStatus;
  String? projectName;
  String? siteName;
  String? subContractorName;
  String? createdName;
  String? status;
  String? workOrderNo;
  List<SubContractorMachineryWorkQtydetLink>? subContractorMachineryWorkQtydetLink;
  List<SubContractorMachineryBillAddLessSetupLink>? subContractorMachineryBillAddLessSetupLink;
  List<SubContractorMachineryWorkBillDetailslink>? subContractorMachineryWorkBillDetailslink;

  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.workOrderId,
    this.netBillAmount,
    this.finalBillAmount,
    this.netPayAmount,
    this.roundOff,
    this.billAmount,
    this.creditAmount,
    this.creditRemarks,
    this.debitAmount,
    this.debitRemarks,
    this.paymentDate,
    this.remarks,
    this.createdBy,
    this.verifyBy,
    this.verifyStatus,
    this.approvedBy,
    this.approveStatus,
    this.projectName,
    this.siteName,
    this.subContractorName,
    this.createdName,
    this.status,
    this.workOrderNo,
    this.subContractorMachineryWorkQtydetLink,
    this.subContractorMachineryBillAddLessSetupLink,
    this.subContractorMachineryWorkBillDetailslink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    workOrderId: json["workOrderId"],
    netBillAmount: json["netBillAmount"],
    finalBillAmount: json["finalBillAmount"],
    netPayAmount: json["netPayAmount"],
    roundOff: json["roundOff"],
    billAmount: json["billAmount"],
    creditAmount: json["creditAmount"],
    creditRemarks: json["creditRemarks"],
    debitAmount: json["debitAmount"],
    debitRemarks: json["debitRemarks"],
    paymentDate: json["paymentDate"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractorName: json["subContractorName"],
    createdName: json["createdName"],
    status: json["status"],
    workOrderNo: json["workOrderNo"],
    subContractorMachineryWorkQtydetLink: List<SubContractorMachineryWorkQtydetLink>.from(json["subContractorMachineryWorkQtydetLink"].map((x) => SubContractorMachineryWorkQtydetLink.fromJson(x))),
    subContractorMachineryBillAddLessSetupLink: List<SubContractorMachineryBillAddLessSetupLink>.from(json["subContractorMachineryBillAddLessSetupLink"].map((x) => SubContractorMachineryBillAddLessSetupLink.fromJson(x))),
    subContractorMachineryWorkBillDetailslink: List<SubContractorMachineryWorkBillDetailslink>.from(json["subContractorMachineryWorkBillDetailslink"].map((x) => SubContractorMachineryWorkBillDetailslink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "workDate": workDate,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "workOrderId": workOrderId,
    "netBillAmount": netBillAmount,
    "finalBillAmount": finalBillAmount,
    "netPayAmount": netPayAmount,
    "roundOff": roundOff,
    "billAmount": billAmount,
    "creditAmount": creditAmount,
    "creditRemarks": creditRemarks,
    "debitAmount": debitAmount,
    "debitRemarks": debitRemarks,
    "paymentDate": paymentDate,
    "remarks": remarks,
    "createdBy": createdBy,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContractorName,
    "createdName": createdName,
    "status": status,
    "workOrderNo": workOrderNo,
    "subContractorMachineryWorkQtydetLink": List<dynamic>.from(subContractorMachineryWorkQtydetLink!.map((x) => x.toJson())),
    "subContractorMachineryBillAddLessSetupLink": List<dynamic>.from(subContractorMachineryBillAddLessSetupLink!.map((x) => x.toJson())),
    "subContractorMachineryWorkBillDetailslink": List<dynamic>.from(subContractorMachineryWorkBillDetailslink!.map((x) => x.toJson())),
  };
}

class SubContractorMachineryBillAddLessSetupLink {
  int? id;
  int? subContractorWorkQtyMasId;
  String? workNo;
  int? addLessId;
  double? percentValue;
  double? amount;

  SubContractorMachineryBillAddLessSetupLink({
    this.id,
    this.subContractorWorkQtyMasId,
    this.workNo,
    this.addLessId,
    this.percentValue,
    this.amount,
  });

  factory SubContractorMachineryBillAddLessSetupLink.fromJson(Map<String, dynamic> json) => SubContractorMachineryBillAddLessSetupLink(
    id: json["id"],
    subContractorWorkQtyMasId: json["subContractorWorkQtyMasId"],
    workNo: json["workNo"],
    addLessId: json["addLessId"],
    percentValue: json["percentValue"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractorWorkQtyMasId": subContractorWorkQtyMasId,
    "workNo": workNo,
    "addLessId": addLessId,
    "percentValue": percentValue,
    "amount": amount,
  };
}

class SubContractorMachineryWorkBillDetailslink {
  int? id;
  int? subcontractorWorkQtyMasId;
  int? subContractDailyWorkDetId;

  SubContractorMachineryWorkBillDetailslink({
    this.id,
    this.subcontractorWorkQtyMasId,
    this.subContractDailyWorkDetId,
  });

  factory SubContractorMachineryWorkBillDetailslink.fromJson(Map<String, dynamic> json) => SubContractorMachineryWorkBillDetailslink(
    id: json["id"],
    subcontractorWorkQtyMasId: json["subcontractorWorkQtyMasId"],
    subContractDailyWorkDetId: json["subContractDailyWorkDetId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subcontractorWorkQtyMasId": subcontractorWorkQtyMasId,
    "subContractDailyWorkDetId": subContractDailyWorkDetId,
  };
}

class SubContractorMachineryWorkQtydetLink {
  int? id;
  int? subContractorWorkQtyMasId;
  int? siteId;
  String? workType;
  int? dbrWorkDetId;
  String? itemDescription;
  String? unitName;
  int? unit;
  double? qty;
  double? rate;
  double? amount;
  double? startReading;
  double? endReading;
  double? totalReading;

  SubContractorMachineryWorkQtydetLink({
    this.id,
    this.subContractorWorkQtyMasId,
    this.siteId,
    this.workType,
    this.dbrWorkDetId,
    this.itemDescription,
    this.unitName,
    this.unit,
    this.qty,
    this.rate,
    this.amount,
    this.startReading,
    this.endReading,
    this.totalReading,
  });

  factory SubContractorMachineryWorkQtydetLink.fromJson(Map<String, dynamic> json) => SubContractorMachineryWorkQtydetLink(
    id: json["id"],
    subContractorWorkQtyMasId: json["subContractorWorkQtyMasId"],
    siteId: json["siteId"],
    workType: json["workType"],
    dbrWorkDetId: json["dbrWorkDetId"],
    itemDescription: json["itemDescription"],
    unitName: json["unitName"],
    unit: json["unit"],
    qty: json["qty"],
    rate: json["rate"],
    amount: json["amount"],
    startReading: json["startReading"],
    endReading: json["endReading"],
    totalReading: json["totalReading"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractorWorkQtyMasId": subContractorWorkQtyMasId,
    "siteId": siteId,
    "workType": workType,
    "dbrWorkDetId": dbrWorkDetId,
    "itemDescription": itemDescription,
    "unitName": unitName,
    "unit": unit,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "startReading": startReading,
    "endReading": endReading,
    "totalReading": totalReading,
  };
}
