import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../apimanager/apimanager.dart';
import '../models/supp_bill_app_getbyid_model.dart';
import '../models/supplier_bill_approve_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/requestconstant.dart';

class SupplierBillAppProvider{
  static Future<SuppBillAppGetById?> SupplierBillGetByIdAPI(int reqId,type) async {
    try {
      final value = await ApiManager.getAPICall(type=="G" || type=="W"?"${ApiConstant.GET_SUPP_BILL_DIRECT_APP_EDIT_API}?id=$reqId":"${ApiConstant.GET_SUPP_BILL_APP_EDIT_API}?id=$reqId");
      return suppBillAppGetByIdFromJson(value);
    } catch (error,e) {
      print("Error == $e");
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

  static Future<dynamic> approveSuppBillApproveAPI(String body, reqId) async {

    try {
      var  response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_SUPP_BILL_APPROVE_API}?id=$reqId", body);

      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<dynamic> approveSuppBillApproveFormDataAPI(ApproveSuppBillApiModel data, int id) async {
    try {
      final url = "${ApiConstant.PUT_SUPP_BILL_WO_APPROVE_API}?id=$id"; // Use your existing approval URL

      final request = http.MultipartRequest(
        'PUT',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());

      // Parent fields
      final bodyData = <String, dynamic>{
        "id": data.id,
        "BillNo": data.billNo,
        "Entrydate": data.entrydate,
        "BillType": data.billType,
        "PoBillType": data.poBillType,
        "ProjectID": data.projectId,
        "SiteID": data.siteId,
        "SupplierID": data.supplierId,
        "DcNo": data.dcNo,
        "DcDate": data.dcDate,
        "InvoiceNo": data.invoiceNo,
        "BillDate": data.billDate,
        "PurOrdMasId": data.purOrdMasId,
        "WorkOrdMasId": data.workOrdMasId,
        "ReqOrdMasId": data.reqOrdMasId,

        "FrieghtCharges": data.frieghtCharges,
        "LabourCharges": data.labourCharges,
        "OtherCharges": data.otherCharges,
        "RoundOff": data.roundOff,

        "SGSTPercentage": data.sgstPercentage,
        "SGSTAmount": data.sgstAmount,
        "NetSGSTAmount": data.netSgstAmount,

        "CGSTPercentage": data.cgstPercentage,
        "CGSTAmount": data.cgstAmount,
        "NetCGSTAmount": data.netCgstAmount,

        "IGSTPercentage": data.igstPercentage,
        "IGSTAmount": data.igstAmount,
        "NetIGSTAmount": data.netIgstAmount,

        "TDSPercentage": data.tdsPercentage,
        "TDSAmount": data.tdsAmount,
        "TCSPercentage": data.tcsPercentage,
        "TCSAmount": data.tcsAmount,

        "TotalAmount": data.totalAmount,
        "DiscntAmount": data.discntAmount,
        "DiscntPercentage": data.discntPercentage,

        "GSTApply": data.gstApply,
        "AdvanceAmount": data.advanceAmount,
        "NetAmount": data.netAmount,
        "NetPayAmount": data.netPayAmount,
        "Remarks": data.remarks,

        "CreatedBy": data.createdBy,
        "CreatedDt": data.createdDt,
        "VerifyBy": data.verifyBy,
        "VerifyStatus": data.verifyStatus,
        "Verifydate": data.verifydate,

        "ApproveBy": data.approveBy,
        "ApproveStatus": data.approveStatus,
        "ApproveDate": data.approveDate,

        "DebitNoteAmt": data.debitNoteAmt,
        "DebitNoteRemarks": data.debitNoteRemarks,
        "DebitNoteType": data.debitNoteType,

        "EWayBill": data.eWayBill,
        "EWayBillNo": data.eWayBillNo,
        "SubContractorId": data.subContractorId,
        "EWayBillImage": data.eWayBillImage,
        "EWayBillDate": data.eWayBillDate,

        "TallyType": data.tallyType,
        "MaterialInwMasId": data.materialInwMasId,

        "CompanyId": data.companyId,
        "WorkOrderId": data.workOrderId,
        "FromDate": data.fromDate,
        "ToDate": data.toDate,
      };

      // Add parent fields
      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // MaterialPurOrdBilldetLink - indexed fields
      if (data.materialPurOrdBilldetLink != null &&
          data.materialPurOrdBilldetLink!.isNotEmpty) {

        for (int i = 0;
        i < data.materialPurOrdBilldetLink!.length;
        i++) {

          final det = data.materialPurOrdBilldetLink![i];

          final prefix = 'MaterialPurOrdBilldetLink[$i].';

          final detailData = <String, dynamic>{
            "id": det.id,
            "materialPurOrdBillMasID": det.materialPurOrdBillMasId,
            "purOrdDetId": det.purOrdDetId,
            "workOrdDetId": det.workOrdDetId,
            "reqOrdDetId": det.reqOrdDetId,
            "materialID": det.materialId,
            "scaleID": det.scaleId,
            "qty": det.qty,
            "rate": det.rate,
            "amount": det.amount,
            "sgstPercentage": det.sgstPercentage,
            "sgstAmount": det.sgstAmount,
            "cgstPercentage": det.cgstPercentage,
            "cgstAmount": det.cgstAmount,
            "igstPercentage": det.igstPercentage,
            "igstAmount": det.igstAmount,
            "discntPercentage": det.discntPercentage,
            "discntAmount": det.discntAmount,
            "netAmount": det.netAmount,
            "inwQty": det.inwQty,
            "poRate": det.poRate,
            "remarks": det.remarks,
            "approxDays": det.approxDays,
            "expiryDate": det.expiryDate,
            "poBillDescription": det.poBillDescription,
          };

          detailData.forEach((key, value) {
            if (value != null) {
              request.fields['$prefix$key'] = value.toString();
            }
          });
        }
      }

      if (kDebugMode) {
        print("========== SUPPLIER BILL FORMDATA ==========");
        print("URL: $url");
        print("Fields: ${request.fields}");
        print("============================================");
      }

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (kDebugMode) {
        print("Status Code: ${response.statusCode}");
        print("Response: $responseBody");
      }

      return jsonDecode(responseBody);

    } catch (error) {
      debugPrint("Supplier Bill FormData Error: $error");
      return null;
    }
  }

}