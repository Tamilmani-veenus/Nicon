import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../db_services/materiallist_service.dart';
import '../models/machinery_dpr_det_model.dart';
import '../models/machinerydpr_model.dart';
import '../provider/machinery_indent_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

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
  RxList macReqEtyDetList = [].obs;

  RxString saveButton = RequestConstant.SUBMIT.obs;

  int reqId = 0;

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

  Future getMacDPRDetList(proId,SiteId,subId) async {
    macReqEtyDetList.value=[];
    var response = await MachineryDPRProvider.getMachineryDPRDetList(
        proId,SiteId,subId);
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"]!.isNotEmpty) {
          macReqEtyDetList.add(response["result"]!);
          await MachineryDPRDetLocal_editSaveDetTable(list: response["result"], subId: subId);
          await getMachineryDPRDetLocalDatas(subId);
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
}