import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/sitecontroller.dart';
import 'package:nicon/controller/subcontcontroller.dart';
import '../db_services/materiallist_service.dart';
import '../models/machineryBill_model.dart';
import '../provider/common_provider.dart';
import '../provider/directbill_generat_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MachineryBillGenController extends GetxController {
  final autoYearWiseNoController = TextEditingController();
  final requestDateController = TextEditingController();
  final paymentWKDateController = TextEditingController();
  final remarksController = TextEditingController();
  final preparedByController = TextEditingController();
  final wrkOrderNoController = TextEditingController();
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());


  RxString saveButton = RequestConstant.SUBMIT.obs;
  var machineryBillDetLocalService = MachineryBillDetLocalService();
  var machineryBillDetLocalModel = MachineryBillDetLocal();


  RxList getdpDnWrkOrderValue = [].obs;
  RxList<MachineryBillDetLocal> getMacBillDetValue = <MachineryBillDetLocal>[].obs;
  RxList billDet_Calculation = [].obs;

  RxInt workOrderId = 0.obs;

  Future getWorkOrderNoList(int pid, int sid, int subid) async {
    getdpDnWrkOrderValue.value=[];
    final value = await CommonProvider.getWorkOrderNoList(pid, sid,subid,type: "MachineryBill");
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          getdpDnWrkOrderValue.value = value.result!;
        }
        else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future getMacBillDetList(int id) async {
    getMacBillDetValue.clear();

    var response = await CommonProvider.getMachineryBillDetList(id);

    if (response != null) {
      if (response.success == true) {
        if (response.data!.isNotEmpty) {

          await MachineryBillDetLocal_editSaveDetTable(
            list: response.data!,
          );

          await getMachineryBillDetLocalDatas();

          await getBillAddLessList();

        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(
            response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future getBillAddLessList() async {
    billDet_Calculation.value=[];
    final value = await DirectBillGenerateProvider.getBillDirectCalculation_List(
      pId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subId: subcontractorController.selectedSubcontId.value,
      wrkOrdId: workOrderId.value,
      type: "MachineryBill"
    );
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          billDet_Calculation.value = value.result!;
          // await DirectBillCal_itemlistTable_Delete();
          // await directBillCalculationSave();
          // await getDirectBillCalDatas();
          // if (saveButton.value == RequestConstant.RESUBMIT ||
          //     saveButton.value == RequestConstant.VERIFY ||
          //     saveButton.value == RequestConstant.APPROVAL) {
          //   setBaseNetPay();
          //   await preloadEditAddLessData(
          //       bill_editListApiDatas[0].subContractorBillAddLessSetupS);
          // }
        }
      }
    }
    else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future MachineryBillDetLocal_editSaveDetTable({list}) async {
    List<MachineryBillDetLocal> machineryBillDetLocalList = [];

    for (var element in list) {
      machineryBillDetLocalModel = MachineryBillDetLocal();

      machineryBillDetLocalModel.detId = element.detId ?? [];
      machineryBillDetLocalModel.itemDiscription = element.itemDiscription;
      machineryBillDetLocalModel.unit = element.unit?.trim();
      machineryBillDetLocalModel.rate = element.rate ?? 0.0;
      machineryBillDetLocalModel.qty = element.qty ?? 0.0;
      machineryBillDetLocalModel.amt = element.amt ?? 0.0;
      machineryBillDetLocalModel.startReading = element.startReading ?? 0.0;
      machineryBillDetLocalModel.endReading = element.endReading ?? 0.0;
      machineryBillDetLocalModel.totalReading = element.totalReading ?? 0.0;
      machineryBillDetLocalModel.remarks = element.remarks;

      machineryBillDetLocalList.add(machineryBillDetLocalModel);
    }

    var savedatas = await machineryBillDetLocalService
        .MachineryBillDetLocal_table_Save(machineryBillDetLocalList);

    return savedatas;
  }


  Future getMachineryBillDetLocalDatas() async {
    getMacBillDetValue.value = [];

    var Machlist = await machineryBillDetLocalService
        .MachineryBillDetLocal_table_readAll();

    Machlist.forEach((user) {
      var machineryBillDetLocal = MachineryBillDetLocal();

      machineryBillDetLocal.localId = user['localId'];
      machineryBillDetLocal.detId =
      List<int>.from(jsonDecode(user['detId'] ?? '[]'));
      machineryBillDetLocal.itemDiscription = user['itemDiscription'];
      machineryBillDetLocal.unit = user['unit'];
      machineryBillDetLocal.rate =
          double.tryParse(user['rate'].toString()) ?? 0.0;
      machineryBillDetLocal.qty =
          double.tryParse(user['qty'].toString()) ?? 0.0;
      machineryBillDetLocal.amt =
          double.tryParse(user['amt'].toString()) ?? 0.0;
      machineryBillDetLocal.startReading =
          double.tryParse(user['startReading'].toString()) ?? 0.0;
      machineryBillDetLocal.endReading =
          double.tryParse(user['endReading'].toString()) ?? 0.0;
      machineryBillDetLocal.totalReading =
          double.tryParse(user['totalReading'].toString()) ?? 0.0;
      machineryBillDetLocal.remarks = user['remarks'];

      getMacBillDetValue.add(machineryBillDetLocal);
    });

    return getMacBillDetValue;
  }

  Future saveMachineryBillItem(MachineryBillDetLocal item) async {
    await machineryBillDetLocalService
        .MachineryBillDetLocal_table_Update([item]);
  }

  deleteDetTableDatas() async {
    await machineryBillDetLocalService.MachineryBillDetLocal_table_delete();
  }

}