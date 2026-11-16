import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../db_services/materialReturnlist_service.dart';
import '../provider/materialReturn_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MaterialReturn_Controller extends GetxController {

  final MatReturnlistFrDate = TextEditingController();
  final MatReturnlistToDate = TextEditingController();

  RxList MatReturnList = [].obs;
  RxList mainEtyList = [].obs;
  RxList MatReturn_itemview_GetDbList = [].obs;

  var matReturnItemlistService = MaterialReturnItemlistService();

  RxString saveButton = RequestConstant.SUBMIT.obs;


  Future getMaterialReturn_List() async {
    mainEtyList.value=[];
    MatReturnList.value=[];
    var response = await MaterialReturnProvider.getMatReturn_List(
        MatReturnlistFrDate.text,
        MatReturnlistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          MatReturnList.assignAll(response.result!);
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

  delete_material_Return_itemlist_Table() async {
    await matReturnItemlistService.MatReturnItemlist_table_delete();
  }

  // ----------Delete call API --------------
  Future<bool> materialReturn_List_DeleteApi(int Id) async {
    return MaterialReturnProvider.MaterialReturn_List_deleteAPI(Id);
  }
}