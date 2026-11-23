import '../db_helper/db_manager.dart';
import '../db_model/materiallist_model.dart';
import '../models/machinerydpr_model.dart';

class MateriallistService{
  late DBManager _dbManager;

  MateriallistService() {
    _dbManager = DBManager();
  }

  Material_table_Save(
      List<Materiallist> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.insertData('materialListTable', element.Materiallistmodelmap());
    });
  }

  MaterialItemlist_table_readAll() async {
    return _dbManager.readData('materialListTable');
  }


  materialdeleteById(List<Materiallist> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.deleteMaterialById('materialListTable', element.Materiallistmodelmap());
    });
  }

  MaterialItemlist_table_delete() async {
    return await _dbManager.delete('materialListTable');
  }

  MaterialItemlist_table_Update(
      List<Materiallist> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.Update_MaterialTable('materialListTable', element.Materiallistmodelmap());
    });
  }


}

class MachineryDPRDetLocalService {
  late DBManager _dbManager;

  MachineryDPRDetLocalService() {
    _dbManager = DBManager();
  }

  MachineryDPRDetLocal_table_Save(
      List<MachineryDPRDetLocal> machineryDPRDetLocalTableModel) async {
    for (var element in machineryDPRDetLocalTableModel) {
      await _dbManager.insertData(
          'MachineryDPRDetLocal', element.MachineryDPRDetLocalModelMap());
    }
  }

  MachineryDPRDetLocal_table_readAll() async {
    return _dbManager.readData('MachineryDPRDetLocal');
  }

  MachineryDPRDetLocal_deleteById(
      List<MachineryDPRDetLocal> machineryDPRDetLocalTableModel) async {
    for (var element in machineryDPRDetLocalTableModel) {
      await _dbManager.deleteMaterialById(
          'MachineryDPRDetLocal', element.MachineryDPRDetLocalModelMap());
    }
  }

  MachineryDPRDetLocal_table_delete() async {
    return await _dbManager.delete('MachineryDPRDetLocal');
  }

  MachineryDPRDetLocal_table_Update(
      List<MachineryDPRDetLocal> machineryDPRDetLocalTableModel) async {
    for (var element in machineryDPRDetLocalTableModel) {
      await _dbManager.Update_MachineryDPRTable(
          'MachineryDPRDetLocal', element.MachineryDPRDetLocalModelMap());
    }
  }
}