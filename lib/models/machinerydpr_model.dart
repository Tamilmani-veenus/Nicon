class MachineryDPRDetLocal {
  int? localId;
  int? apiId;
  int? projectId;
  String? projectName;
  String? siteName;
  String? itemDescription;
  double? qty;
  int? unit;
  String? scaleName;
  double? rate;
  double? amount;
  String? workRemarks;
  int? machineryReqDetid;
  int? subId;
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
    mapping['projectId'] = projectId;
    mapping['projectName'] = projectName;
    mapping['siteName'] = siteName;
    mapping['itemDescription'] = itemDescription;
    mapping['qty'] = qty;
    mapping['unit'] = unit;
    mapping['scaleName'] = scaleName;
    mapping['rate'] = rate;
    mapping['amount'] = amount;
    mapping['workRemarks'] = workRemarks;
    mapping['machineryReqDetid'] = machineryReqDetid;
    mapping['subId'] = subId;
    mapping['startReading'] = startReading;
    mapping['endReading'] = endReading;
    mapping['totalReading'] = totalReading;
    mapping['enteredQty'] = enteredQty;
    mapping['enteredAmount'] = enteredAmount;
    mapping['remarks'] = remarks;
    return mapping;
  }
}