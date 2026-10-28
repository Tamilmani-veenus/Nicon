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
  final autoYearWiseNoController = TextEditingController();
  final RequestDateController = TextEditingController();
  final billingTypeController = TextEditingController();
  final againstTypeController = TextEditingController();
  final companyNameController = TextEditingController();
  final supplierNameController = TextEditingController();
  final orderNoController = TextEditingController();
  final dcNoController = TextEditingController();
  final invoiceNoController = TextEditingController();
  final dcDateController = TextEditingController();
  final invoiceDateController = TextEditingController();
  int reqId = 0;
  RxInt selectedSupplierId = 0.obs;
  var suppBillAppService = SuppBillAppService();

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