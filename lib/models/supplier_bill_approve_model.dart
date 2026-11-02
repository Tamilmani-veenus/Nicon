// To parse this JSON data, do
//
//     final approveSuppBillApiModel = approveSuppBillApiModelFromJson(jsonString);

import 'dart:convert';

ApproveSuppBillApiModel approveSuppBillApiModelFromJson(String str) => ApproveSuppBillApiModel.fromJson(json.decode(str));

String approveSuppBillApiModelToJson(ApproveSuppBillApiModel data) => json.encode(data.toJson());

class ApproveSuppBillApiModel {
  int? id;
  String? billNo;
  String? entrydate;
  String? billType;
  String? poBillType;
  int? projectId;
  int? siteId;
  int? supplierId;
  String? dcNo;
  String? dcDate;
  String? invoiceNo;
  String? billDate;
  int? purOrdMasId;
  int? workOrdMasId;
  int? reqOrdMasId;
  double? frieghtCharges;
  double? labourCharges;
  double? otherCharges;
  double? roundOff;
  double? sgstPercentage;
  double? sgstAmount;
  double? netSgstAmount;
  double? cgstPercentage;
  double? cgstAmount;
  double? netCgstAmount;
  double? igstPercentage;
  double? igstAmount;
  double? netIgstAmount;
  double? tdsPercentage;
  double? tdsAmount;
  double? tcsPercentage;
  double? tcsAmount;
  double? totalAmount;
  double? discntAmount;
  double? advanceAmount;
  double? netAmount;
  double? netPayAmount;
  String? remarks;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? verifydate;
  int? approveBy;
  String? approveStatus;
  String? approveDate;
  double? debitNoteAmt;
  String? debitNoteRemarks;
  String? debitNoteType;
  bool? eWayBill;
  int? eWayBillNo;
  int? subContractorId;
  String? eWayBillImage;
  String? eWayBillDate;
  String? tallyType;
  String? materialInwMasId;
  int? companyId;
  int? workOrderId;
  String? fromDate;
  String? toDate;
  List<MaterialPurOrdBilldetLink>? materialPurOrdBilldetLink;

  ApproveSuppBillApiModel({
    this.id,
    this.billNo,
    this.entrydate,
    this.billType,
    this.poBillType,
    this.projectId,
    this.siteId,
    this.supplierId,
    this.dcNo,
    this.dcDate,
    this.invoiceNo,
    this.billDate,
    this.purOrdMasId,
    this.workOrdMasId,
    this.reqOrdMasId,
    this.frieghtCharges,
    this.labourCharges,
    this.otherCharges,
    this.roundOff,
    this.sgstPercentage,
    this.sgstAmount,
    this.netSgstAmount,
    this.cgstPercentage,
    this.cgstAmount,
    this.netCgstAmount,
    this.igstPercentage,
    this.igstAmount,
    this.netIgstAmount,
    this.tdsPercentage,
    this.tdsAmount,
    this.tcsPercentage,
    this.tcsAmount,
    this.totalAmount,
    this.discntAmount,
    this.advanceAmount,
    this.netAmount,
    this.netPayAmount,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.verifydate,
    this.approveBy,
    this.approveStatus,
    this.approveDate,
    this.debitNoteAmt,
    this.debitNoteRemarks,
    this.debitNoteType,
    this.eWayBill,
    this.eWayBillNo,
    this.subContractorId,
    this.eWayBillImage,
    this.eWayBillDate,
    this.tallyType,
    this.materialInwMasId,
    this.companyId,
    this.workOrderId,
    this.fromDate,
    this.toDate,
    this.materialPurOrdBilldetLink,
  });

