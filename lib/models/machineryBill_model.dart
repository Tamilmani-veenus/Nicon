import 'dart:convert';

class MachineryBillDetLocal {
  int? localId;
  List<int>? detId;
  String? itemDiscription;
  String? unit;
  int? unitId;
  double? rate;
  double? qty;
  double? amt;
  double? startReading;
  double? endReading;
  double? totalReading;
  String? remarks;

  MachineryBillDetLocalModelMap() {
    var mapping = Map<String, dynamic>();
    mapping['localId'] = localId;
    mapping['detId'] = jsonEncode(detId ?? []);
    mapping['itemDiscription'] = itemDiscription;
    mapping['unit'] = unit;
    mapping['unitId'] = unitId;
    mapping['rate'] = rate;
    mapping['qty'] = qty;
    mapping['amt'] = amt;
    mapping['startReading'] = startReading;
    mapping['endReading'] = endReading;
    mapping['totalReading'] = totalReading;
    mapping['remarks'] = remarks;

    return mapping;
  }
}