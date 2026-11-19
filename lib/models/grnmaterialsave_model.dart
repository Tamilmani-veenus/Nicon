// To parse this JSON data, do
//
//     final grnMaterialsaveResponse = grnMaterialsaveResponseFromJson(jsonString);

import 'dart:convert';

GrnMaterialsaveResponse grnMaterialsaveResponseFromJson(String str) => GrnMaterialsaveResponse.fromJson(json.decode(str));

String grnMaterialsaveResponseToJson(GrnMaterialsaveResponse data) => json.encode(data.toJson());

class GrnMaterialsaveResponse {
  int? id;
  String? returnNo;
  String? entryDt;
  int? projectid;
  int? siteid;
  int? toSuplierId;
  String? remarks;
  String? createdDt;
  String? updatedDt;
  List<MatReturnLink>? matReturnLink;

  GrnMaterialsaveResponse({
    this.id,
    this.returnNo,
    this.entryDt,
    this.projectid,
    this.siteid,
    this.toSuplierId,
    this.remarks,
    this.createdDt,
    this.updatedDt,
    this.matReturnLink,
  });

  factory GrnMaterialsaveResponse.fromJson(Map<String, dynamic> json) => GrnMaterialsaveResponse(
    id: json["id"],
    returnNo: json["returnNo"],
    entryDt: json["entryDt"],
    projectid: json["projectid"],
    siteid: json["siteid"],
    toSuplierId: json["toSuplierID"],
    remarks: json["remarks"],
    createdDt: json["createdDt"],
    updatedDt: json["updatedDt"],
    matReturnLink: List<MatReturnLink>.from(json["matReturnLink"].map((x) => MatReturnLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "returnNo": returnNo,
    "entryDt": entryDt,
    "projectid": projectid,
    "siteid": siteid,
    "toSuplierID": toSuplierId,
    "remarks": remarks,
    "createdDt": createdDt,
    "updatedDt": updatedDt,
    "matReturnLink": List<dynamic>.from(matReturnLink!.map((x) => x.toJson())),
  };
}

class MatReturnLink {
  int? id;
  int? returnId;
  int? materialId;
  double? qty;
  int? rate;
  int? amount;
  int? stockinId;
  String? grNno;
  double? stockQty;
  String? createdDt;
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
    this.createdDt,
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
    createdDt: json["createdDt"],
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
    "createdDt": createdDt,
    "updatedDt": updatedDt,
  };
}
