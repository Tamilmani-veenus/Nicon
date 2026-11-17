import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/materialReturn_list_res.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MaterialReturnProvider{

  static Future<MaterialReturnEntryListResponse?> getMatReturn_List(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETMATERIAL_RETURNLIST}?fromDate=$frdate&toDate=$todate");

      return materialReturnEntryListResponseFromJson(value);


    } catch (error,e) {
      print(error);
      print("SSSSSS...${e}");
      return null;
    }
  }

  static Future<bool> MaterialReturn_List_deleteAPI(int Id) async {
    try {
      final response = await ApiManager.deleteAPICall(ApiConstant.DELETE_MATERIALRETURN_ENTRYLIST_API + "/$Id");

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