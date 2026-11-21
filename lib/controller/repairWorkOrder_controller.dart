import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicon/controller/pendinglistcontroller.dart';
import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/sitecontroller.dart';
import 'package:nicon/controller/subcontcontroller.dart';
import 'package:nicon/controller/workOrderBoq_Controller.dart';
import 'package:nicon/controller/workorderDirect_Controller.dart';
import 'package:nicon/provider/repairWorkOrder_provider.dart';
import '../home/menu/repair/repairWorkOrder/repair_WorkOrder_EntryScreen.dart';
import '../models/repairWorkOrder_save_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

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
  RxInt createdById = 0.obs;

  RxList repair_workOrd_editListApi = [].obs;

  int workid = 0;
  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxList<RepairWorkOrderDetlink> getDetList = <RepairWorkOrderDetlink>[].obs;
  RxList<RepairWorkOrderAddLessSetuplink> getDetAddLessList = <RepairWorkOrderAddLessSetuplink>[].obs;

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  WorkOrderDirectController workOrderDirectController = Get.put(WorkOrderDirectController());
  LoginController loginController = Get.put(LoginController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  WorkOrderBoqController workOrderBoqController = Get.put(WorkOrderBoqController());
  PendingListController pendingListController = Get.put(PendingListController());

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

  clearDatas() {
    saveButton.value = RequestConstant.SUBMIT;
    workid = 0;
    projectController.projectname.text = "--SELECT--";
    projectController.selectedProjectId.value = 0;
    subcontractorController.supplierName.text = "--SELECT--";
    subcontractorController.selectedSupplierId.value = 0;
    RepairworkOrdDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    siteController.selectedsiteId = 0.obs;
    siteController.selectedsitedropdownName = "--SELECT--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    WorkStatusTypeText.text = "";
    workOrdStsTypeId.value = "";
    ConsumptionNoController.text = "";
    selectedConsumNoId.value = 0;
    workOrderDirectController.workOrder_itemlistTable_Delete();
    workOrderDirectController.ItemGetTableListdata.value.clear();
    workOrderDirectController.workOrdamount.text = "0.0";
    workOrderDirectController.Roundoff.text = "0";
    workOrderDirectController.netpayamt.text = "0.0";
    workOrderDirectController.rebateAmount.text = "0.0";
  }

  Future SaveButton_DeductionScreen(
      BuildContext context, int id, int workOrderId, status) async {
    workOrderDirectController.getDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    await Future.delayed(const Duration(seconds: 0));
    String termsConditionIds = workOrderBoqController.selectedTerms
        .map((e) => e.id.toString())
        .join(",");
    String body = repairWorkOrderSaveModelToJson(RepairWorkOrderSaveModel(
      id:id != 0 ? id : 0,
      workOrderNo: autoYearWiseNoController.text,
      entryDate: RepairworkOrdDateController.text,
      entryType: "R",
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      supplierId: subcontractorController.selectedSupplierId.value,
      workStatus: workOrdStsTypeId.value,
      repairConsumptionId: selectedConsumNoId.value,
      roundOff: double.tryParse(workOrderDirectController.Roundoff.text) ?? 0.0,
      workOrderAmount: double.tryParse(workOrderDirectController.workOrdamount.text)?? 0.0,
      netAmount: double.tryParse(workOrderDirectController.netpayamt.text)?? 0.0,
      termsCondition:termsConditionIds,
      mailStatus: "N",
      downloadStatus: "N",
      verifyBy: 0,
      approvedBy: 0,
      active: "Y",
      remarks: RemarksController.text,
      createdBy: saveButton.value == RequestConstant.SUBMIT?int.parse(loginController.EmpId()):createdById.value,
      // createdDt: BaseUtitiles().convertToUtcIso(workOrdentryDateController.text),
      verifyStatus: saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL
          ? "Y"
          : "N",
      approveStatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
      repairWorkOrderDetlink: getWorkOrderDet(id),
      repairWorkOrderAddLessSetuplink:
      getWorkOrderDetAddLess(id, autoYearWiseNoController.text),
    ));
    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);

    final list = await RepairWorkOrderProvider.SaveRepairWorkOrdScreenEntryAPI(
        body, id, context,status);

    if (list != null) {
      if (list["success"] == true) {
        clearDatas();
        BaseUtitiles.showToast(list["message"]);
        if (saveButton.value == RequestConstant.VERIFY ||
            saveButton.value == RequestConstant.APPROVAL) {
          await pendingListController.getPendingList();
        } else {
          await getRepairWorkOrder_EntryList();
          workOrderDirectController.workOrder_itemlistTable_Delete();
        }
        BaseUtitiles.popMultiple(context, count: 5);
      } else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<RepairWorkOrderDetlink>? getWorkOrderDet(id) {
    getDetList.value.clear();
    workOrderDirectController.ItemGetTableListdata.value.forEach((element) {
      var list = RepairWorkOrderDetlink(
          id: saveButton.value == RequestConstant.RESUBMIT ? element.reqDetId : 0,
          repairWorkOrderMasId: id != 0 ? id : 0,
          itemDescription: element.Name.toString(),
          unit: element.unit.toString(),
          qty: element.qty,
          rate: element.rate,
          amount: element.amount,
          workRemarks: ""
      );
      getDetList.value.add(list);
    });
    return getDetList.value;
  }

  List<RepairWorkOrderAddLessSetuplink>? getWorkOrderDetAddLess(int id, workNo) {
    getDetAddLessList.value.clear();
    workOrderDirectController.workOrder_ItemReadList.value.forEach((element) {
      if (element.percentValue! > 0) {
        var list = RepairWorkOrderAddLessSetuplink(
          id: element.reqDetId,
          repairWorkOrderMasId: id,
          workOrderNo: autoYearWiseNoController.text,
          addLessId: element.addLessId,
          percentValue: element.percentValue,
          amount: element.amount,
        );
        getDetAddLessList.value.add(list);
      }
    });
    return getDetAddLessList.value;
  }

  Future repair_workOrderList_EditApi(int workId, status,String MenuName, BuildContext context,{String? type}) async {
    await ClickUtils.run(() async {
      var response = await RepairWorkOrderProvider.repair_WorkOrderList_editAPI(workId,status);
      if (response != null) {
        if (response.success == true) {
          repair_workOrd_editListApi.value = [response.result];
          if (repair_workOrd_editListApi.isNotEmpty) {
            saveButton.value = type == "Approve"? RequestConstant.APPROVAL: type == "Verify" ? RequestConstant.VERIFY : RequestConstant.RESUBMIT;
            workOrderDirectController.workOrder_EditTable_SaveTable("",type: "Repair Work Order",list: repair_workOrd_editListApi);
            workOrderDirectController.getItemlistTablesDatas();
            await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RepairWorkOrderEntryScreen(heading: MenuName,)));
          } else {
            BaseUtitiles.showToast("No Data Found");
          }
        } else {
          BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
        }
      } else {
        BaseUtitiles.showToast("Something Went Wrong...");
      }
    });
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