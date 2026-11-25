// To parse this JSON data, do
//
//     final macBillDetModel = macBillDetModelFromJson(jsonString);

import 'dart:convert';

MacBillDetModel macBillDetModelFromJson(String str) => MacBillDetModel.fromJson(json.decode(str));

String macBillDetModelToJson(MacBillDetModel data) => json.encode(data.toJson());

class MacBillDetModel {
  bool? success;
  List<Datum>? data;
  String? message;

  MacBillDetModel({
    this.success,
    this.data,
    this.message
  });

  factory MacBillDetModel.fromJson(Map<String, dynamic> json) => MacBillDetModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  List<int>? detId;
  String? itemDiscription;
  String? unit;
  double? rate;
  double? qty;
  double? amt;
  double? startReading;
  double? endReading;
  double? totalReading;
  String? remarks;

  Datum({
    this.detId,
    this.itemDiscription,
    this.unit,
    this.rate,
    this.qty,
    this.amt,
    this.startReading,
    this.endReading,
    this.totalReading,
    this.remarks,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    detId: List<int>.from(json["detId"].map((x) => x)),
    itemDiscription: json["itemDiscription"],
    unit: json["unit"],
    rate: json["rate"],
    qty: json["qty"],
    amt: json["amt"],
    startReading: json["startReading"],
    endReading: json["endReading"],
    totalReading: json["totalReading"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "detId": List<dynamic>.from(detId!.map((x) => x)),
    "itemDiscription": itemDiscription,
    "unit": unit,
    "rate": rate,
    "qty": qty,
    "amt": amt,
    "startReading": startReading,
    "endReading": endReading,
    "totalReading": totalReading,
    "remarks": remarks,
  };
}
