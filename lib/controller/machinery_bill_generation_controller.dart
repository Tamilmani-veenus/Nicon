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
import '../models/machinery_bill_save_model.dart';
import '../provider/common_provider.dart';
import '../provider/directbill_generat_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/common_date_fields.dart';
import '../utilities/requestconstant.dart';
import 'auto_yrwise_no_controller.dart';
import 'billgeneration_boq_controller.dart';
import 'bottomsheet_Controllers.dart';
import 'dailywrk_done_dpr_controller.dart';
import 'logincontroller.dart';

class MachineryBillGenController extends GetxController {
  final autoYearWiseNoController = TextEditingController();
  final requestDateController = TextEditingController();
  final paymentWKDateController = TextEditingController();
  final remarksController = TextEditingController();
  final preparedByController = TextEditingController();
  final wrkOrderNoController = TextEditingController();

  final billAmount      = TextEditingController(text: "0.00");
  final totalAddLess    = TextEditingController(text: "0.00"); // added
  final creditAmount    = TextEditingController(text: "0.00");
  final debitAmount     = TextEditingController(text: "0.00");
  final creditRemarks   = TextEditingController();
  final debitRemarks    = TextEditingController();
  final netBillAmount   = TextEditingController(text: "0.00");
  final roundOff        = TextEditingController(text: "0.00");
  final finalBillAmount = TextEditingController(text: "0.00");
  final netPayAmount    = TextEditingController(text: "0.00");

  late ProjectController projectController;
  late SiteController siteController;
  late SubcontractorController subcontractorController;
  late BillGenerationBoqController billGenerationBoqController;
  late DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller;
  late BottomsheetControllers bottomsheetControllers;
  late LoginController loginController;
  late AutoYearWiseNoController autoYearWiseController;

  RxString saveButton = RequestConstant.SUBMIT.obs;
  var machineryBillDetLocalService = MachineryBillDetLocalService();
  var machineryBillDetLocalModel = MachineryBillDetLocal();

  RxList getdpDnWrkOrderValue = [].obs;
  RxList<MachineryBillDetLocal> getMacBillDetValue = <MachineryBillDetLocal>[].obs;
  RxList<SubContractorMachineryBillAddLessSetupLink> getDetAddLessList = <SubContractorMachineryBillAddLessSetupLink>[].obs;
  RxList<SubContractorMachineryWorkQtydetLink> getRequestDetList = <SubContractorMachineryWorkQtydetLink>[].obs;
  RxList<SubContractorMachineryWorkBillDetailslink> getWorkBillDetailsList = <SubContractorMachineryWorkBillDetailslink>[].obs;

  RxInt workOrderId = 0.obs;

  @override
  void onInit() {
    super.onInit();

    putController(() => ProjectController());
    putController(() => SiteController());
    putController(() => SubcontractorController());
    putController(() => BillGenerationBoqController());
    putController(() => DailyWrkDone_DPR_Controller());
    putController(() => BottomsheetControllers());
    putController(() => LoginController());
    putController(() => AutoYearWiseNoController());

    projectController = Get.find();
    siteController = Get.find();
    subcontractorController = Get.find();
    billGenerationBoqController = Get.find();
    dailyWrkDone_DPR_Controller = Get.find();
    bottomsheetControllers = Get.find();
    loginController = Get.find();
    autoYearWiseController = Get.find();
  }

  double _val(TextEditingController c) {
    final t = c.text.trim();
    return (t.isEmpty || t == "-" || t == ".") ? 0 : double.tryParse(t) ?? 0;
  }

  /// Bill Amt = total of the detail rows
  void setBillFromDetails(List<double> detailAmounts) {
    final total = detailAmounts.fold<double>(0, (sum, a) => sum + a);
    billAmount.text = total.toStringAsFixed(2);
    calculate();
  }

  /// Call after Bill Amt is set, and from onChanged of credit / debit / round off
  bool calculate({bool showToast = true}) {
    final bill   = _val(billAmount);
    final credit = _val(creditAmount);
    final debit  = _val(debitAmount);
    final round  = _val(roundOff);

    final rows = billGenerationBoqController.directBillGen_ItemReadList;

    // Base for every Add/Less row = Bill + Credit - Debit
    final base = bill + credit - debit;

    double plusTotal = 0;    // sum of "+" rows
    double minusTotal = 0;   // sum of "-" rows (negative)

    for (final item in rows) {
      final amt = base * (item.percentValue ?? 0) / 100;

      if (item.addLessType == "-") {
        item.amount = -amt;
        minusTotal += -amt;
      } else {
        item.amount = amt;
        plusTotal += amt;
      }
    }
    rows.refresh();   // table rebuilds

    // Net Bill = Base + "+" rows
    final net = base + plusTotal;

    // Final Bill = Net Bill + Round Off
    final fin = net + round;

    // Net Pay = Final Bill + "-" rows (already negative)
    final netPay = fin + minusTotal;

    totalAddLess.text    = (plusTotal + minusTotal).toStringAsFixed(2);
    netBillAmount.text   = net.toStringAsFixed(2);
    finalBillAmount.text = fin.toStringAsFixed(2);
    netPayAmount.text    = netPay.toStringAsFixed(2);

    if (netPay < 0) {
      if (showToast) BaseUtitiles.showToast("Net Pay Amount cannot be negative.");
      return false;
    }
    return true;
  }

