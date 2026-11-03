// To parse this JSON data, do
//
//     final suppBillAppGetById = suppBillAppGetByIdFromJson(jsonString);

import 'dart:convert';

SuppBillAppGetById suppBillAppGetByIdFromJson(String str) => SuppBillAppGetById.fromJson(json.decode(str));

String suppBillAppGetByIdToJson(SuppBillAppGetById data) => json.encode(data.toJson());

class SuppBillAppGetById {
  bool? success;
  Result? result;
  String? message;
  List<MaterialPurOrdBilldetLink>? materialPurOrdBilldetLink;

  SuppBillAppGetById({
    this.success,
    this.result,
    this.message,
    this.materialPurOrdBilldetLink,
  });

  factory SuppBillAppGetById.fromJson(Map<String, dynamic> json) {
    final resultJson =
        json["result"] as Map<String, dynamic>? ?? {};

    final topItems = json["materialPurOrdBilldetLink"] as List?;
    final nestedItems = resultJson["materialPurOrdBilldetLink"] as List?;

    // P flow: top-level list
    // G flow: result-level list
    final itemList = (topItems != null && topItems.isNotEmpty)
        ? topItems
        : (nestedItems ?? []);

    return SuppBillAppGetById(
      success: json["success"],
      message: json["message"],
      result: Result.fromJson(resultJson),
      materialPurOrdBilldetLink: itemList
          .map((x) => MaterialPurOrdBilldetLink.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
    "materialPurOrdBilldetLink":
    materialPurOrdBilldetLink?.map((x) => x.toJson()).toList() ?? [],
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
  double? discntPercentage;
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
  String? companyName;
  double? advanceAmountEdit;
  dynamic hasImage;
  int? workOrderId;
  dynamic billTypeDesc;
  bool? gstApply;
  String? fromDate;
  String? toDate;

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
    this.discntPercentage,
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
    this.gstApply,
    this.fromDate,
    this.toDate
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
    discntPercentage: json["discntPercentage"],
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
    gstApply: json["gstApply"],
    fromDate: json["fromDate"],
    toDate: json["toDate"]
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
    "discntPercentage": discntPercentage,
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
    "gstApply": gstApply,
    "fromDate": fromDate,
    "toDate": toDate,
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
  double? inwardQty;
  double? billQty;
  double? balInwQty;
  double? balQty;
  String? description;
  double? rate;
  double? poRate;
  double? discPer;
  double? discAmt;
  String? remarks;
  double? sgstPer;
  double? sgstAmt;
  double? cgstPer;
  double? cgstAmt;
  double?igstPer;
  double?igstAmt;
  int?vatType;
  double?amount;
  double? netAmount;
  int? status;
  int? approxDays;

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
    this.approxDays,
  });

  factory MaterialPurOrdBilldetLink.fromJson(
      Map<String, dynamic> json) {
    return MaterialPurOrdBilldetLink(
      detId: json["DetId"] ?? json["id"],

      materialInwarddetid:
      json["MaterialInwarddetid"] ?? json["materialInwarddetid"],

      purOrdMasId:
      json["PurOrdMasId"] ?? json["materialPurOrdMasID"],

      purOrdDetId: json["PurOrdDetId"] ?? json["purOrdDetId"],
      workOrdDetId: json["WorkOrdDetId"] ?? json["workOrdDetId"],
      reqOrdDetId: json["ReqOrdDetId"] ?? json["reqOrdDetId"],

      materialId: json["MaterialId"] ?? json["materialID"],
      materialName: json["MaterialName"] ?? json["materialName"],

      scaleId: json["ScaleID"] ?? json["scaleID"],
      scaleName: json["ScaleName"] ?? json["scaleName"],

      inwardQty: toDoubleValue(json["InwardQty"] ?? json["inwQty"]),
      billQty: toDoubleValue(json["BillQty"] ?? json["qty"]),

      balInwQty: toDoubleValue(json["BalInwQty"] ?? json["balInwQty"]),
      balQty: toDoubleValue(json["BalQty"] ?? json["balQty"]),

      description: json["Description"] ?? json["poBillDescription"],

      rate: toDoubleValue(json["Rate"] ?? json["rate"]),
      poRate: toDoubleValue(json["poRate"]),

      discPer: toDoubleValue(json["Disc_Per"] ?? json["discntPercentage"]),
      discAmt: toDoubleValue(json["Disc_Amt"] ?? json["discntAmount"]),

      remarks: json["remarks"] ?? json["Remarks"],

      sgstPer: toDoubleValue(json["SGSTPer"] ?? json["sgstPercentage"]),
      sgstAmt: toDoubleValue(json["SGSTAmt"] ?? json["sgstAmount"]),

      cgstPer: toDoubleValue(json["CGSTPer"] ?? json["cgstPercentage"]),
      cgstAmt: toDoubleValue(json["CGSTAmt"] ?? json["cgstAmount"]),

      igstPer: toDoubleValue(json["IGSTPer"] ?? json["igstPercentage"]),
      igstAmt: toDoubleValue(json["IGSTAmt"] ?? json["igstAmount"]),

      vatType: json["Vat_Type"] ?? json["vatType"],

      amount: toDoubleValue(json["Amount"] ?? json["amount"]),
      netAmount: toDoubleValue(json["NetAmount"] ?? json["netAmount"]),

      status: json["Status"] ?? json["status"],
      approxDays: json["approxDays"],
    );
  }
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
    "approxDays": approxDays,
  };
}

double? toDoubleValue(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}


