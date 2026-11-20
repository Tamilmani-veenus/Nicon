import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicon/controller/consumption_controller.dart';
import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/sitecontroller.dart';
import 'package:nicon/controller/subcontcontroller.dart';
import 'package:nicon/home/menu/repair/repairConsumption/repair_Consumption_EntryScreen.dart';
import 'package:nicon/provider/repair_consumption_provider.dart';

import '../models/repairConsumEditRes.dart';
import '../models/repairConsumSave_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class RepairConsumptionController extends GetxController{

  final RepairConsumlistFrDate = TextEditingController();
  final RepairConsumlistToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RepairConsumDate = TextEditingController();
  final PreparedbyController = TextEditingController();
  final RemarksController = TextEditingController();
  final repairTypeController = TextEditingController();

  RxList RepairConsList = [].obs;
  RxList mainEtyList = [].obs;
  String repairType = "";

  int UsageId = 0;
  RxInt createdById = 0.obs;
  RxList<RepairDetLink> getusageDetList = <RepairDetLink>[].obs;
  RxList<RepairConsumResult> RepairConsum_EditListApiValue = <RepairConsumResult>[].obs;

  RxString saveButton = RequestConstant.SUBMIT.obs;

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  Consumption_Controller consumption_controller = Get.put(Consumption_Controller());

  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;

  Future getRepairConsum_EntryList() async {
    mainEtyList.value=[];
    RepairConsList.value=[];
    var response = await RepairConsumptionProvider.getRepairConsumEntry_List(
        RepairConsumlistFrDate.text,
        RepairConsumlistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          RepairConsList.assignAll(response.result!);
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }  else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  clearDatas() {
    UsageId = 0;
    saveButton.value = RequestConstant.SUBMIT;
    projectController.projectname.text = "--Select--";
    projectController.selectedProjectId.value = 0;
    subcontractorController.selectedSupplierId.value = 0;
    subcontractorController.supplierName.text = "--Select--";
    RepairConsumDate.text = BaseUtitiles.initiateCurrentDateFormat();
    PreparedbyController.text = loginController.EmpName();
    siteController.selectedsiteId = 0.obs;
    siteController.selectedsitedropdownName = "--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    repairTypeController.text = "--Select--";
    repairType = "EXP";
    RemarksController.text = "";
    saveButton.value = RequestConstant.SUBMIT;
    // Consum_EditListApiValue.value.clear();
    consumption_controller.delete_Consum_itemlist_Table();
    consumption_controller.Consum_itemview_GetDbList.clear();
  }

  Future SaveButton_ItemlistScreen(BuildContext context, int id) async {
    int i = 0;
    await consumption_controller.getConumTablesDatas();
    getusageDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = repairConsumSaveModelToJson(RepairConsumSaveModel(
      id: id != 0 ? id : 0,
      entryDt: RepairConsumDate.text,
      repairNo: autoYearWiseNoController.text,
      projectid: projectController.selectedProjectId.value,
      siteid: siteController.selectedsiteId.value,
      supplierId: subcontractorController.selectedSupplierId.value,
      remarks: RemarksController.text,
      repairType: repairType,
      createdBy: isSubmit ? int.parse(loginController.EmpId()) : createdById.value,
      createdDt: isSubmit
          ? BaseUtitiles().convertToUtcIso(RepairConsumDate.text)
          : null,
      updatedBy: 0,
      updatedDt: isResubmit
          ? BaseUtitiles().convertToUtcIso(RepairConsumDate.text)
          : null,
      repairDetLink: getusageDetList.value.length == 0
          ? getConumDet(id)
          : getusageDetList.value,
    ));

    final list = await RepairConsumptionProvider.SaveRepairConumScreenEntryAPI(body, id, context);

    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await getRepairConsum_EntryList();
        clearDatas();
        consumption_controller.delete_Consum_itemlist_Table();
        consumption_controller.Consum_itemview_GetDbList.clear();
        BaseUtitiles.popMultiple(context, count: 3);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<RepairDetLink>? getConumDet(int? id) {
    consumption_controller.Consum_itemview_GetDbList.value.forEach((element) {
      var list = RepairDetLink(
        id: element.reqDetId,
        repairMasId: id != 0 ? id : 0,
        materialId: element.materialid,
        qty: element.Usageqty,
        rate: 0,
        remarks: "",
        scaleId: element.scaleId,
        stockQty: element.Stockqty,
      );
      getusageDetList.value.add(list);
    });
    return getusageDetList.value;
  }

  Future<bool> Repair_ConsumList_DeleteApi(int UsageId) async {
    return RepairConsumptionProvider.Repair_ConsumList_deleteAPI(UsageId);
  }

  Future RepairConsumList_EditApi(int expenseId,String MenuName, BuildContext context) async {
    await ClickUtils.run(() async {
      final value =
      await RepairConsumptionProvider.Repair_ConsumList_editAPI(expenseId);
      if (value != null) {
        if(value.success == true){
          consumption_controller.delete_Consum_itemlist_Table();
          saveButton.value = RequestConstant.RESUBMIT;
          RepairConsum_EditListApiValue.value = [value.result!];
          consumption_controller.Consum_entrylist_editSaveDetTable(list: RepairConsum_EditListApiValue.value,type: "Repair Consumption");
          consumption_controller.getConumTablesDatas();
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RepairConsumptionEntryScreen(heading: MenuName,)),
          );
        }else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      }
      else {
        BaseUtitiles.showToast("Something Went Wrong...");
      }
    });
  }

}