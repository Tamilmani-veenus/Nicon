import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/repair_Consumption_controller.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/expense_type_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/consumption_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/common_date_fields.dart';
import '../../../../utilities/requestconstant.dart';

class RepairConsumptionEntryScreen extends StatefulWidget {
  final String heading;
  const RepairConsumptionEntryScreen({super.key,required this.heading});

  @override
  State<RepairConsumptionEntryScreen> createState() => _RepairConsumptionEntryScreenState();
}

class _RepairConsumptionEntryScreenState extends State<RepairConsumptionEntryScreen> {
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  RepairConsumptionController repairConsumptionController = Get.put(RepairConsumptionController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    var duration = const Duration(seconds:0);
    Future.delayed(duration,() async {

      if(repairConsumptionController.saveButton.value == RequestConstant.RESUBMIT) {
        repairConsumptionController.RepairConsum_EditListApiValue.forEach((element) {
          repairConsumptionController.UsageId=element.id!;
          repairConsumptionController.autoYearWiseNoController.text=element.repairNo!;
          repairConsumptionController.RepairConsumDate.text =element.entryDt!;
          projectController.projectname.text =element.projectName!;
          projectController.selectedProjectId.value=element.projectid!;
          siteController.Sitename.text = element.siteName!;
          siteController.selectedsiteId.value=element.siteid!;
          subcontractorController.supplierName.text = (element.supplierName! == "" ? "--SELECT--" : element.supplierName)!;
          subcontractorController.selectedSupplierId.value=element.supplierId!;
          repairConsumptionController.repairTypeController.text = element.repairType!.toString().trim()=="Return" ? "Service Return" : "Service Request";
          repairConsumptionController.repairType = element.repairType!.toString().trim();
          repairConsumptionController.PreparedbyController.text=element.createdByName!;
          repairConsumptionController.RemarksController.text=element.remarks!;
          repairConsumptionController.createdById.value=element.createdBy!;
        });
      }

      if(repairConsumptionController.saveButton.value ==RequestConstant.SUBMIT){
        consumption_controller.delete_Consum_itemlist_Table();
        repairConsumptionController.UsageId=0;
        repairConsumptionController.saveButton.value = RequestConstant.SUBMIT;
        projectController.projectname.text="--SELECT--";
        projectController.selectedProjectId.value=0;
        siteController.Sitename.text = RequestConstant.SELECT;
        siteController.selectedsiteId.value=0;
        subcontractorController.supplierName.text= RequestConstant.SELECT;
        subcontractorController.selectedSupplierId.value=0;
        repairConsumptionController.repairTypeController.text = "--SELECT--";
        repairConsumptionController.repairType = "0";
        repairConsumptionController.RemarksController.text = "";
        repairConsumptionController.createdById.value=0;
        consumption_controller.Consum_itemview_GetDbList.clear();
        await autoYearWiseNoController.AutoYearWiseNo("REPAIR CONSUMPTION");
        repairConsumptionController.RepairConsumDate.text = BaseUtitiles.initiateCurrentDateFormat();
        repairConsumptionController.PreparedbyController.text = loginController.EmpName();
        repairConsumptionController.autoYearWiseNoController.text = autoYearWiseNoController.RepairConsum_autoYrWise.value;
      }
      if (!mounted) return;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Form(
        key: _formKey,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.heading,
                                style: TextStyle(
                                    fontSize: RequestConstant.Heading_Font_SIZE,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(color: Colors.grey, fontSize: 18),
                                ))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: repairConsumptionController.autoYearWiseNoController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Usage Number",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.requestNo),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child:   CommonDateFields(
                              date1: CommonDateFieldConfig(
                                title: "Date",
                                value: repairConsumptionController.RepairConsumDate.text,
                                controller: repairConsumptionController.RepairConsumDate,
                                selectable: loginController.user.value.userType != "S",
                                initialDate: DateTime.tryParse(
                                  repairConsumptionController.RepairConsumDate.text,
                                ) ??
                                    DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                                onChanged: (date) {
                                  setState(() {
                                    repairConsumptionController.RepairConsumDate.text =
                                        CommonDateUtils.formatApiDate(date);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: projectController.projectname,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText:"Project Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName),
                              ),
                              onTap: () async {
                                if(repairConsumptionController.saveButton==RequestConstant.RESUBMIT){
                                }
                                else{
                                    await projectController.getProjectList();
                                    bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value);
                                }
                              },

                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: siteController.Sitename,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText:"Site Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.siteName),
                              ),
                              onTap: () {
                                if(repairConsumptionController.saveButton==RequestConstant.RESUBMIT){

                                }
                                else{
                                  // siteController.subcont_SiteEntry_SiteDropdowntList(context,0);
                                  setState(() {
                                    bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
                                  });

                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: subcontractorController.supplierName,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Supplier Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.supplierName),
                              ),
                              onTap: () async {
                                await subcontractorController.getSupplierList();
                                bottomsheetControllers.SupplierName(context, subcontractorController.getSupplierdropDownvalue.value,type: "Repair Consumption");
                              },
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: repairConsumptionController.repairTypeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Type",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.types),
                              ),
                              onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const RepairTypeAlert();
                                      });
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: repairConsumptionController.PreparedbyController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.PREPARED_BY,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.preparedBy),
                              ),
                              onChanged: (value){
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              controller: repairConsumptionController.RemarksController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.REMARKS,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.remarks),
                              ),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return '\u26A0 ${RequestConstant.VALIDATE}';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Setmybackground),
                              onPressed: () async {

                                if(_formKey.currentState!.validate()){
                                  _formKey.currentState!.save();
                                  if(repairConsumptionController.repairTypeController.text == "--SELECT--" && repairConsumptionController.repairType == "0"){
                                    Fluttertoast.showToast(msg: "Please select type");
                                  }
                                 else if(projectController.selectedProjectId.value!=0 && siteController.selectedsiteId.value!=0){
                                    await consumption_controller.getStock_Material(context);
                                  }
                                  else{
                                    BaseUtitiles.showToast("Some field is missing");
                                  }
                                }


                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.add, color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 5),
                                  Text("Add items", style: TextStyle(color: Theme.of(context).primaryColor),),
                                ],
                              )),
                        ],
                      ),

                    ],
                  ),
                ),

                Obx(() => Visibility(
                  visible: consumption_controller.Consum_itemview_GetDbList.value.isEmpty ? false : true,
                  child: SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 100),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      initialChildSize: 0.3,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Setmybackground,
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.9,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(top: 10),
                                            child: ListDetails(context, scrollController)
                                        ),
                                      ],
                                    ),
                                  )),
                              IgnorePointer(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ),

              ],
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white ,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Theme.of(context).primaryColor ),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          ResetAlert(context);
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20 , right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color:  Theme.of(context).primaryColor   ,
                        ),
                        alignment: Alignment.center,
                        child: Text( repairConsumptionController.saveButton.value,  style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                            color:   Colors.white  ),),
                      ),
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          if(repairConsumptionController.repairTypeController.text == "--SELECT--" && repairConsumptionController.repairType == "0"){
                            Fluttertoast.showToast(msg: "Please select type");
                          }else if(repairConsumptionController.repairTypeController.text == "--SELECT--" && consumption_controller.Consum_itemview_GetDbList.value.isEmpty){
                            Fluttertoast.showToast(msg: "Please add items");
                          } else{
                            bool hasInvalid = false;
                            for (int i = 0; i < consumption_controller.Consum_itemview_GetDbList.length; i++) {
                              final controller = consumption_controller.Itemlist_UsageqtyControllers[i];
                              final text = controller.text.trim();

                              if (text.isEmpty) {
                                hasInvalid = true;
                                break;
                              }

                              final value = double.tryParse(text);
                              if (value == null || value <= 0) {
                                hasInvalid = true;
                                break;
                              }
                            }
                            if (hasInvalid) {
                              BaseUtitiles.showToast("Usage Qty Should Not be Zero or Empty");
                            } else {
                              SubmitAlert(context);
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails(context, scrollController) {
    return Column(
      children: [
        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 4, right: 4),
          height: BaseUtitiles.getheightofPercentage(context, 80),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: consumption_controller.Consum_itemview_GetDbList.value.length,
            itemBuilder: (BuildContext context, int index) {
              consumption_controller.Consumption_itemlist_textControllersInitiate();
              return Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "${consumption_controller.Consum_itemview_GetDbList.value[index].material} (${consumption_controller.Consum_itemview_GetDbList.value[index].scale})",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Dropdown_Font_SIZE,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 2),
                            width: BaseUtitiles.getWidthtofPercentage(context, 10),
                            child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        RequestConstant.DO_YOU_WANT_DELETE,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Cancel",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.grey,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              RequestConstant
                                                                  .Lable_Font_SIZE))),
                                                ),
                                                VerticalDivider(
                                                  color: Colors.grey.shade400,
                                                  width: 5,
                                                  thickness: 2,
                                                  indent: 15,
                                                  endIndent: 15, //Spacing at the bottom of divider.
                                                ),
                                                Expanded(
                                                  child: TextButton(
                                                      onPressed: () {
                                                        consumption_controller.deleteParticularList(consumption_controller.Consum_itemview_GetDbList[index]);
                                                        consumption_controller.Consum_itemview_GetDbList.remove(consumption_controller.Consum_itemview_GetDbList[index]);
                                                        consumption_controller.getConumTablesDatas();
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Delete",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.red,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              RequestConstant
                                                                  .Lable_Font_SIZE))),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Icon(Icons.remove_circle,
                                    color: Colors.red
                                  // color: Theme.of(context).primaryColor
                                )
                              // Image.asset('assets/cancle.png'),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Container(
                      margin: const EdgeInsets.only(top: 10,),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                              height: BaseUtitiles.getheightofPercentage(context,4),
                              width: BaseUtitiles.getWidthtofPercentage(context,25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: consumption_controller.Itemlist_stockqtyControllers[index],
                                keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],

                                decoration: InputDecoration(
                                  labelText: 'Stock Quantity',
                                  labelStyle: const TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                style: const TextStyle(color: Colors.black),
                                onTap: (){
                                  BaseUtitiles.showToast("Can't be edit");
                                },
                              ),
                            ),

                            VerticalDivider(
                              color: Colors.grey.shade400,
                              width: 5,
                              thickness: 2,
                              indent: 15,
                              endIndent: 15, //Spacing at the bottom of divider.
                            ),

                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                              height: BaseUtitiles.getheightofPercentage(context,4),
                              width: BaseUtitiles.getWidthtofPercentage(context,25),
                              child: TextFormField(
                                onTap: (){
                                  if(consumption_controller.Itemlist_UsageqtyControllers[index].text != "" && consumption_controller.Itemlist_UsageqtyControllers[index].text != "0" && consumption_controller.Itemlist_UsageqtyControllers[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      consumption_controller.Itemlist_UsageqtyControllers[index].text = "";
                                      consumption_controller.ConsumItemlist_clickEdit();
                                    });
                                  }
                                },
                                cursorColor:Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: consumption_controller.Itemlist_UsageqtyControllers[index],
                                keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Usage Quantity',
                                  labelStyle: const TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  setState(() {
                                    consumption_controller.ConsumItemlist_clickEdit();
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

            },
          ),

        ),
      ],
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Reset?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            repairConsumptionController.UsageId=0;
                            repairConsumptionController.saveButton.value = RequestConstant.SUBMIT;

                            repairConsumptionController.RepairConsumDate.text = BaseUtitiles.initiateCurrentDateFormat();
                            repairConsumptionController.PreparedbyController.text = loginController.EmpName();
                            repairConsumptionController.autoYearWiseNoController.text = autoYearWiseNoController.RepairConsum_autoYrWise.value;

                            siteController.getSiteDropdownvalue.value.clear();
                            projectController.projectname.text = "--SELECT--";
                            siteController.Sitename.text = RequestConstant.SELECT;
                            siteController.siteDropdownName.clear();
                            repairConsumptionController.repairTypeController.text = "--SELECT--";
                            repairConsumptionController.repairType = "";
                            repairConsumptionController.RemarksController.text = "";
                            consumption_controller.delete_Consum_itemlist_Table();
                            consumption_controller.Consum_itemview_GetDbList.clear();
                            Navigator.pop(context);
                          });

                        },
                        child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text(repairConsumptionController.saveButton==RequestConstant.RESUBMIT  ? 'Are you sure to Re-Submit?' :
        'Are you sure to Submit?' ),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed:  () async {
                          if (projectController.selectedProjectId.value == 0 || siteController.selectedsiteId.value == 0) {
                            BaseUtitiles.showToast("Some field missing *");
                          } else {
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              consumption_controller.Consum_itemview_GetDbList.clear();
                              await repairConsumptionController.SaveButton_ItemlistScreen(
                                context, repairConsumptionController.UsageId != 0 ? repairConsumptionController.UsageId : 0,
                              );
                            }
                          }
                        },
                        child: Text(
                          repairConsumptionController.saveButton.value,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor, // Change color when button is disabled
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
