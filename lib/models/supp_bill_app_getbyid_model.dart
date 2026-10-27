// To parse this JSON data, do
//
//     final suppBillAppGetById = suppBillAppGetByIdFromJson(jsonString);

import 'dart:convert';

SuppBillAppGetById suppBillAppGetByIdFromJson(String str) => SuppBillAppGetById.fromJson(json.decode(str));

String suppBillAppGetByIdToJson(SuppBillAppGetById data) => json.encode(data.toJson());

class SuppBillAppGetById {
  bool? success;
  Result? result;
  List<MaterialPurOrdBilldetLink>? materialPurOrdBilldetLink;

  SuppBillAppGetById({
    this.success,
    this.result,
    this.materialPurOrdBilldetLink,
  });

  factory SuppBillAppGetById.fromJson(Map<String, dynamic> json) => SuppBillAppGetById(
    success: json["success"],
    result: Result.fromJson(json["result"]),
    materialPurOrdBilldetLink: List<MaterialPurOrdBilldetLink>.from(json["materialPurOrdBilldetLink"].map((x) => MaterialPurOrdBilldetLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
    "materialPurOrdBilldetLink": List<dynamic>.from(materialPurOrdBilldetLink!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? billNo;
  String? entrydate;
  String? billType;
  dynamic billDesc;
  String? poBillType;
  dynamic poBillDesc;
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
  int? frieghtCharges;
  int? labourCharges;
  int? otherCharges;
  int? roundOff;
  int? sgstPercentage;
  int? sgstAmount;
  double? netSgstAmount;
  int? cgstPercentage;
  int? cgstAmount;
  double? netCgstAmount;
  int? igstPercentage;
  int? igstAmount;
  int? netIgstAmount;
  int? tdsPercentage;
  int? tdsAmount;
  int? tcsPercentage;
  int? tcsAmount;
  int? totalAmount;
  int? discntAmount;
  int? advanceAmount;
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
  String? purchaseOrdDate;
  dynamic workOrdDate;
  dynamic reqOrdDate;
  String? projectName;
  String? siteName;
  String? supplierName;
  String? purOrdMasNo;
  String? workOrdMasNo;
  String? reqOrdMasNo;
  String? createdName;
  String? verifyName;
  String? approvedName;
  int? debitNoteAmt;
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
  String? companyName;
  int? advanceAmountEdit;
  dynamic hasImage;
  int? workOrderId;
  dynamic billTypeDesc;

  Result({
    this.id,
    this.billNo,
    this.entrydate,
    this.billType,
    this.billDesc,
    this.poBillType,
    this.poBillDesc,
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
    this.purchaseOrdDate,
    this.workOrdDate,
    this.reqOrdDate,
    this.projectName,
    this.siteName,
    this.supplierName,
    this.purOrdMasNo,
    this.workOrdMasNo,
    this.reqOrdMasNo,
    this.createdName,
    this.verifyName,
    this.approvedName,
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
    this.companyName,
    this.advanceAmountEdit,
    this.hasImage,
    this.workOrderId,
    this.billTypeDesc,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    billNo: json["billNo"],
    entrydate: json["entrydate"],
    billType: json["billType"],
    billDesc: json["billDesc"],
    poBillType: json["poBillType"],
    poBillDesc: json["poBillDesc"],
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
    netSgstAmount: json["netSGSTAmount"]?.toDouble(),
    cgstPercentage: json["cgstPercentage"],
    cgstAmount: json["cgstAmount"],
    netCgstAmount: json["netCGSTAmount"]?.toDouble(),
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
    netAmount: json["netAmount"]?.toDouble(),
    netPayAmount: json["netPayAmount"]?.toDouble(),
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifydate: json["verifydate"],
    approveBy: json["approveBy"],
    approveStatus: json["approveStatus"],
    approveDate: json["approveDate"],
    purchaseOrdDate: json["purchaseOrdDate"],
    workOrdDate: json["workOrdDate"],
    reqOrdDate: json["reqOrdDate"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    supplierName: json["supplierName"],
    purOrdMasNo: json["purOrdMasNo"],
    workOrdMasNo: json["workOrdMasNo"],
    reqOrdMasNo: json["reqOrdMasNo"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approvedName: json["approvedName"],
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
    companyName: json["companyName"],
    advanceAmountEdit: json["advanceAmountEdit"],
    hasImage: json["hasImage"],
    workOrderId: json["workOrderId"],
    billTypeDesc: json["billTypeDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "billNo": billNo,
    "entrydate": entrydate,
    "billType": billType,
    "billDesc": billDesc,
    "poBillType": poBillType,
    "poBillDesc": poBillDesc,
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
    "purchaseOrdDate": purchaseOrdDate,
    "workOrdDate": workOrdDate,
    "reqOrdDate": reqOrdDate,
    "projectName": projectName,
    "siteName": siteName,
    "supplierName": supplierName,
    "purOrdMasNo": purOrdMasNo,
    "workOrdMasNo": workOrdMasNo,
    "reqOrdMasNo": reqOrdMasNo,
    "createdName": createdName,
    "verifyName": verifyName,
    "approvedName": approvedName,
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
    "companyName": companyName,
    "advanceAmountEdit": advanceAmountEdit,
    "hasImage": hasImage,
    "workOrderId": workOrderId,
    "billTypeDesc": billTypeDesc,
  };
}

class MaterialPurOrdBilldetLink {
  int? detId;
  int? materialInwarddetid;
  int? purOrdMasId;
  int? purOrdDetId;
  int? workOrdDetId;
  int? reqOrdDetId;
  int? materialId;
  String? materialName;
  int? scaleId;
  String? scaleName;
  int? inwardQty;
  int? billQty;
  int? balInwQty;
  int? balQty;
  String? description;
  int? rate;
  int? poRate;
  int? discPer;
  int? discAmt;
  String? remarks;
  int? sgstPer;
  double? sgstAmt;
  int? cgstPer;
  double? cgstAmt;
  int?igstPer;
  int?igstAmt;
  int?vatType;
  int?amount;
  double? netAmount;
  int? status;

  MaterialPurOrdBilldetLink({
    this.detId,
    this.materialInwarddetid,
    this.purOrdMasId,
    this.purOrdDetId,
    this.workOrdDetId,
    this.reqOrdDetId,
    this.materialId,
    this.materialName,
    this.scaleId,
    this.scaleName,
    this.inwardQty,
    this.billQty,
    this.balInwQty,
    this.balQty,
    this.description,
    this.rate,
    this.poRate,
    this.discPer,
    this.discAmt,
    this.remarks,
    this.sgstPer,
    this.sgstAmt,
    this.cgstPer,
    this.cgstAmt,
    this.igstPer,
    this.igstAmt,
    this.vatType,
    this.amount,
    this.netAmount,
    this.status,
  });

  factory MaterialPurOrdBilldetLink.fromJson(Map<String, dynamic> json) => MaterialPurOrdBilldetLink(
    detId: json["DetId"],
    materialInwarddetid: json["MaterialInwarddetid"],
    purOrdMasId: json["PurOrdMasId"],
    purOrdDetId: json["PurOrdDetId"],
    workOrdDetId: json["WorkOrdDetId"],
    reqOrdDetId: json["ReqOrdDetId"],
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    scaleId: json["ScaleID"],
    scaleName: json["ScaleName"],
    inwardQty: json["InwardQty"],
    billQty: json["BillQty"],
    balInwQty: json["BalInwQty"],
    balQty: json["BalQty"],
    description: json["Description"],
    rate: json["Rate"],
    poRate: json["poRate"],
    discPer: json["Disc_Per"],
    discAmt: json["Disc_Amt"],
    remarks: json["remarks"],
    sgstPer: json["SGSTPer"],
    sgstAmt: json["SGSTAmt"]?.toDouble(),
    cgstPer: json["CGSTPer"],
    cgstAmt: json["CGSTAmt"]?.toDouble(),
    igstPer: json["IGSTPer"],
    igstAmt: json["IGSTAmt"],
    vatType: json["Vat_Type"],
    amount: json["Amount"],
    netAmount: json["NetAmount"]?.toDouble(),
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "DetId": detId,
    "MaterialInwarddetid": materialInwarddetid,
    "PurOrdMasId": purOrdMasId,
    "PurOrdDetId": purOrdDetId,
    "WorkOrdDetId": workOrdDetId,
    "ReqOrdDetId": reqOrdDetId,
    "MaterialId": materialId,
    "MaterialName": materialName,
    "ScaleID": scaleId,
    "ScaleName": scaleName,
    "InwardQty": inwardQty,
    "BillQty": billQty,
    "BalInwQty": balInwQty,
    "BalQty": balQty,
    "Description": description,
    "Rate": rate,
    "poRate": poRate,
    "Disc_Per": discPer,
    "Disc_Amt": discAmt,
    "remarks": remarks,
    "SGSTPer": sgstPer,
    "SGSTAmt": sgstAmt,
    "CGSTPer": cgstPer,
    "CGSTAmt": cgstAmt,
    "IGSTPer": igstPer,
    "IGSTAmt": igstAmt,
    "Vat_Type": vatType,
    "Amount": amount,
    "NetAmount": netAmount,
    "Status": status,
  };
}


