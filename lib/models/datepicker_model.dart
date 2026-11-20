// To parse this JSON data, do
//
//     final datePickerResponse = datePickerResponseFromJson(jsonString);

import 'dart:convert';

DatePickerResponse datePickerResponseFromJson(String str) => DatePickerResponse.fromJson(json.decode(str));

String datePickerResponseToJson(DatePickerResponse data) => json.encode(data.toJson());

class DatePickerResponse {
  bool? success;
  List<DatePermission>? response;
  String? message;

  DatePickerResponse({
    this.success,
    this.response,
    this.message
  });

  factory DatePickerResponse.fromJson(Map<String, dynamic> json) => DatePickerResponse(
    success: json["success"],
    response: json["response"] == null ? [] : List<DatePermission>.from(json["response"]!.map((x) => DatePermission.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "response": response == null ? [] : List<dynamic>.from(response!.map((x) => x.toJson())),
    "message": message
  };
}

class DatePermission {
  int? id;
  int? menuId;
  String? screenName;
  String? fieldName;
  int? adminUser;
  int? officeUser;
  int? siteUser;

  DatePermission({
    this.id,
    this.menuId,
    this.screenName,
    this.fieldName,
    this.adminUser,
    this.officeUser,
    this.siteUser,
  });

  factory DatePermission.fromJson(Map<String, dynamic> json) => DatePermission(
    id: json["id"],
    menuId: json["menuId"],
    screenName: json["screenName"],
    fieldName: json["fieldName"],
    adminUser: json["adminUser"],
    officeUser: json["officeUser"],
    siteUser: json["siteUser"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuId": menuId,
    "screenName": screenName,
    "fieldName": fieldName,
    "adminUser": adminUser,
    "officeUser": officeUser,
    "siteUser": siteUser,
  };
}
