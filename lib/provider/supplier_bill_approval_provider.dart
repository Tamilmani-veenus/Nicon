import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/supp_bill_app_getbyid_model.dart';
import '../utilities/apiconstant.dart';

class SupplierBillAppProvider{
  static Future<SuppBillAppGetById?> SupplierBillGetByIdAPI(int reqId) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.GET_SUPP_BILL_APP_EDIT_API}?id=$reqId");
      return suppBillAppGetByIdFromJson(value);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }
  static Future SupplierBillImgListAPI(int reqId,type) async {
    try {
      final value = await ApiManager.getAPICall(type=="P"?"${ApiConstant.GET_SUP_BILL_INWIMAGE_API}?id=$reqId":"${ApiConstant.GET_SUP_BILL_POIMAGE_API}?id=$reqId");
      return jsonDecode(value);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }
}