// To parse this JSON data, do
//
//     final datePickerResponse = datePickerResponseFromJson(jsonString);

import 'dart:convert';

DatePickerResponse datePickerResponseFromJson(String str) => DatePickerResponse.fromJson(json.decode(str));

String datePickerResponseToJson(DatePickerResponse data) => json.encode(data.toJson());

class DatePickerResponse {
  bool? success;
  Response? response;

  DatePickerResponse({
    this.success,
    this.response,
  });

  factory DatePickerResponse.fromJson(Map<String, dynamic> json) => DatePickerResponse(
    success: json["success"],
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "response": response?.toJson(),
  };
}

class Response {
  int? id;
  int? menuId;
  String? screenName;
  String? fieldName;
  int? adminUser;
  int? officeUser;
  int? siteUser;

  Response({
    this.id,
    this.menuId,
    this.screenName,
    this.fieldName,
    this.adminUser,
    this.officeUser,
    this.siteUser,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
