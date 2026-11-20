import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/workOrderDirect_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class RepairWorkOrderProvider{

  static Future<WorkOrdDirectModel?> getRepairWorkOrder_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_REPAIR_WORKORDER_LIST + "?fromDate=$frdate&toDate=$todate");
      print("AdvEntryList:" + value);
      return workOrdDirectModelFromJson(value);
    }
    catch(e,error){
      print("ERROR.....$e");
      print("ERROR......${error}");
      return null;
    }
  }

  static Future<dynamic> getRepair_ConsumptionNo(int pId, int sId) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GET_CONSUMPTION_NO_LIST}?projectId=$pId&siteId=$sId");
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> entryList_deleteAPI(int WorkId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_REPAIR_WORKORDER_API}?id=$WorkId");

      final Map<String, dynamic> decoded = jsonDecode(response);


      bool isSuccess = decoded["success"] == true;

      final message = decoded["message"] ??
          (isSuccess
              ? "Deleted successfully"
              : "Something went wrong");

      BaseUtitiles.showToast(message);

      return isSuccess;
    } catch (error) {
      print("Delete API Error: $error");
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      return false;
    }
  }
}