class grnMaterial_Table{
  int? reqDetId;
  int? stockinId;
  String? transNo;
  int? materialId;
  String? materialName;
  double? qty;
  double? stockQty;
  String? scale;
  int? projectId;
  int? siteId;
  int? supplierId;
  String? returnQty;

  grnMaterial_Map(){
    var mapping =Map<String,dynamic>();
    mapping['reqDetId'] = reqDetId!=null?reqDetId:null;
    mapping['stockinId'] = stockinId!=null?stockinId:null;
    mapping['transNo'] = transNo!=null?transNo:null;
    mapping['materialId'] = materialId!=null?materialId:null;
    mapping['materialName'] = materialName!=null?materialName:null;
    mapping['qty'] = qty!=null?qty:null;
    mapping['stockQty'] = stockQty!=null?stockQty:null;
    mapping['scale'] = scale!=null?scale:null;
    mapping['projectId'] = projectId!=null?projectId:null;
    mapping['siteId'] = siteId!=null?siteId:null;
    mapping['supplierId'] = supplierId!=null?supplierId:null;
    mapping['returnQty'] = returnQty!=null?returnQty:"";
    return mapping;
  }


}