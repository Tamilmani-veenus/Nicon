import '../controller/logincontroller.dart';
import '../controller/menu_controller.dart';
import '../models/datepicker_model.dart';
import '../provider/common_provider.dart';
import 'package:get/get.dart';
import '../utilities/baseutitiles.dart';

class CommanController extends GetxController {

  RxInt deleteMode=0.obs;
  RxInt editMode=0.obs;
  RxInt addMode=0.obs;
  final RxList<DatePermission> datePickerResponse = <DatePermission>[].obs;

  LoginController loginController = Get.put(LoginController());
  Menu_Controller menuController = Get.put(Menu_Controller());

  Future getControllEntryListRights() async {
    deleteMode.value=0;
    editMode.value=0;
    await CommonProvider.getSubControllerRightsEntryList(menuController.formMenuId.value).then((value) async {
      if (value != null) {
        if (value.success == true) {
          final result = value.result!;
          deleteMode.value = (result.allowDelete ?? false) ? 1 : 0;
          editMode.value = (result.allowEdit ?? false) ? 1 : 0;
          addMode.value = (result.allowAdd ?? false) ? 1 : 0;
          return value;
        }
        else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      }
      else {
        BaseUtitiles.showToast('Something went wrong..');
      }
    });
  }


  Future getDateCount() async {
    datePickerResponse.value = [];
    final response = await CommonProvider.getDateCount(menuController.formMenuId.value);

    if (response != null ) {
      if(response.success == true) {
        datePickerResponse.assignAll(response.response ?? []);
      }
      else{
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast('Something went wrong..');
      print("Date Picker API Failed: ${response?.message}");
    }
  }
}


