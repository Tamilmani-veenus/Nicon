import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/machinery_edit_model.dart';
import '../models/machinery_indent_list_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MachineryIndentProvider {

  static Future<MachineryListModel?> getMachineryEntryList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETMAC_INDENT_ENTRY_LIST}?Frdate=$frdate&Todate=$todate&projectId=0");
      return  machineryListModelFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future<dynamic> SaveMachineryIntentAPI(String body, reqId, saveButton, context) async {

    try {
      var response;
      if(saveButton == RequestConstant.SUBMIT){
        response = await ApiManager.postAPICall(ApiConstant.MACHINERY_REQUEST_SAVE, body);
      }
      else if(saveButton == RequestConstant.RESUBMIT || saveButton == RequestConstant.VERIFY || saveButton == RequestConstant.APPROVAL){
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_MACHINERY_UPDATE_API}/$reqId", body);
      }
      else if(saveButton == RequestConstant.PREAPPROVAL){
        response = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_MACHINERY_PREAPPROVE_API, body);
      }
      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<MachineryEditModel?> machineryIndentEditAPI(int reqId,from) async {
    try {
      final value = await ApiManager.getAPICall(
          from=="Edit"?"${ApiConstant.GET_MACHINERY_EDIT_API}?id=$reqId":
          from=="Verify"?"${ApiConstant.GET_MACHINERY_VERIFY_API}?id=$reqId":
          from=="Preapprove"?"${ApiConstant.GET_MACHINERY_PREAPPROVE_API}?id=$reqId":
          "${ApiConstant.GET_MACHINERY_APPROVE_API}/$reqId"
      );
      return machineryEditModelFromJson(value);
    } catch (error,e) {
      print("Error == $e");
      print("Error == $error");
      return null;
    }
  }

  static Future<bool> machineryListDeleteAPI(int reqId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_MACHINERY_ENTRYLIST_API}/$reqId");

      final Map<String, dynamic> decoded = jsonDecode(response);


      bool isSuccess = decoded["success"] == true;

      final message = decoded["message"] ??
          (isSuccess
              ? "Deleted successfully"
              : RequestConstant.NETWORKERROR);

      BaseUtitiles.showToast(message);

      return isSuccess;
    } catch (error) {
      print("Delete API Error: $error");
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return false;
    }
  }

}