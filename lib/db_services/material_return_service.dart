import 'package:nicon/db_helper/db_manager.dart';
import '../db_model/grnMaterial_Table_model.dart';

class MaterialReturn_Service{
  late DBManager _dbManager;

  MaterialReturn_Service(){
    _dbManager = DBManager();
  }

  GrnMaterial_Table_Save(List<grnMaterial_Table> grnMaterialTableModel) async {
    grnMaterialTableModel.forEach((element) async {
      return await _dbManager.insertData('grnMaterialTable', element.grnMaterial_Map());
    });
  }


  GrnMaterial_Table_readAll() async {
    return _dbManager.readData('grnMaterialTable');
  }

  GrnMaterialDetdelete() async {
    return await _dbManager.delete('grnMaterialTable');
  }

  GrnMaterial_Det_deleteById(List<grnMaterial_Table> grnMaterialTableModel) async {
    grnMaterialTableModel.forEach((element) async {
      return await _dbManager.grnMaterial_deleteDataById('grnMaterialTable', element.grnMaterial_Map());
    });
  }

  GrnMaterial_Table_Update(List<grnMaterial_Table> grnMaterialTableModel) async {
    grnMaterialTableModel.forEach((element) async {
      return await _dbManager.Update_GrnMaterial_Table('grnMaterialTable', element.grnMaterial_Map());
    });
  }

}