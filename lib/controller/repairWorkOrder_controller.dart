import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/sitecontroller.dart';
import 'package:nicon/provider/repairWorkOrder_provider.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class RepairWorkOrderController extends GetxController{

  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RepairworkOrdDateController = TextEditingController();
  final PreparedByController = TextEditingController();
  final RemarksController = TextEditingController();
  final ConsumptionNoController = TextEditingController();
  final WorkStatusTypeText = TextEditingController();
  final RepairEntryTypeText = TextEditingController();

  RxList repairWorkOrder_List = [].obs;
  RxList main_entryList = [].obs;
  RxList consumptionNoList = [].obs;
  RxInt selectedConsumNoId = 0.obs;
  RxString workOrdStsTypeId = "".obs;
  RxString entryTypeId = "".obs;

  int workid = 0;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());

  Future getRepairWorkOrder_EntryList() async {
    repairWorkOrder_List.value = [];
    main_entryList.value = [];
    final value = await RepairWorkOrderProvider.getRepairWorkOrder_List(
        EntrylistFrDate.text, EntrylistToDate.text);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          repairWorkOrder_List.value = value.result!;
          main_entryList.value = value.result!;
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }


  Future<void> getRepairConsumption_NoList() async {
    consumptionNoList.value = [];
    var response = await RepairWorkOrderProvider.getRepair_ConsumptionNo(projectController.selectedProjectId.value,siteController.selectedsiteId.value);

    if (response != null ){
      if(response["success"] == true) {
        consumptionNoList.value = response["data"] ?? [];
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }else {
        BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
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
                          bool result = await EntryList_DeleteApi(
                              repairWorkOrder_List[index].id);
                          if (result) {
                            repairWorkOrder_List.removeAt(index);
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Delete",
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

  Future<bool> EntryList_DeleteApi(int WorkId) async {
    return RepairWorkOrderProvider.entryList_deleteAPI(WorkId);
  }

}