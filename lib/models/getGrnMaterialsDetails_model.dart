// To parse this JSON data, do
//
//     final getGrnMaterialDetailsList = getGrnMaterialDetailsListFromJson(jsonString);

import 'dart:convert';

List<GetGrnMaterialDetailsList> getGrnMaterialDetailsListFromJson(String str) => List<GetGrnMaterialDetailsList>.from(json.decode(str).map((x) => GetGrnMaterialDetailsList.fromJson(x)));

String getGrnMaterialDetailsListToJson(List<GetGrnMaterialDetailsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetGrnMaterialDetailsList {
  String? materialId;
  String? materialName;

  GetGrnMaterialDetailsList({
    this.materialId,
    this.materialName,
  });

  factory GetGrnMaterialDetailsList.fromJson(Map<String, dynamic> json) => GetGrnMaterialDetailsList(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
  };
}
