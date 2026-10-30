import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../db_model/supp_bill_app_model.dart';
import '../db_services/supplier_bill_app_service.dart';
import '../home/menu/materials/supplier_bill_approval/supplier_bill_entry.dart';
import '../provider/supplier_bill_approval_provider.dart';
import '../utilities/baseutitiles.dart';

class SupplierBillApprovalController extends GetxController {
  RxList suppBillAppEditListValue = [].obs;
  RxList getSupplierBillItemViewDbList = [].obs;
  final RxList<String> supplierBillImageList = <String>[].obs;
  late List<SupplierBillAppDet> materialTableList = <SupplierBillAppDet>[];
  late List<SupplierBillAppDet> updateListData = <SupplierBillAppDet>[];
  late List<SupplierBillAppDet> deleteModelList = <SupplierBillAppDet>[];
  var supplierBillAppDetModel = SupplierBillAppDet();
  List<TextEditingController> Itemlist_qtyControllers = [];
  int reqId = 0;
  RxInt selectedSupplierId = 0.obs;
  var suppBillAppService = SuppBillAppService();
  RxBool isGstInclusive = false.obs;

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

  Future suppBillApprovalEditApi(int reqId, context,MenuName) async {
    await ClickUtils.run(() async {
      final value = await SupplierBillAppProvider.SupplierBillGetByIdAPI(reqId);

      if (value != null) {
        if (value.success == true) {
          await delete_SuppBill_itemlist_Table();

          getSupplierBillItemViewDbList.clear();
          suppBillAppEditListValue.value = [value];

          if (suppBillAppEditListValue.isNotEmpty) {
            await supplierBillSaveDetTable();
            await getSupplierBillSaveDetData();
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SupplierBillEntry(heading: MenuName),
              ),
            );
          } else {
            BaseUtitiles.showToast("No Data Found");
          }
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

  Future approveSuppBillApi( context, int id) async {
    getRequestDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = materiasaveResponseToJson(MateriasaveResponse(
      //common
        id: id != 0 ? id : 0,
        reqOrdNo: autoYearWiseNoController.text.trim(),
        reqOrdDate: RequestDateController.text,
        reqdueDate: DuedateController.text,
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        reqRemarks: RemarksController.text,
        requestType: ReqType.value.toString(),
        isEdit: isResubmit ? true :  false,

        //save
        createdBy: isSubmit ? int.parse(loginController.EmpId()) : null,
        createdDt: isSubmit
            ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
            : null,

        //update
        updatedBy: isResubmit ? int.parse(loginController.EmpId()) : null,
        updatedDate: isResubmit
            ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
            : null,

        //verify
        verifyBy: isVerify ? int.parse(loginController.EmpId()) : null,
        verifyDate: isVerify
            ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
            : null,
        verifyStatus: isResubmit ?Material_EditListApiValue[0].verifyStatus:isVerify ? "Y" : "N",
        preApproveStatus: isResubmit ?Material_EditListApiValue[0].preApproveStatus:"N",
        approveStatus: isResubmit ?Material_EditListApiValue[0].approveStatus:"N",

        //det
        mMatReqMasLink:  getRequestDet(id)
    ));

    // final list = await Mrn_Req_provider.SaveMaterialScreenEntryAPI(
    //     body, id, saveButton.value, context);
    //
    // if (list != null) {
    //   if (list["success"] == true) {
    //     if (saveButton.value == RequestConstant.VERIFY) {
    //       BaseUtitiles.showToast(list["message"]);
    //       await pendingListController.getPendingList();
    //       BaseUtitiles.popMultiple(context, count: 4);
    //     } else {
    //       BaseUtitiles.showToast(list["message"]);
    //       await getMrn_Req_EntryList();
    //       delete_MaterialIntent_itemlist_Table();
    //       Material_itemview_GetDbList.clear();
    //       BaseUtitiles.popMultiple(context, count: 3);
    //     }
    //   } else {
    //     BaseUtitiles.showToast(list?["message"] ?? "Something went wrong..");
    //     BaseUtitiles.popMultiple(context, count: 2);
    //   }
    // } else {
    //   BaseUtitiles.showToast("Something went wrong..");
    //   BaseUtitiles.popMultiple(context, count: 2);
    // }
  }

  // List<MMatReqMasLink>? getRequestDet(materialReqOrdMasid) {
  //   getRequestDetList.value.clear();
  //   Material_itemview_GetDbList.value.forEach((element) {
  //     if (element.qty > 0) {
  //       var list = MMatReqMasLink(
  //           id: element.reqDetId,
  //           materialReqOrdMasid: materialReqOrdMasid != 0 ? materialReqOrdMasid : 0,
  //           materialId: element.materialid,
  //           qty: element.qty,
  //           scaleId: element.scaleId,
  //           siteId: siteController.selectedsiteId.value,
  //           reqQty: isSubmit || isResubmit ? element.qty : isVerify ? element.reqQty : element.qty,
  //           remarks: element.remarks,
  //           reqDescription: element.desc,
  //           preApproveStatus: "N",
  //           approveStatus: "N",
  //           approxDays: ReqType.value=="CP"? element.approxdays:0
  //       );
  //       getRequestDetList.value.add(list);
  //     }
  //   });
  //   return getRequestDetList.value;
  // }

  Future supplierBillSaveDetTable() async {
    materialTableList.clear();

    suppBillAppEditListValue.forEach((element) {
      element.materialPurOrdBilldetLink.forEach((val) {
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

        materialTableList.add(supplierBillAppDetModel);
      });
    });

    var savedatas =
    await suppBillAppService.suppBillAppList_table_Save(materialTableList);

    return savedatas;
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
      supplierBillAppDetModel.inwardQty = user['inwardQty']?.toDouble();
      supplierBillAppDetModel.billQty = user['billQty']?.toDouble();
      supplierBillAppDetModel.balInwQty = user['balInwQty']?.toDouble();
      supplierBillAppDetModel.balQty = user['balQty']?.toDouble();
      supplierBillAppDetModel.description = user['description'];
      supplierBillAppDetModel.rate = user['rate']?.toDouble();
      supplierBillAppDetModel.poRate = user['poRate']?.toDouble();
      supplierBillAppDetModel.disc_Per = user['disc_Per']?.toDouble();
      supplierBillAppDetModel.disc_Amt = user['disc_Amt']?.toDouble();
      supplierBillAppDetModel.remarks = user['remarks'];
      supplierBillAppDetModel.sgstPer = user['sgstPer']?.toDouble();
      supplierBillAppDetModel.sgstAmt = user['sgstAmt']?.toDouble();
      supplierBillAppDetModel.cgstPer = user['cgstPer']?.toDouble();
      supplierBillAppDetModel.cgstAmt = user['cgstAmt']?.toDouble();
      supplierBillAppDetModel.igstPer = user['igstPer']?.toDouble();
      supplierBillAppDetModel.igstAmt = user['igstAmt']?.toDouble();
      supplierBillAppDetModel.vat_Type = user['vat_Type'];
      supplierBillAppDetModel.amount = user['amount']?.toDouble();
      supplierBillAppDetModel.netAmount = user['netAmount']?.toDouble();
      supplierBillAppDetModel.status = user['status'];

      getSupplierBillItemViewDbList.add(supplierBillAppDetModel);
    });

    setTextControllersValue();
  }

  Future<void> updateBillQty(int index, String value) async {
    final qty = double.tryParse(value);

    if (qty == null) return;

    final item =
    suppBillAppEditListValue[0].materialPurOrdBilldetLink[index];

    final double balQty =
        double.tryParse(item.balQty.toString()) ?? 0.0;

    if (qty > balQty) {
      Itemlist_qtyControllers[index].text = '0.0';
      BaseUtitiles.showToast('Bill Qty should not exceed PO Bal Qty');
      return;
    }

    await suppBillAppService.updateBillQty(
      item.detId,
      qty,
    );
  }

  textControllersInitiate() {
    Itemlist_qtyControllers.add(TextEditingController());
  }

  setTextControllersValue() async {
    for (var index = 0; index < getSupplierBillItemViewDbList.length; index++) {
      textControllersInitiate();
      Itemlist_qtyControllers[index].text = getSupplierBillItemViewDbList[index].billQty.toString();
    }
  }

  delete_SuppBill_itemlist_Table() async {
    await suppBillAppService.suppBillAppList_table_delete();
  }

}