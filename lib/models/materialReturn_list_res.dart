// To parse this JSON data, do
//
//     final materialReturnEntryListResponse = materialReturnEntryListResponseFromJson(jsonString);

import 'dart:convert';

MaterialReturnEntryListResponse materialReturnEntryListResponseFromJson(String str) => MaterialReturnEntryListResponse.fromJson(json.decode(str));

String materialReturnEntryListResponseToJson(MaterialReturnEntryListResponse data) => json.encode(data.toJson());

class MaterialReturnEntryListResponse {
  bool? success;
  List<Result>? result;
  String? message;

  MaterialReturnEntryListResponse({
    this.success,
    this.result,
    this.message
  });

  factory MaterialReturnEntryListResponse.fromJson(Map<String, dynamic> json) => MaterialReturnEntryListResponse(
    success: json["success"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    message: json["meesage"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? id;
  String? returnNo;
  String? entryDt;
  int? projectid;
  int? siteid;
  int? toSuplierId;
  String? remarks;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;
  String? projectName;
  String? siteName;
  String? toSupplierName;
  String? createdName;
  List<MatReturnLink>? matReturnLink;

  Result({
    this.id,
    this.returnNo,
    this.entryDt,
    this.projectid,
    this.siteid,
    this.toSuplierId,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.projectName,
    this.siteName,
    this.toSupplierName,
    this.createdName,
    this.matReturnLink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    returnNo: json["returnNo"],
    entryDt: json["entryDt"],
    projectid: json["projectid"],
    siteid: json["siteid"],
    toSuplierId: json["toSuplierID"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    toSupplierName: json["toSupplierName"],
    createdName: json["createdName"],
    matReturnLink: json["matReturnLink"] == null ? [] : List<MatReturnLink>.from(json["matReturnLink"]!.map((x) => MatReturnLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "returnNo": returnNo,
    "entryDt": entryDt,
    "projectid": projectid,
    "siteid": siteid,
    "toSuplierID": toSuplierId,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "projectName": projectName,
    "siteName": siteName,
    "toSupplierName": toSupplierName,
    "createdName": createdName,
    "matReturnLink": matReturnLink == null ? [] : List<dynamic>.from(matReturnLink!.map((x) => x.toJson())),
  };
}

class MatReturnLink {
  int? id;
  int? returnId;
  int? materialId;
  double? qty;
  double? rate;
  double? amount;
  int? stockinId;
  String? grNno;
  double? stockQty;
  String? materialName;
  int? unitId;
  String? unitName;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;

  MatReturnLink({
    this.id,
    this.returnId,
    this.materialId,
    this.qty,
    this.rate,
    this.amount,
    this.stockinId,
    this.grNno,
    this.stockQty,
    this.materialName,
    this.unitId,
    this.unitName,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
  });

  factory MatReturnLink.fromJson(Map<String, dynamic> json) => MatReturnLink(
    id: json["id"],
    returnId: json["returnId"],
    materialId: json["materialId"],
    qty: json["qty"],
    rate: json["rate"],
    amount: json["amount"],
    stockinId: json["stockinId"],
    grNno: json["grNno"],
    stockQty: json["stockQty"],
    materialName: json["materialName"],
    unitId: json["unitID"],
    unitName: json["unitName"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "returnId": returnId,
    "materialId": materialId,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "stockinId": stockinId,
    "grNno": grNno,
    "stockQty": stockQty,
    "materialName": materialName,
    "unitID": unitId,
    "unitName": unitName,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
  };
}
