import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../models/machinerydpr_model.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/common_date_fields.dart';
import '../../../utilities/requestconstant.dart';
import 'dart:async';

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
              body: Stack(
                  children: [
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
                                  dailyWrkDone_DPR_Controller.SubcontractorName(context, dailyWrkDone_DPR_Controller.dpr_subcontractorList.value,type: "machineryDPR" );
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
                    Obx(() => Visibility(
                      visible: machineryDPRController.macReqEtyDetList.value.isEmpty
                          ? false
                          : true,
                      child: SizedBox(
                        height:
                        BaseUtitiles.getheightofPercentage(context, 100),
                        child: DraggableScrollableSheet(
                          minChildSize: 0.1,
                          maxChildSize: 0.9,
                          initialChildSize: 0.3,
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Setmybackground,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.9,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            ListDetails(
                                                context,
                                                scrollController)
                                            // : ListDetails(context,
                                            //     scrollController),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            height: 5,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Colors.grey),
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
                    )),
              ])),
        ),
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
        SizedBox(
          height: MediaQuery.of(context).size.height * 75 / 100,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: machineryDPRController.macReqEtyDetList.value.length,
            itemBuilder: (BuildContext context, int index) {
              // machineryDPRController.textControllersInitiate();

              return MachineryDPRItemCard(
                context: context,
                item: machineryDPRController.macReqEtyDetList.value[index],
                onChanged: () {
                  machineryDPRController.macReqEtyDetList.refresh();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget MachineryDPRItemCard({
    required BuildContext context,
    required MachineryDPRDetLocal item,
    required VoidCallback onChanged,
  }) {
    double qty = item.enteredQty ?? 0.0;
    double startReading = item.startReading ?? 0.0;
    double endReading = item.endReading ?? 0.0;
    double totalReading = endReading - startReading;

    double amount = (item.rate ?? 0.0) * qty;

    String formatValue(double value) => value.toStringAsFixed(2);

    Widget readOnlyField(String value) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xffF3F1FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5,right: 3),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: item.itemDescription ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: " (${item.scaleName.toString().trim()})",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Rate (₹ ${item.rate ?? 0})",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Qty + Amount
            Container(
              margin: const EdgeInsets.only(top: 13, left: 5, right: 3),
              child: Row(
                children: [
                  // Qty Label
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: "Qty"),
                        ],
                      ),
                    ),
                  ),

                  // Qty Input
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(right: 11),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: DprInputField.numeric(
                        value: item.enteredQty ?? 0.0,
                        onChanged: (v) {
                          item.enteredQty = double.tryParse(v) ?? 0.0;
                          item.enteredAmount = (item.rate ?? 0.0) * item.enteredQty!;
                          onChanged();
                        },
                        onSave: () => machineryDPRController.saveItem(item),
                      ),
                    ),
                  ),

                  // Amount Label
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "Amount"),
                        ],
                      ),
                    ),
                  ),

                  // Amount
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      height: BaseUtitiles.getheightofPercentage(
                          context, 4),
                      alignment: Alignment.center,
                      child: readOnlyField(
                        "₹${amount.toStringAsFixed(2)}",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, right: 3),
              child: Row(
                children: [
                  // Start Reading Label
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "Start Reading"),
                        ],
                      ),
                    ),
                  ),

                  // Start Reading Input
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(right: 11),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: DprInputField.numeric(
                        value: item.startReading ?? 0.0,
                        onChanged: (v) {
                          item.startReading = double.tryParse(v) ?? 0.0;
                          item.totalReading = (item.endReading ?? 0.0) - (item.startReading ?? 0.0);
                          onChanged();
                        },
                        onSave: () => machineryDPRController.saveItem(item),
                      ),
                    ),
                  ),

                  // End Reading Label
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "End Reading"),
                        ],
                      ),
                    ),
                  ),

                  // End Reading Input
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: DprInputField.numeric(
                        value: item.endReading ?? 0.0,
                        onChanged: (v) {
                          item.endReading = double.tryParse(v) ?? 0.0;
                          item.totalReading = (item.endReading ?? 0.0) - (item.startReading ?? 0.0);
                          onChanged();
                        },
                        onSave: () => machineryDPRController.saveItem(item),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, right: 3, bottom: 8),
              child: Row(
                children: [
                  // Total Reading Label
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "Total Reading"),
                        ],
                      ),
                    ),
                  ),

                  // Total Reading Value
                  // Total Reading Value
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      alignment: Alignment.center,
                      child: readOnlyField(formatValue(totalReading)),
                    ),
                  ),

                  // Remarks Label
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "Remarks"),
                        ],
                      ),
                    ),
                  ),

                  // Remarks Input
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: DprInputField.text(
                        value: item.remarks ?? '',
                        onChanged: (v) {
                          item.remarks = v;
                          onChanged();
                        },
                        onSave: () => machineryDPRController.saveItem(item),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }

}

class DprInputField extends StatefulWidget {
  final double? numericValue;      // for numeric fields
  final String? textValue;         // for the remarks field
  final bool isNumeric;
  final ValueChanged<String> onChanged; // update model + refresh UI (immediate)
  final VoidCallback onSave;            // save to local DB (debounced)

  const DprInputField.numeric({
    super.key,
    required double value,
    required this.onChanged,
    required this.onSave,
  })  : numericValue = value,
        textValue = null,
        isNumeric = true;

  const DprInputField.text({
    super.key,
    required String value,
    required this.onChanged,
    required this.onSave,
  })  : textValue = value,
        numericValue = null,
        isNumeric = false;

  @override
  State<DprInputField> createState() => _DprInputFieldState();
}

class _DprInputFieldState extends State<DprInputField> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  bool _pendingSave = false;

  String get _initialText => widget.isNumeric
      ? (widget.numericValue ?? 0.0).toStringAsFixed(2)
      : (widget.textValue ?? '');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _initialText);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Clear if value is 0 / 0.0 / 0.00
        if (widget.isNumeric && (double.tryParse(_controller.text) ?? 0) == 0) {
          _controller.clear();
        }
      } else {
        // Lost focus: restore 0.00 if left empty, and flush pending save
        if (widget.isNumeric && _controller.text.trim().isEmpty) {
          _controller.text = '0.00';
          widget.onChanged('0');
        }
        _flushSave();
      }
    });
  }

  @override
  void didUpdateWidget(covariant DprInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync when value changes from outside (but never while the user is typing)
    if (!_focusNode.hasFocus && _controller.text != _initialText) {
      _controller.text = _initialText;
    }
  }

  void _scheduleSave() {
    _pendingSave = true;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _flushSave);
  }

  void _flushSave() {
    _debounce?.cancel();
    if (_pendingSave) {
      _pendingSave = false;
      widget.onSave();
    }
  }

  @override
  void dispose() {
    _flushSave(); // make sure nothing is lost when the card is removed
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      cursorColor: Colors.black,
      keyboardType: widget.isNumeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.name,
      inputFormatters: widget.isNumeric
          ? [
        TextInputFormatter.withFunction((oldValue, newValue) =>
        RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
            ? newValue
            : oldValue),
      ]
          : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        focusedBorder: border,
        enabledBorder: border,
      ),
      onChanged: (value) {
        widget.onChanged(value);
        _scheduleSave();
      },
    );
  }
}