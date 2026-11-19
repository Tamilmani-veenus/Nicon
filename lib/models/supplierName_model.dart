// To parse this JSON data, do
//
//     final supplierNameModel = supplierNameModelFromJson(jsonString);

import 'dart:convert';

SupplierNameModel supplierNameModelFromJson(String str) => SupplierNameModel.fromJson(json.decode(str));

String supplierNameModelToJson(SupplierNameModel data) => json.encode(data.toJson());

class SupplierNameModel {
  bool? success;
  List<Result>? result;
  String? message;

  SupplierNameModel({
    this.success,
    this.result,
    this.message
  });

  factory SupplierNameModel.fromJson(Map<String, dynamic> json) => SupplierNameModel(
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
  String? supplierName;
  String? mailId;

  Result({
    this.id,
    this.supplierName,
    this.mailId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    supplierName: json["supplierName"],
    mailId: json["mailId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplierName": supplierName,
    "mailId": mailId,
  };
}