  bool updatePercent(int addLessId, double percent) {
    final rows = billGenerationBoqController.directBillGen_ItemReadList;
    final item = rows.firstWhereOrNull((e) => e.addLessId == addLessId);
    if (item == null) return false;

    final oldPercent = item.percentValue ?? 0.0;
    item.percentValue = percent;

    if (!calculate(showToast: false)) {
      item.percentValue = oldPercent;      // restore
      calculate(showToast: false);
      BaseUtitiles.showToast("Net Pay Amount cannot be negative.");
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    for (final c in [
      billAmount, totalAddLess, creditAmount, debitAmount, creditRemarks,
      debitRemarks, netBillAmount, roundOff, finalBillAmount, netPayAmount,
    ]) {
      c.dispose();
    }
    super.onClose();
  }

  void refreshBill() {
    setBillFromDetails(
      getMacBillDetValue.map((e) => (e.amt ?? 0).toDouble()).toList(),
    );
  }

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
    refreshBill();

    var response = await CommonProvider.getMachineryBillDetList(id);

    if (response != null) {
      if (response.success == true) {
        if (response.data!.isNotEmpty) {

          await MachineryBillDetLocal_editSaveDetTable(
            list: response.data!,
          );

          await getMachineryBillDetLocalDatas();
          refreshBill();

        } else {
          BaseUtitiles.showToast("No work items found for the selected work order.");
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
    final value = await DirectBillGenerateProvider.getBillDirectCalculation_List(
      pId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subId: dailyWrkDone_DPR_Controller.TypeSubcontId.value,
      wrkOrdId: workOrderId.value,
      type: "MachineryBill"
    );
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          billGenerationBoqController.billDet_Calculation.value = value.result!;
          await billGenerationBoqController.DirectBillCal_itemlistTable_Delete();
          await billGenerationBoqController.directBillCalculationSave();
          await billGenerationBoqController.getDirectBillCalDatas();
          calculate();
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
      machineryBillDetLocalModel.unitId = element.unitId;
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
      machineryBillDetLocal.unitId = user['unitId'];
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

  Future<void> resetForm() async {
    // detail rows
    await deleteDetTableDatas();
    getMacBillDetValue.value = [];
    refreshBill();                       // Bill Amt back to 0.00 and rows recalculated

    // auto number and dates
    await autoYearWiseController.AutoYearWiseNo("MACHINERY BILL");
    autoYearWiseNoController.text = autoYearWiseController.MachineryBill_autoYrWise.value;

    final today = CommonDateUtils.formatApiDate(DateTime.now());
    requestDateController.text   = today;
    paymentWKDateController.text = today;

    // text fields
    remarksController.text    = "";
    preparedByController.text = loginController.EmpName();

    // dropdowns
    projectController.projectname.text = "--SELECT--";
    projectController.selectedProjectId.value = 0;

    siteController.Sitename.text = "--SELECT--";
    siteController.selectedsiteId.value = 0;

    dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
    dailyWrkDone_DPR_Controller.TypeSubcontId.value = 0;

    wrkOrderNoController.text = "--SELECT--";
    workOrderId.value = 0;

    bottomsheetControllers.searchcontroller.text = "";
  }

  Future SaveMachineryBillScreen(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = machineryBillSaveToJson(MachineryBillSave(
        id: id,
        workNo: autoYearWiseNoController.text,
        workDate: requestDateController.text,
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        subContractorId: dailyWrkDone_DPR_Controller.TypeSubcontId.value,
        workOrderId: workOrderId.value,
        netBillAmount: double.tryParse(netBillAmount.text),
        finalBillAmount: double.tryParse(finalBillAmount.text),
        netPayAmount: double.tryParse(netPayAmount.text),
        roundOff: double.tryParse(roundOff.text),
        billAmount: double.tryParse(billAmount.text),
        creditAmount: double.tryParse(creditAmount.text),
        creditRemarks: creditRemarks.text,
        debitAmount: double.tryParse(debitAmount.text),
        debitRemarks: debitRemarks.text,
        paymentDate: paymentWKDateController.text,
        remarks: remarksController.text,
        createdBy: saveButton.value == RequestConstant.SUBMIT ? int.parse(loginController.EmpId()) : 0,
        verifyBy: saveButton.value == RequestConstant.SUBMIT ? int.parse(loginController.EmpId()) : 0,
        verifyStatus: saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL ? "Y":"N",
        approvedBy: saveButton.value == RequestConstant.SUBMIT ? int.parse(loginController.EmpId()) : 0,
        approveStatus: saveButton.value == RequestConstant.APPROVAL ? "Y":"N",
        workOrderNo: wrkOrderNoController.text,
        subContractorMachineryWorkQtydetLink:  getRequestDet(id),
        subContractorMachineryBillAddLessSetupLink: getDetAddLess(id, autoYearWiseNoController.text),
        subContractorMachineryWorkBillDetailslink: getBillDetails(id)
    ));

    // final list = await MachineryIndentProvider.SaveMachineryIntentAPI(body, id, saveButton.value, context);
    // final decodedJson = jsonDecode(body);
    //
    // const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    // final prettyJson = encoder.convert(decodedJson);
    //
    // debugPrint(prettyJson, wrapWidth: 1024);
    // if (list != null) {
    //   if (list["success"] == true) {
    //     if (saveButton.value == RequestConstant.VERIFY
    //         || saveButton.value == RequestConstant.PREAPPROVAL
    //         || saveButton.value == RequestConstant.APPROVAL) {
    //       BaseUtitiles.showToast(list["message"]);
    //       await pendingListController.getPendingList();
    //       BaseUtitiles.popMultiple(context, count: 3);
    //     } else {
    //       BaseUtitiles.showToast(list["message"]);
    //       await getMacIndentEntryList();
    //       mrn_request_controller.delete_MaterialIntent_itemlist_Table();
    //       mrn_request_controller.Material_itemview_GetDbList.clear();
    //       BaseUtitiles.popMultiple(context, count: 3);
    //     }
    //   } else {
    //     BaseUtitiles.showToast(list?["message"] ?? "Something went wrong..");
    //     BaseUtitiles.popMultiple(context, count: 1);
    //   }
    // } else {
    //   BaseUtitiles.showToast("Something went wrong..");
    //   BaseUtitiles.popMultiple(context, count: 1);
    // }
  }

  List<SubContractorMachineryWorkQtydetLink>? getRequestDet(masId) {
    getRequestDetList.value=[];
    for (var element in getMacBillDetValue) {
        var list = SubContractorMachineryWorkQtydetLink(
          id: 0,
          subContractorWorkQtyMasId: masId,
          siteId: siteController.selectedsiteId.value,
          workType: "",
          dbrWorkDetId: 0,
          itemDescription: element.itemDiscription,
          unit: element.unitId,
          qty: element.qty,
          rate: element.rate,
          amount: element.amt,
          startReading: element.startReading ,
          endReading:  element.endReading,
          totalReading:  element.totalReading
        );
        getRequestDetList.add(list);
    }
    return getRequestDetList;
  }

  List<SubContractorMachineryBillAddLessSetupLink>? getDetAddLess(int id, workNo) {
    getDetAddLessList.value=[];
    for (var element in billGenerationBoqController.directBillGen_ItemReadList) {
      if (element.percentValue! > 0) {
        var list = SubContractorMachineryBillAddLessSetupLink(
          id: element.reqDetId,
          subContractorWorkQtyMasId: id,
          workNo: workNo,
          addLessId: element.addLessId,
          percentValue: element.percentValue,
          amount: element.amount,
        );
        getDetAddLessList.add(list);
      }
    }
    return getDetAddLessList;
  }

  List<SubContractorMachineryWorkBillDetailslink>? getBillDetails(masId) {
    getWorkBillDetailsList.clear();
    if (getMacBillDetValue.any(
          (element) => element.detId == null || element.detId!.isEmpty,
    )) {
      return getWorkBillDetailsList;
    }
    for (var element in getMacBillDetValue) {
      for (var detId in element.detId!) {
        getWorkBillDetailsList.add(
          SubContractorMachineryWorkBillDetailslink(
            id: 0,
            subcontractorWorkQtyMasId: masId,
            subContractDailyWorkDetId: detId,
          ),
        );
      }
    }
    return getWorkBillDetailsList;
  }

}