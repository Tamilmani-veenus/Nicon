import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../provider/supplier_bill_approval_provider.dart';
import '../utilities/baseutitiles.dart';

class SupplierBillApprovalController extends GetxController {

  // Future suppBillApprovalEditApi(int reqId, context) async {
  //   await ClickUtils.run(() async {
  //     final value = await SupplierBillAppProvider.SupplierBillGetByIdAPI(reqId);
  //     if (value != null) {
  //       if (value.success == true) {
  //         delete_MaterialIntent_itemlist_Table();
  //         Material_EditListApiValue.value = [value.result];
  //         if (Material_EditListApiValue.value.isNotEmpty) {
  //           Material_Intentlist_editSaveDetTable();
  //           getMaterialTablesDatas();
  //           saveButton.value = RequestConstant.RESUBMIT;
  //           await Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) =>  MRNRequest_Indent_Entry(heading: MenuName,)));
  //         } else {
  //           BaseUtitiles.showToast("No Data Found");
  //         }
  //       } else {
  //         BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
  //       }
  //     } else {
  //       BaseUtitiles.showToast('Something went wrong..');
  //     }
  //   });
  // }


}