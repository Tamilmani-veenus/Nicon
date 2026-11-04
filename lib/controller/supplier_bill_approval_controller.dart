import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nicon/controller/pendinglistcontroller.dart';
import 'package:nicon/controller/punch_in_controller.dart';
import '../db_model/supp_bill_app_model.dart';
import '../db_services/supplier_bill_app_service.dart';
import '../home/menu/materials/supplier_bill_approval/supplier_bill_entry.dart';
import '../models/supplier_bill_approve_model.dart';
import '../provider/supplier_bill_approval_provider.dart';
import '../utilities/baseutitiles.dart';
import 'logincontroller.dart';

class SupplierBillApprovalController extends GetxController {
  RxList suppBillAppEditListValue = [].obs;
  RxList getSupplierBillItemViewDbList = [].obs;
  final RxList<String> supplierBillImageList = <String>[].obs;
  late List<SupplierBillAppDet> materialTableList = <SupplierBillAppDet>[];
  late List<SupplierBillAppDet> updateListData = <SupplierBillAppDet>[];
  late List<SupplierBillAppDet> deleteModelList = <SupplierBillAppDet>[];
  RxList<MaterialPurOrdBilldetLink> getRequestDetList = <MaterialPurOrdBilldetLink>[].obs;

  var supplierBillAppDetModel = SupplierBillAppDet();
  List<TextEditingController> itemlist_qtyControllers = [];
  List<TextEditingController> itemlist_descControllers = [];
  List<TextEditingController> itemlist_rateControllers = [];
  List<TextEditingController> itemlist_discPerControllers = [];
  List<TextEditingController> itemlist_sgstPerControllers = [];
  List<TextEditingController> itemlist_cgstPerControllers = [];
  List<TextEditingController> itemlist_igstPerControllers = [];
  int reqId = 0;
  RxInt selectedSupplierId = 0.obs;
  var suppBillAppService = SuppBillAppService();
  RxBool isGstInclusive = false.obs;
  double supplierBillItemGrossTotal = 0.0;
  double supplierBillItemNetTotal = 0.0;
  LoginController loginController = Get.put(LoginController());
  PunchInController punchInController = Get.put(PunchInController());
  PendingListController pendingListController = Get.put(PendingListController());


  @override
  void onClose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  final Map<String, TextEditingController> controllers = {
    'Freight Charges': TextEditingController(),
    'Labour Charges': TextEditingController(),
    'Other Charges': TextEditingController(),
    'Round Off': TextEditingController(),

    'S-GST %': TextEditingController(),
    'S-GST Amt': TextEditingController(),
    'Net S-GST': TextEditingController(),

    'C-GST %': TextEditingController(),
    'C-GST Amt': TextEditingController(),
    'Net C-GST': TextEditingController(),

    'I-GST %': TextEditingController(),
    'I-GST Amt': TextEditingController(),
    'Net I-GST': TextEditingController(),

    'TDS %': TextEditingController(),
    'TDS Amt': TextEditingController(),
    'TCS %': TextEditingController(),
    'TCS Amt': TextEditingController(),

    'Discount %': TextEditingController(),
    'Disc Amt': TextEditingController(),

    'Net Amount': TextEditingController(),
    'Advance Amount': TextEditingController(),
    'Deduction Amount': TextEditingController(),
    'Net Pay Amount': TextEditingController(),
    'Remarks': TextEditingController(),
  };

