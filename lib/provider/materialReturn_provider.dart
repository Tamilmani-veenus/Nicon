import 'dart:convert';
import '../apimanager/apimanager.dart';
import '../models/matRetGrnList_model.dart';
import '../models/materialReturn_list_res.dart';
import '../models/materialret_edit_model.dart';
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

  // static Future<String?> SaveGRNMaterialSaveAPI(String body, String returnId, int buttonControl, context) async {
  //   String? ratingRes;
  //
  //   try {
  //     if (returnId != "0") {
  //       final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_GRNMATERIAL_RETURN_SAVEAPI, body);
  //       var response = saveDeduction_SaveResponseFromJson(value);
  //       if (response.RetString != null) {
  //         ratingRes = response.RetString;
  //       }
  //     } else {
  //       final value = await ApiManager.postAPICall(ApiConstant.POST_GRNMATERIAL_RETURN_SAVEAPI, body);
  //       var response = saveDeduction_SaveResponseFromJson(value);
  //       if (response.RetString != null) {
  //         ratingRes = response.RetString;
  //       }
  //     }
  //   }
  //
  //   on SocketException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //
  //   on TimeoutException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //
  //   on FormatException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //
  //   catch (error, stackTrace) {
  //     print("Error in SaveMaterialScreenEntryAPI: $error");
  //     print(stackTrace);
  //     buttonControl = 0;
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
  //   }
  //
  //   return ratingRes;
  // }

  static Future<List<GetMaterialRetEditModel>> MatRetrnList_editAPI(int ReturnId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_MATRETURN_EDIT_LIST + "?ReturnId=$ReturnId").then((value) {
      final res = getMaterialRetEditModelFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

}