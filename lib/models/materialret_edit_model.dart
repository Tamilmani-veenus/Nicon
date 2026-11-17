// To parse this JSON data, do
//
//     final getMaterialRetEditModel = getMaterialRetEditModelFromJson(jsonString);

import 'dart:convert';

List<GetMaterialRetEditModel> getMaterialRetEditModelFromJson(String str) => List<GetMaterialRetEditModel>.from(json.decode(str).map((x) => GetMaterialRetEditModel.fromJson(x)));

String getMaterialRetEditModelToJson(List<GetMaterialRetEditModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMaterialRetEditModel {
  int? returnId;
  String? returnNo;
  String? returndate;
  int? projectId;
  int? siteId;
  int? supplierid;
  String? projectName;
  String? siteName;
  String? supplierName;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  String? userId;
  String? entryMode;
  List<ReturnEditDet>? returnEditDet;

  GetMaterialRetEditModel({
    this.returnId,
    this.returnNo,
    this.returndate,
    this.projectId,
    this.siteId,
    this.supplierid,
    this.projectName,
    this.siteName,
    this.supplierName,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.returnEditDet,
  });

  factory GetMaterialRetEditModel.fromJson(Map<String, dynamic> json) => GetMaterialRetEditModel(
    returnId: json["ReturnId"],
    returnNo: json["ReturnNo"],
    returndate: json["Returndate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    supplierid: json["Supplierid"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    supplierName: json["SupplierName"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    returnEditDet: List<ReturnEditDet>.from(json["ReturnEditDet"].map((x) => ReturnEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReturnId": returnId,
    "ReturnNo": returnNo,
    "Returndate": returndate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "Supplierid": supplierid,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SupplierName": supplierName,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "ReturnEditDet": List<dynamic>.from(returnEditDet!.map((x) => x.toJson())),
  };
}

class ReturnEditDet {
  int? materialId;
  String? materialName;
  String? unit;
  String? grnNo;
  int? stockinId;
  double? stockQty;
  double? qty;

  ReturnEditDet({
    this.materialId,
    this.materialName,
    this.unit,
    this.grnNo,
    this.stockinId,
    this.stockQty,
    this.qty,
  });

  factory ReturnEditDet.fromJson(Map<String, dynamic> json) => ReturnEditDet(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    grnNo: json["GrnNo"],
    stockinId: json["stockinId"],
    stockQty: json["StockQty"],
    qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "GrnNo": grnNo,
    "stockinId": stockinId,
    "StockQty": stockQty,
    "Qty": qty,
  };
}
