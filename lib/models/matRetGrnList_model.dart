// To parse this JSON data, do
//
//     final getGrnListModel = getGrnListModelFromJson(jsonString);

import 'dart:convert';

List<GetGrnListModel> getGrnListModelFromJson(String str) => List<GetGrnListModel>.from(json.decode(str).map((x) => GetGrnListModel.fromJson(x)));

String getGrnListModelToJson(List<GetGrnListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetGrnListModel {
  int? stockinId;
  String? transNo;
  int? materialId;
  String? materialName;
  double? qty;
  double? stockQty;
  String? scale;
  int? projectId;
  int? siteId;
  int? supplierId;
  bool? isCheck = false;


  GetGrnListModel({
    this.stockinId,
    this.transNo,
    this.materialId,
    this.materialName,
    this.qty,
    this.stockQty,
    this.scale,
    this.projectId,
    this.siteId,
    this.supplierId,
  });

  factory GetGrnListModel.fromJson(Map<String, dynamic> json) => GetGrnListModel(
    stockinId: json["stockin_id"],
    transNo: json["transno"],
    materialId: json["Materialid"],
    materialName: json["Materialname"],
    qty: json["qty"],
    stockQty: json["StockQty"],
    scale: json["Scale"],
    projectId: json["projectid"],
    siteId: json["siteid"],
    supplierId: json["supplierid"],
  );

  Map<String, dynamic> toJson() => {
    "stockin_id": stockinId,
    "transno": transNo,
    "Materialid": materialId,
    "Materialname": materialName,
    "qty": qty,
    "StockQty": stockQty,
    "Scale": scale,
    "projectid": projectId,
    "siteid": siteId,
    "supplierid": supplierId,
  };
}
