import '../apimanager/apimanager.dart';
import '../utilities/apiconstant.dart';

// class SupplierBillAppProvider{
//   static Future<MaterialeditResponse?> SupplierBillGetByIdAPI(int reqId) async {
//     try {
//       final value = await ApiManager.getAPICall("${ApiConstant.GET_SUPP_BILL_APP_EDIT_API}?id=$reqId");
//       return materialeditResponseFromJson(value);
//     } catch (error) {
//       print("Error == $error");
//       return null;
//     }
//   }
// }