import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/sitecontroller.dart';
import '../db_services/materiallist_service.dart';
import '../models/machinary_dpr_save_model.dart';
import '../models/machinery_dpr_det_model.dart';
import '../models/machinerydpr_model.dart';
import '../provider/machinery_indent_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'dailywrk_done_dpr_controller.dart';
import 'logincontroller.dart';

class MachineryDPRController extends GetxController {
  final macDPRListFrDate = TextEditingController();
  final macDPRListToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final requestDateController = TextEditingController();
  final refNoController = TextEditingController();
  final remarksController = TextEditingController();
  final preparedByController = TextEditingController();

  RxList macReqEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList<MachineryDPRDetLocal> macReqEtyDetList = <MachineryDPRDetLocal>[].obs;
  RxList<SubContractMachineryDailyWorkDetSaveModel> machineryDetailsDto = <SubContractMachineryDailyWorkDetSaveModel>[].obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  int reqId = 0;
  RxInt createdById = 0.obs;

  var machineryDPRDetLocalModel = MachineryDPRDetLocal();
  var machineryDPRDetLocalService = MachineryDPRDetLocalService();


  Future getMacDPREntryList() async {
    mainEtyList.value=[];
    macReqEtyList.value=[];
    var response = await MachineryDPRProvider.getMachineryDPREntryList(
        macDPRListFrDate.text, macDPRListToDate.text);
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"]!.isNotEmpty) {
          mainEtyList.assignAll(response["result"]!);
          macReqEtyList.assignAll(response["result"]!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response["message"] ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future<bool> machineryDPRListDeleteApi(int reqId) async {
    return MachineryIndentProvider.machineryListDeleteAPI(reqId,"macDPR");
  }

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await machineryDPRListDeleteApi(macReqEtyList.value[index]["id"]);
                          if (result) {
                            macReqEtyList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getMacDPRDetList(proId, SiteId, subId) async {
    macReqEtyDetList.clear();

    var response = await MachineryDPRProvider.getMachineryDPRDetList(
        proId, SiteId, subId);

    if (response != null) {
      if (response["success"] == true) {
        if (response["result"]!.isNotEmpty) {

          await MachineryDPRDetLocal_editSaveDetTable(
              list: response["result"],
              subId: subId);

          // Load the local DB models
          await getMachineryDPRDetLocalDatas(subId);

        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(
            response["message"] ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future MachineryDPRDetLocal_editSaveDetTable({list, subId}) async {
    List<MachineryDPRDetLocal> machineryDPRDetLocalList = [];

    for (var element in list) {
      machineryDPRDetLocalModel = MachineryDPRDetLocal();

      machineryDPRDetLocalModel.apiId = element['id'];
      machineryDPRDetLocalModel.projectId = element['projectId'];
      machineryDPRDetLocalModel.projectName = element['projectName'];
      machineryDPRDetLocalModel.siteName = element['siteName'];
      machineryDPRDetLocalModel.itemDescription = element['itemDescription'];
      machineryDPRDetLocalModel.qty = double.tryParse(element['qty'].toString()) ?? 0.0;
      machineryDPRDetLocalModel.unit = element['unit'];
      machineryDPRDetLocalModel.scaleName = element['scaleName'];
      machineryDPRDetLocalModel.rate = double.tryParse(element['rate'].toString()) ?? 0.0;
      machineryDPRDetLocalModel.amount = double.tryParse(element['amount'].toString()) ?? 0.0;
      machineryDPRDetLocalModel.workRemarks = element['workRemarks'];
      machineryDPRDetLocalModel.machineryReqDetid = element['machineryReqDetid'];
      machineryDPRDetLocalModel.subId = subId;

      machineryDPRDetLocalModel.startReading = 0;
      machineryDPRDetLocalModel.endReading = 0;
      machineryDPRDetLocalModel.totalReading = 0;
      machineryDPRDetLocalModel.enteredQty = 0;
      machineryDPRDetLocalModel.enteredAmount = 0;
      machineryDPRDetLocalModel.remarks = '';

      machineryDPRDetLocalList.add(machineryDPRDetLocalModel);
    }

    var savedatas = await machineryDPRDetLocalService
        .MachineryDPRDetLocal_table_Save(machineryDPRDetLocalList);

    return savedatas;
  }

  Future getMachineryDPRDetLocalDatas(int subId) async {
    macReqEtyDetList.value = [];

    var Machlist = await machineryDPRDetLocalService
        .MachineryDPRDetLocal_table_readAll();

    Machlist.forEach((user) {
      if (user['subId'] == subId) {
        var machineryDPRDetLocal = MachineryDPRDetLocal();

        machineryDPRDetLocal.localId = user['localId'];
        machineryDPRDetLocal.apiId = user['apiId'];
        machineryDPRDetLocal.projectId = user['projectId'];
        machineryDPRDetLocal.projectName = user['projectName'];
        machineryDPRDetLocal.siteName = user['siteName'];
        machineryDPRDetLocal.itemDescription = user['itemDescription'];
        machineryDPRDetLocal.qty = double.tryParse(user['qty'].toString()) ?? 0.0;
        machineryDPRDetLocal.unit = user['unit'];
        machineryDPRDetLocal.scaleName = user['scaleName'];
        machineryDPRDetLocal.rate = double.tryParse(user['rate'].toString()) ?? 0.0;
        machineryDPRDetLocal.amount = double.tryParse(user['amount'].toString()) ?? 0.0;
        machineryDPRDetLocal.workRemarks = user['workRemarks'];
        machineryDPRDetLocal.machineryReqDetid = user['machineryReqDetid'];
        machineryDPRDetLocal.subId = user['subId'];
        machineryDPRDetLocal.startReading = double.tryParse(user['startReading'].toString()) ?? 0.0;
        machineryDPRDetLocal.endReading = double.tryParse(user['endReading'].toString()) ?? 0.0;
        machineryDPRDetLocal.totalReading = double.tryParse(user['totalReading'].toString()) ?? 0.0;
        machineryDPRDetLocal.enteredQty = double.tryParse(user['enteredQty'].toString()) ?? 0.0;
        machineryDPRDetLocal.enteredAmount = double.tryParse(user['enteredAmount'].toString()) ?? 0.0;
        machineryDPRDetLocal.remarks = user['remarks'] ?? '';

        macReqEtyDetList.add(machineryDPRDetLocal);
      }
    });

    return macReqEtyDetList;
  }

  Future<void> saveItem(MachineryDPRDetLocal item) async {
    if (item.localId == null) {
      debugPrint('DPR local save skipped: localId is null');
      return;
    }
    try {
      await machineryDPRDetLocalService
          .MachineryDPRDetLocal_table_Update([item]);
    } catch (e) {
      debugPrint('DPR local save failed: $e');
    }
  }

  double get totalAmount {
    return macReqEtyDetList.fold<double>(
      0.0,
          (sum, item) => sum + (item.enteredAmount ?? 0.0),
    );
  }

  Future SaveEntryScreen(BuildContext context, int id,projectId,siteId,subcontId,empId) async {
    await Future.delayed(const Duration(seconds: 0));

    SubContractMachineryDailyWorkSaveModel formdata =
    SubContractMachineryDailyWorkSaveModel(
      id: id,
      workNo: autoYearWiseNoController.text,
      workDate: requestDateController.text,
      projectId: projectId,
      siteId: siteId,
      subContractorId: subcontId,
      billStatus: "N",
      totalAmount: totalAmount,
      refNo: refNoController.text,
      remarks: remarksController.text,
      createdBy: saveButton.value == RequestConstant.SUBMIT
          ? int.tryParse(empId)
          : createdById.value,
      verifyBy: saveButton.value == RequestConstant.APPROVAL
          ? int.tryParse(empId)
          : 0,
      verifyStatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
      approvedBy: saveButton.value == RequestConstant.APPROVAL
          ? int.tryParse(empId)
          : 0,
      approveStatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
      subContractMachineryDailyWorkdetLink: getMachineryDetails(id),
    );

    debugPrint(jsonEncode(formdata.toJson()), wrapWidth: 1024);

    final list = await MachineryDPRProvider
        .saveSubContractMachineryDailyWorkAPI(formdata);

    // if (list != null) {
    //   if (list["success"] == true) {
    //     if (saveButton.value == RequestConstant.SUBMIT ||
    //         saveButton.value == RequestConstant.RESUBMIT) {
    //       BaseUtitiles.showToast(list["message"]);
    //       await getEntryList();
    //       BaseUtitiles.popMultiple(context, count: 3);
    //     } else if (saveButton.value == RequestConstant.APPROVAL) {
    //       BaseUtitiles.showToast(list["message"]);
    //       await pendingListController.getPendingList();
    //       BaseUtitiles.popMultiple(context, count: 3);
    //     }
    //   } else {
    //     BaseUtitiles.showToast(
    //         list["message"] ?? 'Something went wrong..');
    //     BaseUtitiles.popMultiple(context, count: 2);
    //   }
    // } else {
    //   BaseUtitiles.showToast("Something went wrong..");
    //   BaseUtitiles.popMultiple(context, count: 3);
    // }
  }

  List<SubContractMachineryDailyWorkDetSaveModel> getMachineryDetails(int id) {
    machineryDetailsDto.value = [];

    for (int index = 0; index < macReqEtyDetList.length; index++) {
      var item = macReqEtyDetList[index];

      if ((item.amount ?? 0) > 0) {
        var list = SubContractMachineryDailyWorkDetSaveModel(
          id: 0,
          subContractDailyWorkMasId: id,
          subcontractMachineryWorkOrderDetId: item.apiId,
          scaleId: item.unit,
          itemDesc: item.itemDescription,
          rate: item.rate,
          startReading: item.startReading,
          endReading: item.endReading,
          totalReading: item.totalReading,
          qty: item.qty,
          amount: item.amount,
          workRemarks: item.remarks,
          billStatus: "N",
        );

        machineryDetailsDto.add(list);
      }
    }

    return machineryDetailsDto;
  }

  deleteDetTableDatas() async {
    await machineryDPRDetLocalService.MachineryDPRDetLocal_table_delete();
  }
}