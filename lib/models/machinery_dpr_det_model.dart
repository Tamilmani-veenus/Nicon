// // To parse this JSON data, do
// //
// //     final machineryDprDet = machineryDprDetFromJson(jsonString);
//
// import 'dart:convert';
//
// MachineryDprDet machineryDprDetFromJson(String str) => MachineryDprDet.fromJson(json.decode(str));
//
// String machineryDprDetToJson(MachineryDprDet data) => json.encode(data.toJson());
//
// class MachineryDprDet {
//   bool? success;
//   List<Result>? result;
//   String? message;
//
//   MachineryDprDet({
//     this.success,
//     this.result,
//     this.message
//   });
//
//   factory MachineryDprDet.fromJson(Map<String, dynamic> json) => MachineryDprDet(
//     success: json["success"],
//     message: json["message"],
//     result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
//   };
// }
//
// class Result {
//   int? id;
//   int? subcontractWorkOrderMasId;
//   int? detSiteId;
//   int? projectId;
//   String? projectName;
//   int? masSiteId;
//   String? siteName;
//   String? itemDescription;
//   double? qty;
//   int? unit;
//   String? scaleName;
//   double? rate;
//   double? amount;
//   String? workRemarks;
//   int? machineryReqDetid;
//
//   Result({
//     this.id,
//     this.subcontractWorkOrderMasId,
//     this.detSiteId,
//     this.projectId,
//     this.projectName,
//     this.masSiteId,
//     this.siteName,
//     this.itemDescription,
//     this.qty,
//     this.unit,
//     this.scaleName,
//     this.rate,
//     this.amount,
//     this.workRemarks,
//     this.machineryReqDetid,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["id"],
//     subcontractWorkOrderMasId: json["subcontractWorkOrderMasId"],
//     detSiteId: json["detSiteId"],
//     projectId: json["projectId"],
//     projectName: json["projectName"],
//     masSiteId: json["masSiteId"],
//     siteName: json["siteName"],
//     itemDescription: json["itemDescription"],
//     qty: json["qty"],
//     unit: json["unit"],
//     scaleName: json["scaleName"],
//     rate: json["rate"],
//     amount: json["amount"],
//     workRemarks: json["workRemarks"],
//     machineryReqDetid: json["machineryReqDetid"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "subcontractWorkOrderMasId": subcontractWorkOrderMasId,
//     "detSiteId": detSiteId,
//     "projectId": projectId,
//     "projectName": projectName,
//     "masSiteId": masSiteId,
//     "siteName": siteName,
//     "itemDescription": itemDescription,
//     "qty": qty,
//     "unit": unit,
//     "scaleName": scaleName,
//     "rate": rate,
//     "amount": amount,
//     "workRemarks": workRemarks,
//     "machineryReqDetid": machineryReqDetid,
//   };
// }