  factory ApproveSuppBillApiModel.fromJson(Map<String, dynamic> json) => ApproveSuppBillApiModel(
    id: json["id"],
    billNo: json["billNo"],
    entrydate: json["entrydate"],
    billType: json["billType"],
    poBillType: json["poBillType"],
    projectId: json["projectID"],
    siteId: json["siteID"],
    supplierId: json["supplierID"],
    dcNo: json["dcNo"],
    dcDate: json["dcDate"],
    invoiceNo: json["invoiceNo"],
    billDate: json["billDate"],
    purOrdMasId: json["purOrdMasId"],
    workOrdMasId: json["workOrdMasId"],
    reqOrdMasId: json["reqOrdMasId"],
    frieghtCharges: json["frieghtCharges"],
    labourCharges: json["labourCharges"],
    otherCharges: json["otherCharges"],
    roundOff: json["roundOff"],
    sgstPercentage: json["sgstPercentage"],
    sgstAmount: json["sgstAmount"],
    netSgstAmount: json["netSGSTAmount"],
    cgstPercentage: json["cgstPercentage"],
    cgstAmount: json["cgstAmount"],
    netCgstAmount: json["netCGSTAmount"],
    igstPercentage: json["igstPercentage"],
    igstAmount: json["igstAmount"],
    netIgstAmount: json["netIGSTAmount"],
    tdsPercentage: json["tdsPercentage"],
    tdsAmount: json["tdsAmount"],
    tcsPercentage: json["tcsPercentage"],
    tcsAmount: json["tcsAmount"],
    totalAmount: json["totalAmount"],
    discntAmount: json["discntAmount"],
    advanceAmount: json["advanceAmount"],
    netAmount: json["netAmount"],
    netPayAmount: json["netPayAmount"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifydate: json["verifydate"],
    approveBy: json["approveBy"],
    approveStatus: json["approveStatus"],
    approveDate: json["approveDate"],
    debitNoteAmt: json["debitNoteAmt"],
    debitNoteRemarks: json["debitNoteRemarks"],
    debitNoteType: json["debitNoteType"],
    eWayBill: json["eWayBill"],
    eWayBillNo: json["eWayBillNo"],
    subContractorId: json["subContractorId"],
    eWayBillImage: json["eWayBillImage"],
    eWayBillDate: json["eWayBillDate"],
    tallyType: json["tallyType"],
    materialInwMasId: json["materialInwMasId"],
    companyId: json["companyId"],
    workOrderId: json["workOrderId"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    materialPurOrdBilldetLink: List<MaterialPurOrdBilldetLink>.from(json["materialPurOrdBilldetLink"].map((x) => MaterialPurOrdBilldetLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "billNo": billNo,
    "entrydate": entrydate,
    "billType": billType,
    "poBillType": poBillType,
    "projectID": projectId,
    "siteID": siteId,
    "supplierID": supplierId,
    "dcNo": dcNo,
    "dcDate": dcDate,
    "invoiceNo": invoiceNo,
    "billDate": billDate,
    "purOrdMasId": purOrdMasId,
    "workOrdMasId": workOrdMasId,
    "reqOrdMasId": reqOrdMasId,
    "frieghtCharges": frieghtCharges,
    "labourCharges": labourCharges,
    "otherCharges": otherCharges,
    "roundOff": roundOff,
    "sgstPercentage": sgstPercentage,
    "sgstAmount": sgstAmount,
    "netSGSTAmount": netSgstAmount,
    "cgstPercentage": cgstPercentage,
    "cgstAmount": cgstAmount,
    "netCGSTAmount": netCgstAmount,
    "igstPercentage": igstPercentage,
    "igstAmount": igstAmount,
    "netIGSTAmount": netIgstAmount,
    "tdsPercentage": tdsPercentage,
    "tdsAmount": tdsAmount,
    "tcsPercentage": tcsPercentage,
    "tcsAmount": tcsAmount,
    "totalAmount": totalAmount,
    "discntAmount": discntAmount,
    "advanceAmount": advanceAmount,
    "netAmount": netAmount,
    "netPayAmount": netPayAmount,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifydate": verifydate,
    "approveBy": approveBy,
    "approveStatus": approveStatus,
    "approveDate": approveDate,
    "debitNoteAmt": debitNoteAmt,
    "debitNoteRemarks": debitNoteRemarks,
    "debitNoteType": debitNoteType,
    "eWayBill": eWayBill,
    "eWayBillNo": eWayBillNo,
    "subContractorId": subContractorId,
    "eWayBillImage": eWayBillImage,
    "eWayBillDate": eWayBillDate,
    "tallyType": tallyType,
    "materialInwMasId": materialInwMasId,
    "companyId": companyId,
    "workOrderId": workOrderId,
    "fromDate": fromDate,
    "toDate": toDate,
    "materialPurOrdBilldetLink": List<dynamic>.from(materialPurOrdBilldetLink!.map((x) => x.toJson())),
  };
}

class MaterialPurOrdBilldetLink {
  int? id;
  int? materialPurOrdBillMasId;
  int? purOrdDetId;
  int? workOrdDetId;
  int? reqOrdDetId;
  int? materialId;
  int? scaleId;
  double? qty;
  double? rate;
  double? amount;
  double? sgstPercentage;
  double? sgstAmount;
  double? cgstPercentage;
  double? cgstAmount;
  double? igstPercentage;
  double? igstAmount;
  double? discntPercentage;
  double? discntAmount;
  double? netAmount;
  double? inwQty;
  double? poRate;
  String? remarks;
  double? approxDays;
  String? expiryDate;

  MaterialPurOrdBilldetLink({
    this.id,
    this.materialPurOrdBillMasId,
    this.purOrdDetId,
    this.workOrdDetId,
    this.reqOrdDetId,
    this.materialId,
    this.scaleId,
    this.qty,
    this.rate,
    this.amount,
    this.sgstPercentage,
    this.sgstAmount,
    this.cgstPercentage,
    this.cgstAmount,
    this.igstPercentage,
    this.igstAmount,
    this.discntPercentage,
    this.discntAmount,
    this.netAmount,
    this.inwQty,
    this.poRate,
    this.remarks,
    this.approxDays,
    this.expiryDate,
  });

  factory MaterialPurOrdBilldetLink.fromJson(Map<String, dynamic> json) => MaterialPurOrdBilldetLink(
    id: json["id"],
    materialPurOrdBillMasId: json["materialPurOrdBillMasID"],
    purOrdDetId: json["purOrdDetId"],
    workOrdDetId: json["workOrdDetId"],
    reqOrdDetId: json["reqOrdDetId"],
    materialId: json["materialID"],
    scaleId: json["scaleID"],
    qty: json["qty"],
    rate: json["rate"],
    amount: json["amount"],
    sgstPercentage: json["sgstPercentage"],
    sgstAmount: json["sgstAmount"],
    cgstPercentage: json["cgstPercentage"],
    cgstAmount: json["cgstAmount"],
    igstPercentage: json["igstPercentage"],
    igstAmount: json["igstAmount"],
    discntPercentage: json["discntPercentage"],
    discntAmount: json["discntAmount"],
    netAmount: json["netAmount"],
    inwQty: json["inwQty"],
    poRate: json["poRate"],
    remarks: json["remarks"],
    approxDays: json["approxDays"],
    expiryDate: json["expiryDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialPurOrdBillMasID": materialPurOrdBillMasId,
    "purOrdDetId": purOrdDetId,
    "workOrdDetId": workOrdDetId,
    "reqOrdDetId": reqOrdDetId,
    "materialID": materialId,
    "scaleID": scaleId,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "sgstPercentage": sgstPercentage,
    "sgstAmount": sgstAmount,
    "cgstPercentage": cgstPercentage,
    "cgstAmount": cgstAmount,
    "igstPercentage": igstPercentage,
    "igstAmount": igstAmount,
    "discntPercentage": discntPercentage,
    "discntAmount": discntAmount,
    "netAmount": netAmount,
    "inwQty": inwQty,
    "poRate": poRate,
    "remarks": remarks,
    "approxDays": approxDays,
    "expiryDate": expiryDate,
  };
}
