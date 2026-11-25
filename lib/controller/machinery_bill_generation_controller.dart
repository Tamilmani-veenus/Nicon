import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MachineryBillGenController extends GetxController {
  final autoYearWiseNoController = TextEditingController();
  final requestDateController = TextEditingController();
  final paymentWKDateController = TextEditingController();
  final remarksController = TextEditingController();
  final preparedByController = TextEditingController();
  final wrkOrderNoController = TextEditingController();

  RxString saveButton = RequestConstant.SUBMIT.obs;

  RxList getdpDnWrkOrderValue = [].obs;

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

}