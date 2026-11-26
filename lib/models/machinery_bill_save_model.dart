// To parse this JSON data, do
//
//     final machineryBillSave = machineryBillSaveFromJson(jsonString);

import 'dart:convert';

MachineryBillSave machineryBillSaveFromJson(String str) => MachineryBillSave.fromJson(json.decode(str));

String machineryBillSaveToJson(MachineryBillSave data) => json.encode(data.toJson());

class MachineryBillSave {
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
  String? workOrderNo;
  List<SubContractorMachineryWorkQtydetLink>? subContractorMachineryWorkQtydetLink;
  List<SubContractorMachineryBillAddLessSetupLink>? subContractorMachineryBillAddLessSetupLink;
  List<SubContractorMachineryWorkBillDetailslink>? subContractorMachineryWorkBillDetailslink;

  MachineryBillSave({
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
    this.workOrderNo,
    this.subContractorMachineryWorkQtydetLink,
    this.subContractorMachineryBillAddLessSetupLink,
    this.subContractorMachineryWorkBillDetailslink,
  });

  factory MachineryBillSave.fromJson(Map<String, dynamic> json) => MachineryBillSave(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    workOrderId: json["workOrderId"],
    netBillAmount: json["netBillAmount"]?.toDouble(),
    finalBillAmount: json["finalBillAmount"]?.toDouble(),
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
    amount: json["amount"]?.toDouble(),
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
  String? itemDescription;
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
    this.itemDescription,
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
    itemDescription: json["itemDescription"],
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
    "itemDescription": itemDescription,
    "unit": unit,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "startReading": startReading,
    "endReading": endReading,
    "totalReading": totalReading,
  };
}
