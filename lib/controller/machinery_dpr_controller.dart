import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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

  RxString saveButton = RequestConstant.SUBMIT.obs;

  int reqId = 0;

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

}