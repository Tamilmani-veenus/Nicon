import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../apimanager/apimanager.dart';
import '../models/machinary_dpr_save_model.dart';
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

  static Future<bool> machineryListDeleteAPI(int reqId,type) async {
    try {
      final response = await ApiManager.deleteAPICall(
          type=="macDPR"?"${ApiConstant.DELETE_MACHINERY_DPRLIST_API}?id=$reqId": "${ApiConstant.DELETE_MACHINERY_ENTRYLIST_API}/$reqId");

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

class MachineryDPRProvider {

  static Future getMachineryDPREntryList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant
          .GETMAC_DPR_ENTRY_LIST}?Frdate=$frdate&Todate=$todate");
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future getMachineryDPREditList(reqId) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant
          .GETMAC_DPR_EDIT_LIST}?id=$reqId");
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future getMachineryDPRDetList(pId,sId,subId) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GET_MAC_DPR_DET_LIST}?projectId=$pId&siteId=$sId&subcontractorId=$subId");
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<dynamic> saveSubContractMachineryDailyWorkAPI(
      SubContractMachineryDailyWorkSaveModel data,reqId) async {
    try {
      final bool isUpdate = reqId != 0;

      final String url = isUpdate
          ? '${ApiConstant.SUBCONTRACT_MACHINERY_DAILYWORK_UPDATE_API}?id=$reqId'
          : ApiConstant.SUBCONTRACT_MACHINERY_DAILYWORK_SAVE_API;

      debugPrint("Machinery Daily Work ${isUpdate ? 'UPDATE' : 'SAVE'} API: $url");

      final request = http.MultipartRequest(
        isUpdate ? 'PUT' : 'POST',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());

      final bodyData = data.toJson();

      // Remove detail list from header fields
      bodyData.remove('SubContractMachineryDailyWorkdetLink');

      // Add header fields
      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Add detail fields
      if (data.subContractMachineryDailyWorkdetLink != null &&
          data.subContractMachineryDailyWorkdetLink!.isNotEmpty) {
        for (int i = 0;
        i < data.subContractMachineryDailyWorkdetLink!.length;
        i++) {
          final det = data.subContractMachineryDailyWorkdetLink![i];

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].Id'] =
              (det.id ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].SubContractDailyWorkMasId'] =
              (det.subContractDailyWorkMasId ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].SubcontractMachineryWorkOrderDetId'] =
              (det.subcontractMachineryWorkOrderDetId ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].ScaleId'] =
              (det.scaleId ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].ItemDesc'] =
              (det.itemDesc ?? "").toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].Rate'] =
              (det.rate ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].StartReading'] =
              (det.startReading ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].EndReading'] =
              (det.endReading ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].TotalReading'] =
              (det.totalReading ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].Qty'] =
              (det.qty ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].Amount'] =
              (det.amount ?? 0).toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].WorkRemarks'] =
              (det.workRemarks ?? "-").toString();

          request.fields[
          'SubContractMachineryDailyWorkdetLink[$i].BillStatus'] =
              (det.billStatus ?? "N").toString();
        }
      }

      if (kDebugMode) {
        request.fields.forEach((k, v) => debugPrint("$k : $v"));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Machinery Daily Work Response: $responseBody");

      return jsonDecode(responseBody);
    } catch (error) {
      print("Machinery Daily Work Save Error == $error");
      return null;
    }
  }

}