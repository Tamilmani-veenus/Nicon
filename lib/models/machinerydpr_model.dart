class MachineryDPRDetLocal {
  int? localId;
  int? apiId;
  String? itemDescription;
  int? unit;
  String? scaleName;
  double? rate;
  String? workRemarks;
  int? machineryReqDetid;
  double? startReading;
  double? endReading;
  double? totalReading;
  double? enteredQty;
  double? enteredAmount;
  String? remarks;

  MachineryDPRDetLocalModelMap() {
    var mapping = Map<String, dynamic>();
    mapping['localId'] = localId;
    mapping['apiId'] = apiId;
    mapping['itemDescription'] = itemDescription;
    mapping['unit'] = unit;
    mapping['scaleName'] = scaleName;
    mapping['rate'] = rate;
    mapping['workRemarks'] = workRemarks;
    mapping['machineryReqDetid'] = machineryReqDetid;
    mapping['startReading'] = startReading;
    mapping['endReading'] = endReading;
    mapping['totalReading'] = totalReading;
    mapping['enteredQty'] = enteredQty;
    mapping['enteredAmount'] = enteredAmount;
    mapping['remarks'] = remarks;
    return mapping;
  }
}