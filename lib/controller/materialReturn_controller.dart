import 'package:nicon/controller/projectcontroller.dart';
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

  // Old list screen
  final MatRtrnlistFrDate = TextEditingController();
  final MatRtrnlistToDate = TextEditingController();

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
  SupplierController supplierController = Get.put(SupplierController());
  LoginController loginController = Get.put(LoginController());


  // ==========================================================
  // OBSERVABLES
  // ==========================================================

  RxString returnId = "0".obs;
  RxString selectedGRN_Id = "0".obs;
  RxString selectedGRN_No = "".obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;   // was in both
  RxBool isFromEdit = false.obs;

  RxList MatRetrnEtyList = [].obs;                    // old list
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


  // ==========================================================
  // GRN
  // ==========================================================

  Future getGRNList(String materialId) async {
    getGRN_List.value = [];
    GRNmainlist.value = [];
    await MaterialReturnProvider.getGRNList_API(
        materialId,
        siteController.selectedsiteId.value,
        supplierController.selectedsuppliertId.value)
        .then((value) async {
      if (value != null && value.length > 0) {
        GRNmainlist.value = value;
        getGRN_List.value = GRNmainlist.value;
        return GRNmainlist.value;
      }
    });
  }

  Future getGrnMaterialDetails() async {
    getGRN_MaterialList.value = [];
    searchCatNameList.value = [];
    await MaterialReturnProvider.getMaterialDetailsList_API(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        supplierController.selectedsuppliertId.value)
        .then((value) async {
      if (value != null && value.length > 0) {
        getGRN_MaterialList.value = value;
        searchCatNameList.value = getGRN_MaterialList.value;
        return searchCatNameList.value;
      }
    });
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
      grnMaterialTable.stockinId = value['stockinId'];
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
    bool entryExists = false;
    textControllersInitiate();
    getGRN_List.forEach((element) {
      if (element.isCheck == true) {
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
        grnMaterialTable.returnQty = "0.0";

        entryExists = grnMaterialReadList.any((existingElement) =>
        existingElement.materialId == grnMaterialTable.materialId &&
            existingElement.stockinId == grnMaterialTable.stockinId);

        if (entryExists) {
          BaseUtitiles.showToast("Entries already exist for ${element.transNo}");
        } else {
          grnMaterialTableModelList.add(grnMaterialTable);
        }
      }
    });

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
  // SELECTION
  // ==========================================================

  SelectedGRN_ID(String value) {
    if (getGRN_MaterialList.value.length > 0) {
      getGRN_MaterialList.forEach((element) {
        if (value == element.materialName) {
          selectedGRN_Id(element.materialId);
        }
      });
    }
    SelectedGRN_No(selectedGRN_Id.value);
  }

  SelectedGRN_No(String id) {
    if (getGRN_MaterialList.value.length > 0) {
      getGRN_MaterialList.forEach((element) {
        if (id == element.materialId) {
          selectedGRN_No(element.materialName);
        }
      });
    }
    GRN_StockInNo_Controller.text = selectedGRN_No.value;
  }

  // ==========================================================
  // CHECKBOX
  // ==========================================================

  setCheck(int id, bool value) {
    getGRN_List.forEach((element) {
      if (element.stockinId == id) {
        element.isCheck = value;
      }
    });
  }

  void clearCheck() {
    if (isChecked.isEmpty) {
      isChecked = List<bool>.filled(getGRN_MaterialList.length, false);
    }

    for (int i = 0; i < getGRN_MaterialList.length; i++) {
      isChecked[i] = false;
      getGRN_MaterialList[i].isCheck = false;
    }
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