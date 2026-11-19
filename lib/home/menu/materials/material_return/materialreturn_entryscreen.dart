import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/materialReturn_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/reports_controller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'materialreturn_itemlist.dart';

class MaterialReturn_Entry extends StatefulWidget {
  final String heading;
  const MaterialReturn_Entry({Key? key,required this.heading}) : super(key: key);

  @override
  State<MaterialReturn_Entry> createState() => _MaterialReturn_EntryState();
}

class _MaterialReturn_EntryState extends State<MaterialReturn_Entry> {

  LoginController loginController=Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
  CommanController commanController = Get.put(CommanController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  MaterialReturn_Controller matreturnController = Get.put(MaterialReturn_Controller());
  ReportsController reportsController = Get.put(ReportsController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState(){
    var duration = Duration(seconds:0);
    Future.delayed(duration,() async {

      if(matreturnController.saveButton.value == RequestConstant.SUBMIT){
        matreturnController.isFromEdit.value=false;
        matreturnController.returnId.value="0";
        matreturnController.GRN_StockInNo_Controller.text="--SELECT--";
        matreturnController.selectedGRN_Id.value="0";
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value=0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value=0;
        reportsController.suppliername.text = "--SELECT--";
        reportsController.selectedsuppliertId.value=0;
        await autoYearWiseNoController.AutoYearWiseNo("MATERIAL RETURN");
        matreturnController.autoYearWiseNoController.text = autoYearWiseNoController.MaterialRet_autoYrWise.value;
        matreturnController.MatRetEntryDate.text = BaseUtitiles.initiateCurrentDateFormat();
        matreturnController.MatRetEntry_preparedbyController.text = loginController.EmpName();
        matreturnController.MatRetEntry_RemarksController.text = "";
      }

      else if(matreturnController.saveButton.value == RequestConstant.RESUBMIT) {
          matreturnController.isFromEdit.value=true;
          matreturnController.GRN_StockInNo_Controller.text ="--SELECT--";
          matreturnController.grnMaterial_EditApiList.forEach((element) {
          matreturnController.returnId.value = element.id.toString();
          matreturnController.autoYearWiseNoController.text = element.returnNo.toString().trim();
          matreturnController.MatRetEntryDate.text = element.entryDt;
          projectController.projectname.text = element.projectName;
          projectController.selectedProjectId.value = element.projectid;
          siteController.Sitename.text = element.siteName;
          siteController.selectedsiteId.value = element.siteid;
          reportsController.suppliername.text = element.toSupplierName;
          reportsController.selectedsuppliertId.value = element.toSuplierId;
          matreturnController.MatRetEntry_preparedbyController.text = element.createdName;
          matreturnController.MatRetEntry_RemarksController.text = element.remarks;
        });
      }

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
        key: formKey,
        child: SafeArea(top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.heading,
                              style: TextStyle(
                                  fontSize: RequestConstant.Heading_Font_SIZE,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
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
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: matreturnController.autoYearWiseNoController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Return No",
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '\u26A0 Enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: BaseUtitiles.getWidthtofPercentage(context, 35),
                              margin: EdgeInsets.only(top: 5, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: matreturnController.MatRetEntryDate,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                    onTap: () async {
                                      var Entrydate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor, // header background color
                                                onPrimary: Colors.white, // header text color
                                                onSurface: Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.black, // button text color
                                                ),
                                              ),
                                            ),
                                              child: child!,
                                            );
                                          });
                                      matreturnController.MatRetEntryDate.text = BaseUtitiles.selectDateFormat(Entrydate!);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '\u26A0 Enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: projectController.projectname,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText:"Project Name *",
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
                                if(matreturnController.isFromEdit.value==true){

                                }
                                else{
                                    await projectController.getProjectList();
                                    bottomsheetControllers.ProjectName(
                                        context,
                                        projectController
                                            .getdropDownvalue.value);
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
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: siteController.Sitename,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText:"Site Name",
                                labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), child: ConstIcons.siteName),
                              ),
                              onTap: () {
                                if(matreturnController.isFromEdit.value==true){

                                }
                                else{
                                    bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
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
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: reportsController.suppliername,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Supplier Name",
                                labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.subcontractorName),
                              ),
                              onTap: () async {
                                  if(matreturnController.isFromEdit.value==true){

                                  }
                               else {
                                    await reportsController.getSupplierReportList(type:"MatReturn");
                                    if(mounted) {
                                      bottomsheetControllers.supplierNameReport(context,
                                          reportsController.supplierListDropdown.value,type:"MatReturn");
                                    }
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
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: matreturnController.MatRetEntry_preparedbyController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.PREPARED_BY,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.preparedBy),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              controller: matreturnController.MatRetEntry_RemarksController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.REMARKS,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.remarks),
                              ),
                              onChanged: (value){
                              },
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),


              ],
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color:   Colors.white  ,
                        ),
                        alignment: Alignment.center,
                        child: Text("Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color:    Theme.of(context).primaryColor  ),
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
                        child: Text("NEXT",  style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                            color:   Colors.white  ),),
                      ),
                      onTap: () async {
                        if( projectController.selectedProjectId.value == 0){
                          BaseUtitiles.showToast("Please select projectName");
                        }else if(siteController.selectedsiteId.value == 0){
                          BaseUtitiles.showToast("Please select siteName");
                        }
                        else if(reportsController.selectedsuppliertId.value == 0){
                          BaseUtitiles.showToast("Please select supplierName");
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MaterialReturn_ItemList()));
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

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
                            matreturnController.isFromEdit.value=false;
                            matreturnController.GrnMaterialTabledelete();
                            matreturnController.grnMaterialReadList.value=[];
                            matreturnController.GRN_StockInNo_Controller.text="--SELECT--";
                            matreturnController.selectedGRN_Id.value="0";
                            matreturnController.saveButton.value = RequestConstant.SUBMIT;
                            projectController.projectname.text = "--SELECT--";
                            projectController.selectedProjectId.value=0;
                            siteController.Sitename.text = "--SELECT--";
                            siteController.selectedsiteId.value=0;
                            reportsController.suppliername.text = "--SELECT--";
                            reportsController.selectedsuppliertId.value=0;
                            matreturnController.MatRetEntryDate.text = BaseUtitiles.initiateCurrentDateFormat();
                            matreturnController.MatRetEntry_preparedbyController.text = loginController.EmpName();
                            matreturnController.MatRetEntry_RemarksController.text = "";
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

}
