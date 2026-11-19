import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/repairConsumEditRes.dart';
import '../models/repairConsumptionList_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class RepairConsumptionProvider{

  static Future<RepairConsumptionGetAllRes?> getRepairConsumEntry_List(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETREPAIRCONSUM_ENTRY_LIST}?fromdate=$frdate&todate=$todate");

      return repairConsumptionGetAllResFromJson(value);

    } catch (error) {
      print(error);
      return null;
    }
  }

  static SaveRepairConumScreenEntryAPI(String body, int UsageId, context) async {

    try {
      var response;

      if (UsageId != 0) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_REPAIR_CONUM_UPDATE_API}?id=$UsageId", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.REPAIR_CONSUM_SAVE, body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<RepairConsumEditModel?> Repair_ConsumList_editAPI(int UsageId) async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GET_REPAIR_CONSUM_EDIT_API + "?id=$UsageId");
      return repairConsumEditModelFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<bool> Repair_ConsumList_deleteAPI(int UsageId) async {
    try {
      final response = await ApiManager.deleteAPICall(ApiConstant.DELETE_REPAIR_CONSUMPTION_API + "?id=$UsageId");

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