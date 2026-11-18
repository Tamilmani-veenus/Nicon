import 'package:nicon/controller/projectcontroller.dart';
import 'package:nicon/controller/reports_controller.dart';
import 'package:nicon/controller/sitecontroller.dart';
import 'package:nicon/controller/suppliercontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/grnMaterial_Table_model.dart';
import '../db_services/material_return_service.dart';
import '../home/menu/materials/material_return/materialreturn_entryscreen.dart';
import '../models/grnmaterialsave_model.dart';
import '../provider/materialReturn_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class MaterialReturn_Controller extends GetxController {

  // ==========================================================
  // SERVICES / MODELS
  // ==========================================================

  var grnMaterialTable = grnMaterial_Table();
  var materialReturn_Service = MaterialReturn_Service();

  // ==========================================================
  // TEXT CONTROLLERS
  // ==========================================================

  // New list screen
  final MatReturnlistFrDate = TextEditingController();
  final MatReturnlistToDate = TextEditingController();

  // Entry screen
  final autoYearWiseNoController = TextEditingController();
  final MatRetEntryDate = TextEditingController();
  final MatRetEntry_preparedbyController = TextEditingController();
  final MatRetEntry_RemarksController = TextEditingController();
  final GRN_StockInNo_Controller = TextEditingController();

  // ==========================================================
  // OTHER CONTROLLERS
  // ==========================================================

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  LoginController loginController = Get.put(LoginController());
  ReportsController reportsController = Get.put(ReportsController());

  // ==========================================================
  // OBSERVABLES
  // ==========================================================

  RxString returnId = "0".obs;
  RxString selectedGRN_Id = "0".obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;   // was in both
  RxBool isFromEdit = false.obs;

  RxList MatReturnList = [].obs;                      // new list
  RxList mainEtyList = [].obs;                        // was in both
  RxList MatReturn_itemview_GetDbList = [].obs;
  RxList Stock_List = [].obs;
  RxList getGRN_List = [].obs;
  RxList getGRN_MaterialList = [].obs;
  RxList GRNmainlist = [].obs;
  RxList Consum_EditListApiValue = [].obs;
  RxList searchCatNameList = [].obs;
  RxList<ReturnDet> getReturnDetList = <ReturnDet>[].obs;
  RxList grnMaterialReadList = [].obs;
  RxList grnMaterial_EditApiList = [].obs;

  List<TextEditingController> ReturnQtyController = [];
  List<TextEditingController> RemarksController = [];
  List<bool> isChecked = [];

  late List<grnMaterial_Table> grnMaterialTableModelList = <grnMaterial_Table>[];
  late List<grnMaterial_Table> grnMat_UpdateModelListReadList = <grnMaterial_Table>[];

  Future getMaterialReturn_List() async {
    mainEtyList.value = [];
    MatReturnList.value = [];
    var response = await MaterialReturnProvider.getMatReturn_List(
        MatReturnlistFrDate.text, MatReturnlistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          MatReturnList.assignAll(response.result!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  // ==========================================================
  // EDIT / DELETE
  // ==========================================================

  Future materialRetEntryList_EditApi(int returnId,MenuName, BuildContext context) async {
    await MaterialReturnProvider.MatRetrnList_editAPI(returnId).then((value) async {
      if (value != null && value.length > 0) {
        GrnMaterialTabledelete();
        saveButton.value = RequestConstant.RESUBMIT;
        grnMaterial_EditApiList.value = value;
        grnMaterial_Details_EditTableSave();
        getGrnMaterialTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MaterialReturn_Entry(heading: MenuName)),
        );
      }
    });
  }


  // New delete API
  Future<bool> materialReturn_List_DeleteApi(int Id) async {
    return MaterialReturnProvider.MaterialReturn_List_deleteAPI(Id);
  }


  Future getGrnMaterialDetails() async {
    getGRN_MaterialList.value = [];
    searchCatNameList.value = [];
    var response =  await MaterialReturnProvider.getMaterialDetailsList_API(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        reportsController.selectedsuppliertId.value);
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"]!.isNotEmpty) {
          getGRN_MaterialList.assignAll(response["result"]!);
          searchCatNameList.assignAll(response["result"]!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response["message"] ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future getGRNList(String materialId) async {
    mainEtyList.value = [];
    MatReturnList.value = [];
    GRNmainlist.clear();
    getGRN_List.clear();

    var response = await MaterialReturnProvider.getGRNList_API(
      materialId,
      siteController.selectedsiteId.value,
      reportsController.selectedsuppliertId.value,
    );

    if (response == null) {
      BaseUtitiles.showToast("Something Went Wrong...");
      return;
    }

    if (response["success"] != true) {
      BaseUtitiles.showToast(response["message"] ?? 'Something went wrong..');
      return;
    }

    final result = List<Map<String, dynamic>>.from(
      (response["result"] as List? ?? []).map((e) => Map<String, dynamic>.from(e)),
    );

    if (result.isEmpty) {
      BaseUtitiles.showToast("No Data Found");
      return;
    }

    // 1) Unit: one call for the whole list (same material)
    String unitName = '';
    int unitId = 0;
    try {
      final unitRes = await MaterialReturnProvider.getUnitAPI(materialId);
      if (unitRes != null && unitRes['success'] == true) {
        unitName = unitRes['unitName']?.toString() ?? '';
        unitId = unitRes['id'] ?? 0;
      }
    } catch (_) {}

// 2) Stock qty: one call per row, in parallel
    await Future.wait(result.map((item) async {
      double qty = 0;
      try {
        final stockRes =
        await MaterialReturnProvider.getStockQty_API(item['stockInId']);
        if (stockRes != null && stockRes['success'] == true) {
          qty = (stockRes['result']?['stockQty'] as num?)?.toDouble() ?? 0;
        }
      } catch (_) {}

      item['stockQty'] = qty;
      item['unitName'] = unitName;
      item['unitId'] = unitId;
      item['isCheck'] ??= false;
    }));

    // shared references on purpose: checks persist while searching
    GRNmainlist.assignAll(result);
    getGRN_List.assignAll(result);
  }


  // ==========================================================
  // SAVE
  // ==========================================================

  Future SaveButton_GRNMaterialScreen(BuildContext context, String returnId) async {
    // buttonControl = 1;
    // getReturnDetList.value = [];
    // await Future.delayed(const Duration(seconds: 0));
    // String body = GrnMaterialsaveResponseToJson(GrnMaterialsaveResponse(
    //   returnId: returnId,
    //   returnNo: autoYearWiseNoController.text,
    //   returnDate: MatRetEntryDate.text,
    //   projectId: projectController.selectedProjectId.value.toString(),
    //   siteId: siteController.selectedsiteId.value.toString(),
    //   supplierId: supplierController.selectedsuppliertId.value.toString(),
    //   remarks: MatRetEntry_RemarksController.text,
    //   preparedby: loginController.EmpId(),
    //   userId: loginController.UserId(),
    //   entryMode: returnId != "0" ? "UPDATE" : "ADD",
    //   deviceName: BaseUtitiles.deviceName,
    //   returnDet: getReturnDetList.value.isEmpty
    //       ? getReturnDet()
    //       : getReturnDetList.value,
    // ));
    // final list = await MaterialReturn_Provider.SaveGRNMaterialSaveAPI(
    //     body, returnId, buttonControl, context);
    //
    // print('MaterialReturn response..${list}');
    //
    // if (list != null) {
    //   if (list == "Record Saved Successfully..." ||
    //       list == "Record Updated Successfully...") {
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //     BaseUtitiles.showToast(list!);
    //     await getMatRtrn_EntryList();
    //     GrnMaterialTabledelete();
    //     grnMaterialReadList.value = [];
    //     buttonControl = 0;
    //   } else {
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //     BaseUtitiles.showToast("Something went wrong");
    //   }
    // }
  }

  List<ReturnDet>? getReturnDet() {
    getReturnDetList.value = [];
    grnMaterialReadList.value.forEach((element) {
      var list = ReturnDet(
        materialId: element.materialId.toString(),
        rate: "0",
        qty: element.returnQty.toString(),
        amount: "0",
        stockInId: element.stockinId.toString(),
      );
      getReturnDetList.value.add(list);
    });
    return getReturnDetList.value;
  }

  setTextLabValue(value) {
    int i = 0;
    value.forEach((datas) {
      ReturnQtyController[i].text = datas.returnQty.toString();
      i++;
    });
  }

  // ==========================================================
  // LOCAL DB
  // ==========================================================

  getGrnMaterialTablesDatas() async {
    var datas = await materialReturn_Service.GrnMaterial_Table_readAll();
    grnMaterialReadList.value = [];
    datas.forEach((value) {
      var grnMaterialTable = grnMaterial_Table();
      grnMaterialTable.stockinId = value['stockInId'];
      grnMaterialTable.transNo = value['transNo'];
      grnMaterialTable.materialId = value['materialId'];
      grnMaterialTable.materialName = value['materialName'];
      grnMaterialTable.qty = value['qty'];
      grnMaterialTable.stockQty = value['stockQty'];
      grnMaterialTable.scale = value['scale'];
      grnMaterialTable.projectId = value['projectId'];
      grnMaterialTable.siteId = value['siteId'];
      grnMaterialTable.supplierId = value['supplierId'];
      grnMaterialTable.returnQty = value['returnQty'];
      grnMaterialReadList.add(grnMaterialTable);
    });

    textControllersInitiate();
    setTextLabValue(grnMaterialReadList);
  }

  grnMaterial_DetailsTableSave(BuildContext context) async {
    grnMaterialTableModelList = [];
    textControllersInitiate();

    for (final element in getGRN_List) {
      if (element['isCheck'] != true) continue;

      final grnMaterialTable = grnMaterial_Table();
      grnMaterialTable.stockinId = element['stockInId'];
      grnMaterialTable.transNo = element['transNo'];
      grnMaterialTable.materialId = int.tryParse(selectedGRN_Id.value);
      grnMaterialTable.materialName = GRN_StockInNo_Controller.text;
      grnMaterialTable.qty = element['qty'];
      grnMaterialTable.stockQty = element['stockQty'];   // from stock qty api
      grnMaterialTable.scale = element['unitName'];      // from unit api
      grnMaterialTable.projectId = projectController.selectedProjectId.value;
      grnMaterialTable.siteId = siteController.selectedsiteId.value;
      grnMaterialTable.supplierId = reportsController.selectedsuppliertId.value;
      grnMaterialTable.returnQty = "0.0";

      final entryExists = grnMaterialReadList.any((existing) =>
      existing.materialId == grnMaterialTable.materialId &&
          existing.stockinId == grnMaterialTable.stockinId);

      if (entryExists) {
        BaseUtitiles.showToast("Entries already exist for ${element['transNo']}");
      } else {
        grnMaterialTableModelList.add(grnMaterialTable);
      }
    }

    if (grnMaterialTableModelList.isNotEmpty) {
      var savedatas = await materialReturn_Service
          .GrnMaterial_Table_Save(grnMaterialTableModelList);
      Navigator.pop(context, savedatas);
    }
  }

  grnMaterial_Details_EditTableSave() async {
    grnMaterialTableModelList.clear();
    grnMaterial_EditApiList.value.forEach((element) {
      element.returnEditDet.forEach((data) {
        var grnMaterialTable = grnMaterial_Table();
        grnMaterialTable.materialId = data.materialId;
        grnMaterialTable.materialName = data.materialName;
        grnMaterialTable.scale = data.unit;
        grnMaterialTable.transNo = data.grnNo;
        grnMaterialTable.stockQty = data.stockQty;
        grnMaterialTable.returnQty = data.qty.toString();
        grnMaterialTable.stockinId = data.stockinId;
        grnMaterialTableModelList.add(grnMaterialTable);
      });
    });
    var savedatas = await materialReturn_Service
        .GrnMaterial_Table_Save(grnMaterialTableModelList);
    return savedatas;
  }

  updateGrnMaterialTable() async {
    int i = 0;
    grnMat_UpdateModelListReadList = [];
    grnMaterialReadList.forEach((element) {
      var grnMaterialTable = grnMaterial_Table();
      grnMaterialTable.stockinId = element.stockinId;
      grnMaterialTable.transNo = element.transNo;
      grnMaterialTable.materialId = element.materialId;
      grnMaterialTable.materialName = element.materialName;
      grnMaterialTable.qty = element.qty;
      grnMaterialTable.stockQty = element.stockQty;
      grnMaterialTable.scale = element.scale;
      grnMaterialTable.projectId = element.projectId;
      grnMaterialTable.siteId = element.siteId;
      grnMaterialTable.supplierId = element.supplierId;
      grnMaterialTable.returnQty = ReturnQtyController[i].value.text.toString();
      grnMat_UpdateModelListReadList.add(grnMaterialTable);
      i++;
    });
    await materialReturn_Service
        .GrnMaterial_Table_Update(grnMat_UpdateModelListReadList);
  }

  GrnMaterialTabledelete() async {
    await materialReturn_Service.GrnMaterialDetdelete();
  }

  deleteParticularList(grnMaterial_Table data) async {
    grnMat_UpdateModelListReadList = [];
    var grnMaterialTable = grnMaterial_Table();
    grnMaterialTable.materialId = data.materialId;
    grnMaterialTable.stockinId = data.stockinId;
    grnMat_UpdateModelListReadList.add(grnMaterialTable);
    await materialReturn_Service
        .GrnMaterial_Det_deleteById(grnMat_UpdateModelListReadList);
    updateGrnMaterialTable();
  }

  textControllersInitiate() {
    if (ReturnQtyController.length != grnMaterialReadList.length) {
      ReturnQtyController.clear(); // Clear only once
      for (int i = 0; i < grnMaterialReadList.length; i++) {
        ReturnQtyController.add(
          TextEditingController(
            text: grnMaterialReadList[i].returnQty ?? "0.0",
          ),
        );
      }
    }
  }


  // ==========================================================
  // CHECKBOX
  // ==========================================================

  void setCheck(int id, bool value) {
    for (final element in getGRN_List) {
      if (element['stockInId'] == id) {
        element['isCheck'] = value;
      }
    }
    getGRN_List.refresh(); // notify GetX listeners
  }

  void clearCheck() {
    if (isChecked.length != getGRN_MaterialList.length) {
      isChecked = List<bool>.filled(getGRN_MaterialList.length, false);
    }

    for (int i = 0; i < getGRN_MaterialList.length; i++) {
      isChecked[i] = false;
      getGRN_MaterialList[i]['isCheck'] = false;
    }
    getGRN_MaterialList.refresh();
  }
  // ==========================================================
  // VALIDATION
  // ==========================================================

  clickEdit() async {
    for (var index = 0; index < grnMaterialReadList.length; index++) {
      final returnText = ReturnQtyController[index].text.trim();
      final stockQty = grnMaterialReadList[index].stockQty;
      final returnQty = double.tryParse(returnText);

      if (returnText.isEmpty || returnQty == null || returnQty == 0.0) {
        BaseUtitiles.showToast("Return qty should not be empty");
        return; // Stop processing further
      } else if (returnQty > stockQty) {
        ReturnQtyController[index].text = "0.0";
        BaseUtitiles.showToast("Return qty should not exceed the stock qty");
        return; // Stop processing further
      }
    }

    // If all validations pass
    await updateGrnMaterialTable();
  }
}