  Future suppBillApprovalEditApi(int reqId, type, context,MenuName) async {
    await ClickUtils.run(() async {
      final value = await SupplierBillAppProvider.SupplierBillGetByIdAPI(reqId,type);

      if (value != null) {
        if (value.success == true) {
          await delete_SuppBill_itemlist_Table();

          suppBillAppEditListValue.value = [value];

          await supplierBillSaveDetTable();
          await getSupplierBillSaveDetData();

          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SupplierBillEntry(heading: MenuName),
            ),
          );
        } else {
          BaseUtitiles.showToast(
              value.message ?? 'Something went wrong..');
        }
      } else {
        BaseUtitiles.showToast('Something went wrong..');
      }
    });
  }

  Future<void> suppBillApprovalImageApi(int reqId, dynamic type) async {
    await ClickUtils.run(() async {
      final value =
      await SupplierBillAppProvider.SupplierBillImgListAPI(reqId, type);

      if (value != null) {
        supplierBillImageList.value = List<String>.from(
          (value as List).map((e) => e['url'].toString()),
        );
      } else {
        BaseUtitiles.showToast('Something went wrong..');
      }
    });
  }

  Future approveSuppBillApi( context, value) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = approveSuppBillApiModelToJson(ApproveSuppBillApiModel(
      id: value.id,
      billNo: value.billNo,
      entrydate: value.entrydate,
      billType: value.billType,
      poBillType: value.poBillType,
      projectId: value.projectId,
      siteId: value.siteId,
      supplierId: value.supplierId,
      dcNo: value.dcNo,
      dcDate: value.dcDate,
      invoiceNo: value.invoiceNo,
      billDate: value.billDate,
      purOrdMasId: value.purOrdMasId,
      workOrdMasId: value.workOrdMasId,
      reqOrdMasId: value.reqOrdMasId,
      frieghtCharges: double.tryParse(controllers['Freight Charges']!.text) ?? 0.0,
      labourCharges: double.tryParse(controllers['Labour Charges']!.text) ?? 0.0,
      otherCharges: double.tryParse(controllers['Other Charges']!.text) ?? 0.0,
      roundOff: double.tryParse(controllers['Round Off']!.text) ?? 0.0,
      sgstPercentage: double.tryParse(controllers['S-GST %']!.text) ?? 0.0,
      sgstAmount: double.tryParse(controllers['S-GST Amt']!.text) ?? 0.0,
      netSgstAmount: double.tryParse(controllers['Net S-GST']!.text) ?? 0.0,
      cgstPercentage: double.tryParse(controllers['C-GST %']!.text) ?? 0.0,
      cgstAmount: double.tryParse(controllers['C-GST Amt']!.text) ?? 0.0,
      netCgstAmount: double.tryParse(controllers['Net C-GST']!.text) ?? 0.0,
      igstPercentage: double.tryParse(controllers['I-GST %']!.text) ?? 0.0,
      igstAmount: double.tryParse(controllers['I-GST Amt']!.text) ?? 0.0,
      netIgstAmount: double.tryParse(controllers['Net I-GST']!.text) ?? 0.0,
      tdsPercentage: double.tryParse(controllers['TDS %']!.text) ?? 0.0,
      tdsAmount: double.tryParse(controllers['TDS Amt']!.text) ?? 0.0,
      tcsPercentage: double.tryParse(controllers['TCS %']!.text) ?? 0.0,
      tcsAmount: double.tryParse(controllers['TCS Amt']!.text) ?? 0.0,
      discntPercentage: double.tryParse(controllers['Discount %']!.text) ?? 0.0,
      discntAmount: double.tryParse(controllers['Disc Amt']!.text) ?? 0.0,
      netAmount: double.tryParse(controllers['Net Amount']!.text) ?? 0.0,
      netPayAmount: double.tryParse(controllers['Net Pay Amount']!.text) ?? 0.0,
      advanceAmount: double.tryParse(controllers['Deduction Amount']!.text) ?? 0.0,
      remarks: controllers['Remarks']!.text,
      createdBy: value.createdBy,
      createdDt: value.createdDt,
      verifyBy: value.verifyBy,
      verifyStatus: value.verifyStatus,
      verifydate: value.verifydate,
      approveStatus: "Y",
      approveBy: int.tryParse(loginController.EmpId()),
      approveDate: BaseUtitiles().convertToUtcIso(punchInController.currentDate!),
      debitNoteAmt: value.debitNoteAmt,
      debitNoteRemarks: value.debitNoteRemarks ?? "-",
      debitNoteType: value.debitNoteType,
      eWayBill: value.eWayBill,
      eWayBillNo: value.eWayBillNo ?? 0,
      subContractorId: value.subContractorId,
      eWayBillImage: value.eWayBillImage,
      eWayBillDate: value.eWayBillDate,
      tallyType: value.tallyType,
      materialInwMasId: value.materialInwMasId ?? "0",
      companyId: value.companyId,
      workOrderId: value.workOrderId,
      fromDate: value.fromDate,
      toDate: value.toDate,
      gstApply: isGstInclusive.value,
      totalAmount: 0,
      materialPurOrdBilldetLink: getPurOrdBillDet(value.id)
    ));

    final list = await SupplierBillAppProvider.approveSuppBillApproveAPI(body, value.id);
    final decodedJson = jsonDecode(body);
    //
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);

    if (list != null) {
      if (list["success"] == true) {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 4);
      } else {
        BaseUtitiles.showToast(list?["message"] ?? "Something went wrong..");
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<MaterialPurOrdBilldetLink>? getPurOrdBillDet(int materialReqOrdMasId) {
    getRequestDetList.clear();

    for (var element in getSupplierBillItemViewDbList) {
      if ((element.billQty ?? 0) > 0) {
        final list = MaterialPurOrdBilldetLink(
          id: element.detId,
          materialPurOrdBillMasId: materialReqOrdMasId,
          purOrdDetId: element.purOrdDetId,
          workOrdDetId: element.workOrdDetId,
          reqOrdDetId: element.reqOrdDetId,
          materialId: element.materialId,
          scaleId: element.scaleID,
          qty: element.billQty ?? 0.0,
          rate: element.rate ?? 0.0,
          amount: element.amount ?? 0.0,
          sgstPercentage: element.sgstPer ?? 0.0,
          sgstAmount: element.sgstAmt ?? 0.0,
          cgstPercentage: element.cgstPer ?? 0.0,
          cgstAmount: element.cgstAmt ?? 0.0,
          igstPercentage: element.igstPer ?? 0.0,
          igstAmount: element.igstAmt ?? 0.0,
          discntPercentage: element.disc_Per ?? 0.0,
          discntAmount: element.disc_Amt ?? 0.0,
          netAmount: element.netAmount ?? 0.0,
          inwQty: element.inwardQty ?? 0.0,
          poRate: element.poRate ?? 0.0,
          remarks: element.remarks ?? "-",
          approxDays: element.approxDays ?? 0,
          poBillDescription: element.description
        );

        getRequestDetList.add(list);
      }
    }

    return getRequestDetList;
  }

  Future supplierBillSaveDetTable() async {
    materialTableList.clear();
    debugPrint("API List Length: ${suppBillAppEditListValue.length}");

    for (var element in suppBillAppEditListValue) {
      for (var val in element.materialPurOrdBilldetLink ?? []) {
        supplierBillAppDetModel = SupplierBillAppDet();

        supplierBillAppDetModel.detId = val.detId;
        supplierBillAppDetModel.materialInwarddetid = val.materialInwarddetid;
        supplierBillAppDetModel.purOrdMasId = val.purOrdMasId;
        supplierBillAppDetModel.purOrdDetId = val.purOrdDetId;
        supplierBillAppDetModel.workOrdDetId = val.workOrdDetId;
        supplierBillAppDetModel.reqOrdDetId = val.reqOrdDetId;
        supplierBillAppDetModel.materialId = val.materialId;
        supplierBillAppDetModel.materialName = val.materialName;
        supplierBillAppDetModel.scaleID = val.scaleId;
        supplierBillAppDetModel.scaleName = val.scaleName;
        supplierBillAppDetModel.inwardQty = val.inwardQty;
        supplierBillAppDetModel.billQty = val.billQty;
        supplierBillAppDetModel.balInwQty = val.balInwQty;
        supplierBillAppDetModel.balQty = val.balQty;
        supplierBillAppDetModel.description = val.description;
        supplierBillAppDetModel.rate = val.rate;
        supplierBillAppDetModel.poRate = val.poRate;
        supplierBillAppDetModel.disc_Per = val.discPer;
        supplierBillAppDetModel.disc_Amt = val.discAmt;
        supplierBillAppDetModel.remarks = val.remarks;
        supplierBillAppDetModel.sgstPer = val.sgstPer;
        supplierBillAppDetModel.sgstAmt = val.sgstAmt;
        supplierBillAppDetModel.cgstPer = val.cgstPer;
        supplierBillAppDetModel.cgstAmt = val.cgstAmt;
        supplierBillAppDetModel.igstPer = val.igstPer;
        supplierBillAppDetModel.igstAmt = val.igstAmt;
        supplierBillAppDetModel.vat_Type = val.vatType;
        supplierBillAppDetModel.amount = val.amount;
        supplierBillAppDetModel.netAmount = val.netAmount;
        supplierBillAppDetModel.status = val.status;
        supplierBillAppDetModel.approxDays = val.approxDays;
        supplierBillAppDetModel.expiryDate = val.expiryDate;

        materialTableList.add(supplierBillAppDetModel);
      }
    }

    return await suppBillAppService.suppBillAppList_table_Save(
      materialTableList,
    );
  }

  Future getSupplierBillSaveDetData() async {
    getSupplierBillItemViewDbList.value = [];

    var Matlist = await suppBillAppService.suppBillApplist_table_readAll();

    Matlist.forEach((user) {
      supplierBillAppDetModel = SupplierBillAppDet();

      supplierBillAppDetModel.id = user['id'];
      supplierBillAppDetModel.detId = user['detId'];
      supplierBillAppDetModel.materialInwarddetid = user['materialInwarddetid'];
      supplierBillAppDetModel.purOrdMasId = user['purOrdMasId'];
      supplierBillAppDetModel.purOrdDetId = user['purOrdDetId'];
      supplierBillAppDetModel.workOrdDetId = user['workOrdDetId'];
      supplierBillAppDetModel.reqOrdDetId = user['reqOrdDetId'];
      supplierBillAppDetModel.materialId = user['materialId'];
      supplierBillAppDetModel.materialName = user['materialName'];
      supplierBillAppDetModel.scaleID = user['scaleID'];
      supplierBillAppDetModel.scaleName = user['scaleName'];
      supplierBillAppDetModel.inwardQty = toDoubleValue(user['inwardQty']);
      supplierBillAppDetModel.billQty = toDoubleValue(user['billQty']);
      supplierBillAppDetModel.balInwQty = toDoubleValue(user['balInwQty']);
      supplierBillAppDetModel.balQty = toDoubleValue(user['balQty']);
      supplierBillAppDetModel.rate = toDoubleValue(user['rate']);
      supplierBillAppDetModel.poRate = toDoubleValue(user['poRate']);
      supplierBillAppDetModel.disc_Per = toDoubleValue(user['disc_Per']);
      supplierBillAppDetModel.disc_Amt = toDoubleValue(user['disc_Amt']);
      supplierBillAppDetModel.sgstPer = toDoubleValue(user['sgstPer']);
      supplierBillAppDetModel.sgstAmt = toDoubleValue(user['sgstAmt']);
      supplierBillAppDetModel.cgstPer = toDoubleValue(user['cgstPer']);
      supplierBillAppDetModel.cgstAmt = toDoubleValue(user['cgstAmt']);
      supplierBillAppDetModel.igstPer = toDoubleValue(user['igstPer']);
      supplierBillAppDetModel.igstAmt = toDoubleValue(user['igstAmt']);
      supplierBillAppDetModel.amount = toDoubleValue(user['amount']);
      supplierBillAppDetModel.netAmount = toDoubleValue(user['netAmount']);
      supplierBillAppDetModel.description = user['description'];
      supplierBillAppDetModel.status = user['status'];
      supplierBillAppDetModel.remarks = user['remarks'];
      supplierBillAppDetModel.approxDays = user['approxDays'];
      supplierBillAppDetModel.vat_Type = user['vat_Type'];
      supplierBillAppDetModel.expiryDate = user['expiryDate'];

      getSupplierBillItemViewDbList.add(supplierBillAppDetModel);
    });

    setTextControllersValue();
  }

  void syncSupplierBillItemTotals() {
    double totalNet = 0.0;
    double totalSgst = 0.0;
    double totalCgst = 0.0;
    double totalIgst = 0.0;

    double toTwoDecimal(double value) =>
        double.parse(value.toStringAsFixed(2));

    for (final item in getSupplierBillItemViewDbList) {
      totalNet += _toDouble(item.netAmount);
      totalSgst += _toDouble(item.sgstAmt);
      totalCgst += _toDouble(item.cgstAmt);
      totalIgst += _toDouble(item.igstAmt);
    }

    totalNet = toTwoDecimal(totalNet);
    totalSgst = toTwoDecimal(totalSgst);
    totalCgst = toTwoDecimal(totalCgst);
    totalIgst = toTwoDecimal(totalIgst);

    // Update total fields
    controllers['Net Amount']!.text =
        totalNet.toStringAsFixed(2);

    controllers['Net S-GST']!.text =
        totalSgst.toStringAsFixed(2);

    controllers['Net C-GST']!.text =
        totalCgst.toStringAsFixed(2);

    controllers['Net I-GST']!.text =
        totalIgst.toStringAsFixed(2);

    // Get Deduction Amount
    final deductionAmount =
    _toDouble(controllers['Deduction Amount']!.text);

    // Net Pay Amount = Net Amount - Deduction Amount
    final netPayAmount = toTwoDecimal(
      totalNet - deductionAmount,
    );

    controllers['Net Pay Amount']!.text =
        netPayAmount.toStringAsFixed(2);
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }

  Future<void> updateBillQty(int index, String value, type) async {
    if (index < 0 || index >= getSupplierBillItemViewDbList.length) {
      return;
    }

    // Get current item
    final item = getSupplierBillItemViewDbList[index];

    // Convert dynamic values to double
    double toDouble(dynamic value) =>
        double.tryParse(value?.toString() ?? '') ?? 0.0;

    // Round to 2 decimal places
    double roundToTwo(double value) =>
        double.parse(value.toStringAsFixed(2));

    // Get PO balance quantity
    final balQty = toDouble(item.balQty);

    // Get entered Bill Qty
    final qtyText = value.trim();
    final qty = qtyText.isEmpty ? 0.0 : double.tryParse(qtyText);

    if (qty == null) return;

    // Validate Bill Qty
    if(type=="P") {
      if (qty < 0 || qty > balQty) {
        BaseUtitiles.showToast(
          'Bill Qty should not exceed PO Bal Qty',
        );

        itemlist_qtyControllers[index].text = "0.0";

        // Reset local item calculations
        item.billQty = 0.0;
        item.amount = 0.0;
        item.disc_Amt = 0.0;
        item.sgstAmt = 0.0;
        item.cgstAmt = 0.0;
        item.igstAmt = 0.0;
        item.netAmount = 0.0;

        // Update matching API item
        final apiItems =
            suppBillAppEditListValue[0].materialPurOrdBilldetLink;

        final apiIndex = apiItems.indexWhere(
              (e) => e.detId == item.detId,
        );

        if (apiIndex != -1) {
          final apiItem = apiItems[apiIndex];

          apiItem.billQty = 0.0;
          apiItem.amount = 0.0;
          apiItem.discAmt = 0.0;
          apiItem.sgstAmt = 0.0;
          apiItem.cgstAmt = 0.0;
          apiItem.igstAmt = 0.0;
          apiItem.netAmount = 0.0;
        }

        getSupplierBillItemViewDbList.refresh();
        suppBillAppEditListValue.refresh();

        // Save zero values to database
        await suppBillAppService.updateBillItemCalculation(
          item.detId,
          {
            'billQty': 0.0,
            'amount': 0.0,
            'disc_Amt': 0.0,
            'sgstAmt': 0.0,
            'cgstAmt': 0.0,
            'igstAmt': 0.0,
            'netAmount': 0.0,
          },
        );

        syncSupplierBillItemTotals();
        return;
      }
    }

    // Calculate Amount
    final rate = toDouble(item.rate);
    final amount = roundToTwo(qty * rate);

    // Calculate Discount
    final discountPercentage = toDouble(item.disc_Per);

    final discountAmount = roundToTwo(
      amount * discountPercentage / 100,
    );

    // Calculate Taxable Amount
    final taxableAmount = roundToTwo(
      amount - discountAmount,
    );

    // Calculate SGST
    final sgstAmount = roundToTwo(
      taxableAmount * toDouble(item.sgstPer) / 100,
    );

    // Calculate CGST
    final cgstAmount = roundToTwo(
      taxableAmount * toDouble(item.cgstPer) / 100,
    );

    // Calculate IGST
    final igstAmount = roundToTwo(
      taxableAmount * toDouble(item.igstPer) / 100,
    );

    // Calculate Net Amount
    final netAmount = roundToTwo(
      taxableAmount +
          sgstAmount +
          cgstAmount +
          igstAmount,
    );

    // Update local item
    item.billQty = qty;
    item.amount = amount;
    item.disc_Amt = discountAmount;
    item.sgstAmt = sgstAmount;
    item.cgstAmt = cgstAmount;
    item.igstAmt = igstAmount;
    item.netAmount = netAmount;

    // Update matching API item
    final apiItems =
        suppBillAppEditListValue[0].materialPurOrdBilldetLink;

    final apiIndex = apiItems.indexWhere(
          (e) => e.detId == item.detId,
    );

    if (apiIndex != -1) {
      final apiItem = apiItems[apiIndex];

      apiItem.billQty = qty;
      apiItem.amount = amount;
      apiItem.discAmt = discountAmount;
      apiItem.sgstAmt = sgstAmount;
      apiItem.cgstAmt = cgstAmount;
      apiItem.igstAmt = igstAmount;
      apiItem.netAmount = netAmount;
    }

    // Refresh reactive lists
    getSupplierBillItemViewDbList.refresh();
    suppBillAppEditListValue.refresh();

    // Save database
    await suppBillAppService.updateBillItemCalculation(
      item.detId,
      {
        'billQty': qty,
        'amount': amount,
        'disc_Amt': discountAmount,
        'sgstAmt': sgstAmount,
        'cgstAmt': cgstAmount,
        'igstAmt': igstAmount,
        'netAmount': netAmount,
      },
    );

    // Update aggregate totals
    syncSupplierBillItemTotals();
  }


  Future<void> updateGeneralBillItem(
      int index,
      String field,
      String value,
      ) async {
    if (index < 0 || index >= getSupplierBillItemViewDbList.length) {
      return;
    }

    final item = getSupplierBillItemViewDbList[index];

    double toDouble(dynamic value) =>
        double.tryParse(value?.toString() ?? '') ?? 0.0;

    double roundTwo(double value) =>
        double.parse(value.toStringAsFixed(2));

    final input = toDouble(value);

    // Update editable fields
    switch (field) {
      case 'description':
        item.description = value;
        break;

      case 'rate':
        item.rate = input;
        break;

      case 'disc':
        item.disc_Per = input;
        break;

      case 'sgst':
        item.sgstPer = input;
        item.cgstPer = input;
        item.igstPer = 0.0;
        break;

      case 'igst':
        item.igstPer = input;
        item.sgstPer = 0.0;
        item.cgstPer = 0.0;
        break;
    }

    // Calculate amount
    final qty = toDouble(item.billQty);
    final rate = toDouble(item.rate);

    final amount = roundTwo(qty * rate);

    // Discount
    final discount = roundTwo(
      amount * toDouble(item.disc_Per) / 100,
    );

    final taxable = roundTwo(amount - discount);

    // GST
    final sgst = roundTwo(
      taxable * toDouble(item.sgstPer) / 100,
    );

    final cgst = roundTwo(
      taxable * toDouble(item.cgstPer) / 100,
    );

    final igst = toDouble(item.igstPer) == 0
        ? 0.0
        : roundTwo(
      taxable * toDouble(item.igstPer) / 100,
    );

    // Net amount
    final net = roundTwo(
      taxable + sgst + cgst + igst,
    );

    // Update local item
    item.amount = amount;
    item.disc_Amt = discount;
    item.sgstAmt = sgst;
    item.cgstAmt = cgst;
    item.igstAmt = igst;
    item.netAmount = net;

    // Update API model
    final apiItems =
        suppBillAppEditListValue[0].materialPurOrdBilldetLink;

    final apiIndex = apiItems.indexWhere(
          (e) => e.detId == item.detId,
    );

    if (apiIndex != -1) {
      final apiItem = apiItems[apiIndex];

      apiItem.description = item.description;
      apiItem.rate = item.rate;
      apiItem.discPer = item.disc_Per;
      apiItem.sgstPer = item.sgstPer;
      apiItem.cgstPer = item.cgstPer;
      apiItem.igstPer = item.igstPer;

      apiItem.amount = amount;
      apiItem.discAmt = discount;
      apiItem.sgstAmt = sgst;
      apiItem.cgstAmt = cgst;
      apiItem.igstAmt = igst;
      apiItem.netAmount = net;
    }

    getSupplierBillItemViewDbList.refresh();
    suppBillAppEditListValue.refresh();

    // Save to local database
    await suppBillAppService.updateBillItemCalculation(
      item.detId,
      {
        'description': item.description,
        'rate': item.rate,
        'disc_Per': item.disc_Per,
        'disc_Amt': discount,
        'sgstPer': item.sgstPer,
        'cgstPer': item.cgstPer,
        'igstPer': item.igstPer,
        'amount': amount,
        'sgstAmt': sgst,
        'cgstAmt': cgst,
        'igstAmt': igst,
        'netAmount': net,
      },
    );

    syncSupplierBillItemTotals();
  }


  textControllersInitiate() {
    itemlist_qtyControllers.add(TextEditingController());
  }

  setTextControllersValue() async {
    itemlist_qtyControllers.clear();
    for (var index = 0; index < getSupplierBillItemViewDbList.length; index++) {
      textControllersInitiate();
      itemlist_qtyControllers[index].text = getSupplierBillItemViewDbList[index].billQty.toString();
    }
  }

  delete_SuppBill_itemlist_Table() async {
    await suppBillAppService.suppBillAppList_table_delete();
  }
  double? toDoubleValue(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

}