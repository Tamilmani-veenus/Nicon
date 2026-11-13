// To parse this JSON data, do
//
//     final machineryListModel = machineryListModelFromJson(jsonString);

import 'dart:convert';

MachineryListModel machineryListModelFromJson(String str) => MachineryListModel.fromJson(json.decode(str));

String machineryListModelToJson(MachineryListModel data) => json.encode(data.toJson());

class MachineryListModel {
  bool? success;
  String? message;
  List<MacIndentResult>? result;

  MachineryListModel({
    this.success,
    this.message,
    this.result,
  });

  factory MachineryListModel.fromJson(Map<String, dynamic> json) => MachineryListModel(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null
        ? []
        : List<MacIndentResult>.from(
        json["result"].map((x) => MacIndentResult.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };

}

class MacIndentResult {
  int? id;
  String? reqOrdNo;
  String? reqOrdDate;
  String? reqDueDate;
  String? projectName;
  String? siteName;
  String? requestType;
  bool? isEdit;
  String? createdByName;

  MacIndentResult({
  this.id,
  this.reqOrdNo,
  this.reqOrdDate,
  this.reqDueDate,
  this.projectName,
  this.siteName,
  this.requestType,
  this.isEdit,
  this.createdByName,
  });

  factory MacIndentResult.fromJson(Map<String, dynamic> json) => MacIndentResult(
    id: json["id"],
    reqOrdNo: json["reqOrdNo"],
    reqOrdDate: json["reqOrdDate"],
    reqDueDate: json["reqDueDate"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    requestType: json["requestType"],
    isEdit: json["isEdit"],
    createdByName: json["createdByName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reqOrdNo": reqOrdNo,
    "reqOrdDate": reqOrdDate,
    "reqDueDate": reqDueDate,
    "projectName": projectName,
    "siteName": siteName,
    "requestType": requestType,
    "isEdit": isEdit,
    "createdByName": createdByName,
  };
}
