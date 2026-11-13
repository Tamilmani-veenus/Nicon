import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nicon/controller/pendinglistcontroller.dart';
import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/sitecontroller.dart';

import '../home/menu/machinery/machinery_entry.dart';
import '../models/machinery_indent_save_model.dart';
import '../provider/machinery_indent_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import 'mrn_request_indent_controller.dart';

class MachineryIndentController extends GetxController {
  final macIndentListFrDate = TextEditingController();
  final macIndentListToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final remarksController = TextEditingController();
  final requestDateController = TextEditingController();
  final dueDateController = TextEditingController();
  final preparedByController = TextEditingController();
  final reqTypeController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  PendingListController pendingListController = Get.put(PendingListController());
  SiteController siteController = Get.put(SiteController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  RxList macReqEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList machineryEditListApiValue = [].obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxString reqType = "".obs;
  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isVerify => saveButton.value == RequestConstant.VERIFY;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;
  bool get isPreApprove => saveButton.value == RequestConstant.PREAPPROVAL;
  bool get isApprove => saveButton.value == RequestConstant.APPROVAL;
  int reqId = 0;
  RxList<MachineryReqOrdDetLink> getRequestDetList = <MachineryReqOrdDetLink>[].obs;

  Future getMacIndentEntryList() async {
    mainEtyList.value.clear();
    macReqEtyList.value.clear();
    var response = await MachineryIndentProvider.getMachineryEntryList(
        macIndentListFrDate.text, macIndentListToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          macReqEtyList.assignAll(response.result!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future<bool> machineryEntryListDeleteApi(int reqId) async {
    return MachineryIndentProvider.machineryListDeleteAPI(reqId);
  }

  Future<void> deleteAlert(BuildContext context, int index) async {
    // final confirmed = await AppAlertDialog.showAction(context, AlertAction.delete);

    // if (confirmed == true) {
    //   bool result = await machineryEntryListDeleteApi(macReqEtyList.value[index].id);
    //   if (result) {
    //     macReqEtyList.removeAt(index);
    //   }
    // }
  }

  Future SaveMachineryIntentScreen(BuildContext context, int id) async {
    getRequestDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = machinerySaveModelToJson(MachinerySaveModel(
      //common
        id: id != 0 ? id : 0,
        reqOrdNo: autoYearWiseNoController.text.trim(),
        reqOrdDate: requestDateController.text,
        reqDueDate: dueDateController.text,
        requestType: reqType.value.toString().trim(),
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        reqRemarks: remarksController.text,
        isEdit: isResubmit ? true :  false,

        //save
        createdBy: isSubmit ? int.parse(loginController.EmpId()) : null,
        createdDt: isSubmit
            ? BaseUtitiles().convertToUtcIso(requestDateController.text)
            : null,

        //update
        updatedBy: isResubmit ? int.parse(loginController.EmpId()) : null,
        updatedDate: isResubmit
            ? BaseUtitiles().convertToUtcIso(requestDateController.text)
            : null,

        //verify
        verifyBy: isVerify ? int.parse(loginController.EmpId()) : null,
        verifyDate: isVerify
            ? BaseUtitiles().convertToUtcIso(requestDateController.text)
            : null,
        verifyStatus: isResubmit ? machineryEditListApiValue[0].verifyStatus:isVerify ? "Y" : "N",

        preApproveStatus: isResubmit ? machineryEditListApiValue[0].preApproveStatus:isPreApprove?"Y":"N",
        preApproveBy: isPreApprove ? int.parse(loginController.EmpId()) : null,
        preApproveDate: isPreApprove
            ? BaseUtitiles().convertToUtcIso(requestDateController.text)
            : null,

        approveStatus: isResubmit ? machineryEditListApiValue[0].approveStatus:isApprove?"Y":"N",
        approveBy: isApprove ? int.parse(loginController.EmpId()) : null,
        approveDate: isApprove
            ? BaseUtitiles().convertToUtcIso(requestDateController.text)
            : null,
        //det
        machineryReqOrdDetLink:  getRequestDet(id)
    ));

    final list = await MachineryIndentProvider.SaveMachineryIntentAPI(body, id, saveButton.value, context);
    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);
    if (list != null) {
      if (list["success"] == true) {
        if (saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.PREAPPROVAL || saveButton.value == RequestConstant.APPROVAL) {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 4);
        } else {
          BaseUtitiles.showToast(list["message"]);
          await getMacIndentEntryList();
          mrn_request_controller.delete_MaterialIntent_itemlist_Table();
          mrn_request_controller.Material_itemview_GetDbList.clear();
          BaseUtitiles.popMultiple(context, count: 3);
        }
      } else {
        BaseUtitiles.showToast(list?["message"] ?? "Something went wrong..");
        BaseUtitiles.popMultiple(context, count: 1);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 1);
    }
  }

  List<MachineryReqOrdDetLink>? getRequestDet(materialReqOrdMasid) {
    getRequestDetList.value.clear();
    mrn_request_controller.Material_itemview_GetDbList.value.forEach((element) {
      if (element.qty > 0) {
        var list = MachineryReqOrdDetLink(
            id: element.reqDetId,
            machineryReqOrdMasid: materialReqOrdMasid != 0 ? materialReqOrdMasid : 0,
            materialId: element.materialid,
            qty: element.qty,
            scaleId: element.scaleId,
            reqQty: isSubmit || isResubmit ? element.qty : isVerify ? element.reqQty : element.qty,
            remarks: element.remarks,
            reqDesc: element.desc,
            stockQty: 0,
            balQty: 0
        );
        getRequestDetList.value.add(list);
      }
    });
    return getRequestDetList.value;
  }

  Future machineryIndentEdit(int reqId, String MenuName,context,from) async {
    await ClickUtils.run(() async {
      final value = await MachineryIndentProvider.machineryIndentEditAPI(reqId,from);
      if (value != null) {
        if (value.success == true) {
          machineryEditListApiValue.value = [value.result];
          if (machineryEditListApiValue.value.isNotEmpty) {
            mrn_request_controller.Material_Intentlist_editSaveDetTable(type:"Machinery",list:machineryEditListApiValue.value);
            mrn_request_controller.getMaterialTablesDatas();
            if(from=="Edit") {
              saveButton.value = RequestConstant.RESUBMIT;
            }
            else if(from=="Verify") {
              saveButton.value = RequestConstant.VERIFY;
            }
            else if(from=="Preapprove") {
              saveButton.value = RequestConstant.PREAPPROVAL;
            }
            else{
              saveButton.value = RequestConstant.APPROVAL;
            }
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  MachineryIndentEntry(heading: MenuName,)));
          } else {
            BaseUtitiles.showToast("No Data Found");
          }
        } else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      } else {
        BaseUtitiles.showToast('Something went wrong..');
      }
    });
  }


}