// To parse this JSON data, do
//

import 'dart:convert';

GrnMaterialsaveResponse GrnMaterialsaveResponseFromJson(String str) => GrnMaterialsaveResponse.fromJson(json.decode(str));

String GrnMaterialsaveResponseToJson(GrnMaterialsaveResponse data) => json.encode(data.toJson());

class GrnMaterialsaveResponse {
  GrnMaterialsaveResponse({
    this.returnId,
    this.returnNo,
    this.returnDate,
    this.projectId,
    this.siteId,
    this.supplierId,
    this.remarks,
    this.preparedby,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.returnDet,
  });

  String? returnId;
  String? returnNo;
  String? returnDate;
  String? projectId;
  String? siteId;
  String? supplierId;
  String? remarks;
  String? preparedby;
  String? userId;
  String? entryMode;
  String? deviceName;
  List<ReturnDet>? returnDet;

  factory GrnMaterialsaveResponse.fromJson(Map<String, dynamic> json) => GrnMaterialsaveResponse(
    returnId: json["ReturnId "],
    returnNo: json["ReturnNo"],
    returnDate: json["ReturnDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    supplierId: json["SupplierId"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    returnDet: List<ReturnDet>.from(json["ReturnDet"].map((x) => ReturnDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReturnId": returnId,
    "ReturnNo": returnNo,
    "ReturnDate": returnDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SupplierId": supplierId,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "ReturnDet": List<dynamic>.from(returnDet!.map((x) => x.toJson())),
  };
}

class ReturnDet {
  ReturnDet({
    this.materialId,
    this.rate,
    this.qty,
    this.amount,
    this.stockInId,
  });

  String? materialId;
  String? rate;
  String? qty;
  String? amount;
  String? stockInId;

  factory ReturnDet.fromJson(Map<String, dynamic> json) => ReturnDet(
    materialId: json["MaterialId"],
    rate: json["Rate"],
    qty: json["Qty"],
    amount: json["Amount"],
    stockInId: json["StockInId"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "Rate": rate,
    "Qty": qty,
    "Amount": amount,
    "StockInId": stockInId,
  };
}
