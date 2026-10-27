import '../db_helper/db_manager.dart';
import '../db_model/supp_bill_app_model.dart';

class SuppBillAppService {
  late DBManager _dbManager;

  SuppBillAppService() {
    _dbManager = DBManager();
  }

  suppBillAppList_table_delete() async {
    return await _dbManager.delete('supplierBillAppDetTable');
  }

  suppBillAppList_table_Save(
      List<SupplierBillAppDet> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.insertData('supplierBillAppDetTable', element.SupplierBillAppDetmodelmap());
    });
  }

  suppBillApplist_table_readAll() async {
    return  _dbManager.readData('supplierBillAppDetTable');
  }
}