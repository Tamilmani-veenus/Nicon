import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/auto_yrwise_no_controller.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/machinery_indent_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../controller/subcontcontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/common_date_fields.dart';
import '../../../utilities/requestconstant.dart';

class MachineryIndentEntry extends StatefulWidget {
  final String heading;
  const MachineryIndentEntry({Key? key,required this.heading}) : super(key: key);

  @override
  State<MachineryIndentEntry> createState() => _MachineryIndentEntryState();
}

class _MachineryIndentEntryState extends State<MachineryIndentEntry> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MachineryIndentController machineryIndentController = Get.put(
      MachineryIndentController());
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(
      SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(
      AutoYearWiseNoController());
  MRN_Request_Controller mrn_request_controller = Get.put(
      MRN_Request_Controller());
  BottomsheetControllers bottomsheetControllers = Get.put(
      BottomsheetControllers());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (machineryIndentController.saveButton.value ==
          RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("MACHINERY INDENT");
        machineryIndentController.autoYearWiseNoController.text =
            autoYearWiseNoController.MachineryIndent_autoYrsWise.value;
        machineryIndentController.requestDateController.text =
            CommonDateUtils.formatApiDate(DateTime.now());
        machineryIndentController.dueDateController.text =
            CommonDateUtils.formatApiDate(DateTime.now());
        machineryIndentController.reqId = 0;
        mrn_request_controller.delete_MaterialIntent_itemlist_Table();
        mrn_request_controller.Material_itemview_GetDbList.clear();
        machineryIndentController.remarksController.text = "";
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.selectedsiteId = 0.obs;
        siteController.Sitename.text = RequestConstant.SELECT;
        machineryIndentController.preparedByController.text =
            loginController.EmpName();
        machineryIndentController.reqTypeController.text = "Machinery Items";
        machineryIndentController.reqType.value = "M";
        bottomsheetControllers.searchcontroller.text = "";
      }

      else {
        for (var element in machineryIndentController
            .machineryEditListApiValue) {
          machineryIndentController.reqId = element.id;
          machineryIndentController.autoYearWiseNoController.text =
              element.reqOrdNo;
          machineryIndentController.requestDateController.text =
              element.reqOrdDate;
          machineryIndentController.dueDateController.text = element.reqDueDate;
          projectController.selectedProjectId.value = element.projectId;
          siteController.selectedsiteId.value = element.siteId;
          projectController.projectname.text = element.projectName;
          siteController.Sitename.text = element.siteName;
          machineryIndentController.preparedByController.text =
              element.createdByName;
          machineryIndentController.reqTypeController.text =
          element.requestType.toString().trim() == "M"
              ? "Machinery Items"
              : "-";
          machineryIndentController.reqType.value =
              element.requestType.toString();
          machineryIndentController.remarksController.text = element.reqRemarks;
        }
      }

      if (!mounted) return;

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width * 100 / 100;
    final double height = MediaQuery
        .of(context)
        .size
        .height * 50 / 100;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
              backgroundColor: Setmybackground,
              bottomNavigationBar: Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      visible:
                      machineryIndentController.saveButton.value !=
                          RequestConstant.VERIFY
                          || machineryIndentController.saveButton.value !=
                          RequestConstant.RESUBMIT
                          ? true
                          : false,
                      child: Expanded(
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height:
                            BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              ResetAlert(context);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height:
                            BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                color: Theme
                                    .of(context)
                                    .primaryColor

                            ),
                            alignment: Alignment.center,
                            child: Obx(() =>
                                Text(
                                  machineryIndentController.saveButton.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.Lable_Font_SIZE,
                                      color: Colors.white
                                  ),
                                ))),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            if (mrn_request_controller
                                .Material_itemview_GetDbList
                                .isEmpty) {
                              BaseUtitiles.showToast(
                                "Please select items",
                              );
                              return;
                            }

                            bool hasInvalid = false;
                            for (int i = 0; i < mrn_request_controller
                                .Material_itemview_GetDbList.length; i++) {
                              final controller = mrn_request_controller
                                  .Addwork_qtyControllers[i];
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
                              BaseUtitiles.showToast(
                                  "Qty Should Not be Zero or Empty");
                            } else {
                              SubmitAlert(context);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              body: Stack(children: [
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                          height:
                          BaseUtitiles.getheightofPercentage(context, 5)),
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
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(
                            top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: machineryIndentController
                                  .autoYearWiseNoController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request No",
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

                      CommonDateFields(
                        date1: CommonDateFieldConfig(
                          title: "Request Date",
                          value: machineryIndentController.requestDateController
                              .text,
                          controller: machineryIndentController
                              .requestDateController,
                          selectable: true,
                          initialDate: DateTime.tryParse(
                            machineryIndentController.requestDateController
                                .text,
                          ) ??
                              DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          onChanged: (date) {
                            setState(() {
                              machineryIndentController.requestDateController
                                  .text =
                                  CommonDateUtils.formatApiDate(date);
                            });
                          },
                        ),

                        date2: CommonDateFieldConfig(
                          title: "Due Date",
                          value: machineryIndentController.dueDateController
                              .text,
                          controller: machineryIndentController
                              .dueDateController,
                          selectable: true,
                          initialDate: DateTime.tryParse(
                              machineryIndentController.dueDateController
                                  .text) ??
                              DateTime.now(),
                          firstDate: DateTime.tryParse(
                              machineryIndentController.requestDateController
                                  .text) ??
                              DateTime.now(),
                          lastDate: DateTime(2100),
                          onChanged: (date) {
                            setState(() {
                              machineryIndentController.dueDateController.text =
                                  CommonDateUtils.formatApiDate(date);
                            });
                          },
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode:
                              AutovalidateMode.always,
                              readOnly: true,
                              controller:
                              machineryIndentController
                                  .reqTypeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request Type",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                ),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.types,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode:
                              AutovalidateMode.always,
                              readOnly: true,
                              controller: projectController.projectname,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Project Name",
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
                                if (machineryIndentController.saveButton
                                    .value ==
                                    RequestConstant.VERIFY ||
                                    mrn_request_controller
                                        .Material_itemview_GetDbList
                                        .isNotEmpty) {
                                  return;
                                }
                                await projectController.getProjectList();

                                await bottomsheetControllers.ProjectName(
                                  context,
                                  projectController.getdropDownvalue.value,
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode:
                              AutovalidateMode.always,
                              readOnly: true,
                              controller: siteController.Sitename,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Site Name",
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
                              onTap: () async {
                                if (machineryIndentController.saveButton
                                    .value ==
                                    RequestConstant.VERIFY ||
                                    mrn_request_controller
                                        .Material_itemview_GetDbList
                                        .value
                                        .isNotEmpty) {
                                  return;
                                }

                                await bottomsheetControllers.SiteName(
                                  context,
                                  siteController.getSiteDropdownvalue.value,
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                              machineryIndentController.preparedByController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Prepared By",
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
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin:
                        const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode:
                              AutovalidateMode.always,
                              readOnly: false,
                              controller:
                              machineryIndentController.remarksController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Remarks",
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                          BaseUtitiles.getheightofPercentage(context, 1)),
                      Visibility(
                        visible: machineryIndentController.saveButton.value !=
                            RequestConstant.VERIFY,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    mrn_request_controller.getMaterialList(
                                        context,
                                        machineryIndentController.reqType.value
                                            .toString(),
                                        projectController.selectedProjectId
                                            .value,
                                        siteController.selectedsiteId.value,
                                        type: "machineryIndent"
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text("Add Materials",
                                        style: TextStyle(
                                            color:
                                            Theme
                                                .of(context)
                                                .primaryColor)),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height),
                    ],
                  ),
                ),
                // Obx(
                //       () => MaterialsBottomSheetNew(
                //     isVisible: mrn_request_controller
                //         .Material_itemview_GetDbList
                //         .value
                //         .isNotEmpty,
                //
                //     childBuilder: (
                //         context,
                //         scrollController,
                //         ) {
                //       final list = mrn_request_controller.Material_itemview_GetDbList.value;
                //
                //       return ListView.builder(
                //         controller: scrollController,
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         padding: const EdgeInsets.all(10),
                //         itemCount: list.length,
                //
                //         itemBuilder: (context, index) {
                //           final item = list[index];
                //           mrn_request_controller
                //               .Material_itemlist_textControllersInitiate();
                //           return MaterialCard(
                //             title:
                //             "${item.material}",
                //             mrnshowBalQty: false,
                //             showDelete: machineryIndentController.saveButton.value != RequestConstant.VERIFY
                //                 ? true:false,
                //             onDelete: () async {
                //               final confirmed = await AppAlertDialog.showAction(context, AlertAction.remove);
                //
                //               if (confirmed == true) {
                //                 mrn_request_controller.deleteParticularList(mrn_request_controller.Material_itemview_GetDbList[index]);
                //                 mrn_request_controller.Material_itemview_GetDbList.remove(mrn_request_controller.Material_itemview_GetDbList[index]);
                //                 mrn_request_controller.getMaterialTablesDatas();
                //               }
                //             },
                //
                //             children: [
                //               MaterialFieldRow(
                //                 bottomSpacing: 8,
                //                 left: CommonMaterialField(
                //                   label: "Unit",
                //                   type: MaterialFieldType.staticValue,
                //                   value: item.scale.toString(),
                //                   horizontal: true,
                //                 ),
                //                 right: CommonMaterialField(
                //                   label: "Quantity",
                //                   controller: mrn_request_controller.Addwork_qtyControllers[index],
                //                   type: MaterialFieldType.editable,
                //                   horizontal: true,
                //                   keyboardType: Platform.isAndroid
                //                       ? const TextInputType.numberWithOptions(decimal: true)
                //                       : TextInputType.text,
                //                   inputFormatters: [
                //                     TextInputFormatter.withFunction(
                //                           (oldValue, newValue) {
                //                         return RegExp(r'^\d*\.?\d{0,2}$')
                //                             .hasMatch(newValue.text)
                //                             ? newValue
                //                             : oldValue;
                //                       },
                //                     ),
                //                   ],
                //                   onTap: () {
                //                     if (mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0") {
                //                       return;
                //                     } else {
                //                       mrn_request_controller.Addwork_qtyControllers[index].text = "";
                //                     }
                //                   },
                //                   onChanged: (value) {
                //                     if(mrn_request_controller.activeType.value){
                //                       mrn_request_controller.MaterialItemlistBal_clickEdit(index);
                //                     }
                //                     else{
                //                       mrn_request_controller.updateConsumTables();
                //                     }
                //                   },
                //                 ),
                //               ),
                //               MaterialFieldRow(
                //                 bottomSpacing: 8,
                //                 left: CommonMaterialField(
                //                   label: "Desc",
                //                   type: MaterialFieldType.editable,
                //                   value: mrn_request_controller
                //                       .Addwork_descControllers[index].toString(),
                //                   controller: mrn_request_controller
                //                       .Addwork_descControllers[index],
                //                   horizontal: true,
                //                   onChanged: (val) {
                //                     mrn_request_controller
                //                         .MaterialItemlist_clickEdit();
                //                   },
                //                 ),
                //               ),
                //               CommonMaterialField(
                //                 label: "Remarks",
                //                 controller: mrn_request_controller
                //                     .Addwork_remarksControllers[index],
                //                 type: MaterialFieldType.editable,
                //                 horizontal: true,
                //                 onChanged: (val) {
                //                   mrn_request_controller
                //                       .MaterialItemlist_clickEdit();
                //                 },
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
              ])),
        ),
      ),
    );
  }


  Future<void> ResetAlert(BuildContext context) async {
    // final confirmed = await AppAlertDialog.showAction(context, AlertAction.reset);
    //
    // if (confirmed != true) return;


  }

  Future<void> SubmitAlert(context) async {
    //   final confirmed = await AppAlertDialog.showForLabel(context, machineryIndentController.saveButton.value);
    //
    //   if (confirmed != true) return;
    //
    //   if (await BaseUtitiles.checkNetworkAndShowLoader(
    //       context)) {
    //     await mrn_request_controller
    //         .getMaterialTablesDatas();
    //     await machineryIndentController
    //         .SaveMachineryIntentScreen(
    //       context,
    //       machineryIndentController.reqId,
    //     );
    //   }
    // }
  }
}