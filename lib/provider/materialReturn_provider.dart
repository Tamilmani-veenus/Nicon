import 'dart:convert';
import '../apimanager/apimanager.dart';
import '../models/matRetGrnList_model.dart';
import '../models/materialReturn_list_res.dart';
import '../models/materialret_edit_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MaterialReturnProvider{

  static Future<MaterialReturnEntryListResponse?>  getMatReturn_List(String frdate, String todate) async {
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


  static  getGRNList_API(String? materialId, int? SiteId, int? Supplierid) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_GRN_LIST}?MaterialId=$materialId&SiteId=$SiteId&SupplierId=$Supplierid");

      return jsonDecode(value);
    } catch (error,e) {
      print(error);
      return null;
    }
  }

  static  getUnitAPI(String? materialId) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_MATRETURN_UNIT}?materialId=$materialId");

      return jsonDecode(value);
    } catch (error,e) {
      print(error);
      return null;
    }
  }

  static  getStockQty_API(stockInId) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_MATRETURN_STOCKQTY}?StockInId=$stockInId");

      return jsonDecode(value);
    } catch (error,e) {
      print(error);
      return null;
    }
  }

  static  getMaterialDetailsList_API(int? Projectid, int? SiteId, int? Supplierid) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_GRN_MATERIALDETAILS_LIST}?ProjectId=$Projectid&SiteId=$SiteId&SupplierId=$Supplierid");

      return jsonDecode(value);
    } catch (error,e) {
      print(error);
      return null;
    }
  }

  static SaveMatReturnEntryAPI(String body, reqId) async {

    try {
      var response;

      if (reqId != "0") {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_GRNMATERIAL_RETURN_SAVEAPI}/$reqId", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.POST_GRNMATERIAL_RETURN_SAVEAPI, body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static  MatRetrnList_editAPI(ReturnId) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_MATRETURN_EDIT_LIST}/$ReturnId");

      return getMaterialRetEditModelFromJson(value);
    } catch (error,e) {
      print(error);
      return null;
    }
  }


}