import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/auto_yrwise_no_controller.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/machinery_dpr_controller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../controller/subcontcontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/common_date_fields.dart';
import '../../../utilities/requestconstant.dart';

class MachineryDPREntry extends StatefulWidget {
  final String heading;
  const MachineryDPREntry({Key? key,required this.heading}) : super(key: key);

  @override
  State<MachineryDPREntry> createState() => _MachineryDPREntryState();
}

class _MachineryDPREntryState extends State<MachineryDPREntry> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MachineryDPRController machineryDPRController = Get.put(MachineryDPRController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  LoginController loginController = Get.put(LoginController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (machineryDPRController.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("MACHINERY DPR");
        machineryDPRController.autoYearWiseNoController.text = autoYearWiseNoController.MachineryDPR_autoYrWise.value;
        machineryDPRController.requestDateController.text =
            CommonDateUtils.formatApiDate(DateTime.now());
        machineryDPRController.reqId = 0;
        machineryDPRController.refNoController.text = "";
        machineryDPRController.remarksController.text = "";
        machineryDPRController.preparedByController.text = loginController.EmpName();
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.selectedsiteId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;

        // machineryIndentController.preparedByController.text =
        //     loginController.EmpName();
        // machineryIndentController.reqTypeController.text = "Machinery Items";
        // machineryIndentController.reqType.value = "M";
        // bottomsheetControllers.searchcontroller.text = "";
      }

      // else {
      //   for (var element in machineryIndentController
      //       .machineryEditListApiValue) {
      //     machineryIndentController.reqId = element.id;
      //     machineryIndentController.autoYearWiseNoController.text =
      //         element.reqOrdNo;
      //     machineryIndentController.requestDateController.text =
      //         element.reqOrdDate;
      //     machineryIndentController.dueDateController.text = element.reqDueDate;
      //     projectController.selectedProjectId.value = element.projectId;
      //     siteController.selectedsiteId.value = element.siteId;
      //     projectController.projectname.text = element.projectName;
      //     siteController.Sitename.text = element.siteName;
      //     machineryIndentController.preparedByController.text =
      //         element.createdByName;
      //     machineryIndentController.reqTypeController.text =
      //     element.requestType.toString().trim() == "M"
      //         ? "Machinery Items"
      //         : "-";
      //     machineryIndentController.reqType.value =
      //         element.requestType.toString();
      //     machineryIndentController.remarksController.text = element.reqRemarks;
      //   }
      // }

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
                    // Visibility(
                    //   visible:machineryIndentController.saveButton.value !=
                    //       RequestConstant.APPROVAL
                    //       && machineryIndentController.saveButton.value !=
                    //           RequestConstant.PREAPPROVAL
                    //       &&
                    //       machineryIndentController.saveButton.value !=
                    //           RequestConstant.VERIFY
                    //       && machineryIndentController.saveButton.value !=
                    //           RequestConstant.RESUBMIT
                    //       ? true
                    //       : false,
                    //   child: Expanded(
                    //     child: InkWell(
                    //       child: Container(
                    //         margin: const EdgeInsets.only(left: 20, right: 20),
                    //         height:
                    //         BaseUtitiles.getheightofPercentage(context, 4),
                    //         decoration: BoxDecoration(
                    //           borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //           color: Colors.white,
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: Text(
                    //           "Reset",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: RequestConstant.Lable_Font_SIZE,
                    //               color: Theme
                    //                   .of(context)
                    //                   .primaryColor
                    //           ),
                    //         ),
                    //       ),
                    //       onTap: () {
                    //         setState(() {
                    //           ResetAlert(context);
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: InkWell(
                    //     child: Container(
                    //         margin: const EdgeInsets.only(left: 20, right: 20),
                    //         height:
                    //         BaseUtitiles.getheightofPercentage(context, 4),
                    //         decoration: BoxDecoration(
                    //             borderRadius:
                    //             const BorderRadius.all(Radius.circular(10)),
                    //             color: Theme
                    //                 .of(context)
                    //                 .primaryColor
                    //
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: Obx(() =>
                    //             Text(
                    //               machineryIndentController.saveButton.value,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: RequestConstant.Lable_Font_SIZE,
                    //                   color: Colors.white
                    //               ),
                    //             ))),
                    //     onTap: () async {
                    //       if (_formKey.currentState!.validate()) {
                    //         _formKey.currentState!.save();
                    //
                    //         if (mrn_request_controller
                    //             .Material_itemview_GetDbList
                    //             .isEmpty) {
                    //           BaseUtitiles.showToast(
                    //             "Please select items",
                    //           );
                    //           return;
                    //         }
                    //
                    //         bool hasInvalid = false;
                    //         for (int i = 0; i < mrn_request_controller
                    //             .Material_itemview_GetDbList.length; i++) {
                    //           final controller = mrn_request_controller
                    //               .Addwork_qtyControllers[i];
                    //           final text = controller.text.trim();
                    //
                    //           if (text.isEmpty) {
                    //             hasInvalid = true;
                    //             break;
                    //           }
                    //
                    //           final value = double.tryParse(text);
                    //           if (value == null || value <= 0) {
                    //             hasInvalid = true;
                    //             break;
                    //           }
                    //         }
                    //         if (hasInvalid) {
                    //           BaseUtitiles.showToast(
                    //               "Qty Should Not be Zero or Empty");
                    //         } else {
                    //           SubmitAlert(context);
                    //         }
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              body: Stack(children: [
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
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
                              controller: machineryDPRController
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
                          title: "Entry Date",
                          value: machineryDPRController.requestDateController
                              .text,
                          controller: machineryDPRController
                              .requestDateController,
                          selectable: true,
                          initialDate: DateTime.tryParse(
                            machineryDPRController.requestDateController
                                .text,
                          ) ??
                              DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          onChanged: (date) {
                            setState(() {
                              machineryDPRController.requestDateController
                                  .text =
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
                              readOnly: false,
                              controller:
                              machineryDPRController.refNoController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Ref No",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.nos),
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
                                if (machineryDPRController.saveButton.value == RequestConstant.SUBMIT) {
                                  await projectController.getProjectList();

                                  await bottomsheetControllers.ProjectName(
                                    context,
                                    projectController.getdropDownvalue.value,
                                  );
                                }
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
                                if (machineryDPRController.saveButton.value == RequestConstant.SUBMIT) {
                                  await bottomsheetControllers.SiteName(
                                    context,
                                    siteController.getSiteDropdownvalue.value,
                                  );
                                }
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: dailyWrkDone_DPR_Controller.TypeSubcontractorname,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.SUBCONTRACTOR_NAME,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.subcontractorName),
                              ),
                              onTap: () async {
                                if (machineryDPRController.saveButton.value == RequestConstant.SUBMIT) {
                                  await dailyWrkDone_DPR_Controller.dpr_getSubcotType(type: "machineryDPR");
                                  dailyWrkDone_DPR_Controller.SubcontractorName(context, dailyWrkDone_DPR_Controller.dpr_subcontractorList.value);}

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
                              machineryDPRController.preparedByController,
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
                              machineryDPRController.remarksController,
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
                      SizedBox(height: height),
                    ],
                  ),
                ),


              ])),
        ),
      ),
    );
  }

}