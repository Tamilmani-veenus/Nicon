import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/auto_yrwise_no_controller.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/machinery_bill_generation_controller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../controller/subcontcontroller.dart';
import '../../../models/machineryBill_model.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/common_date_fields.dart';
import '../../../utilities/requestconstant.dart';
import 'machinery_bill_calculations.dart';
import 'machinery_dpr_entry.dart';

class MachineryBillEntry extends StatefulWidget {
  final String heading;
  const MachineryBillEntry({Key? key,required this.heading}) : super(key: key);

  @override
  State<MachineryBillEntry> createState() => _MachineryBillEntryState();
}

class _MachineryBillEntryState extends State<MachineryBillEntry> {
  MachineryBillGenController machineryBillGenController = Get.put(MachineryBillGenController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  LoginController loginController = Get.put(LoginController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (machineryBillGenController.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("MACHINERY BILL");
        machineryBillGenController.autoYearWiseNoController.text = autoYearWiseNoController.MachineryBill_autoYrWise.value;
        machineryBillGenController.requestDateController.text = CommonDateUtils.formatApiDate(DateTime.now());
        machineryBillGenController.paymentWKDateController.text = CommonDateUtils.formatApiDate(DateTime.now());
        machineryBillGenController.remarksController.text = "";
        machineryBillGenController.preparedByController.text = loginController.EmpName();
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.selectedsiteId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
        machineryBillGenController.wrkOrderNoController.text = "--SELECT--";
        machineryBillGenController.workOrderId.value = 0;
      }

      // else {
      //   for (var result in machineryDPRController.macReqEditList) {
      //     machineryDPRController.reqId = result['id'] ?? 0;
      //     machineryDPRController.autoYearWiseNoController.text =
      //         (result['workNo'] ?? "").toString();
      //
      //     machineryDPRController.requestDateController.text =
      //         (result['workDate'] ?? "").toString();
      //
      //     machineryDPRController.refNoController.text =
      //         (result['refNo'] ?? "").toString();
      //
      //     machineryDPRController.remarksController.text =
      //         (result['remarks'] ?? "").toString();
      //
      //     machineryDPRController.preparedByController.text =
      //         (result['createdName'] ?? loginController.EmpName()).toString();
      //
      //     projectController.projectname.text =
      //         (result['projectName'] ?? "--SELECT--").toString();
      //     projectController.selectedProjectId.value = result['projectId'] ?? 0;
      //
      //     siteController.Sitename.text =
      //         (result['siteName'] ?? "--SELECT--").toString();
      //     siteController.selectedsiteId.value = result['siteId'] ?? 0;
      //
      //     dailyWrkDone_DPR_Controller.TypeSubcontractorname.text =
      //         (result['subcontractorName'] ?? "--SELECT--").toString();
      //     dailyWrkDone_DPR_Controller.TypeSubcontId.value =
      //         result['subContractorId'] ?? 0;
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
                    if(machineryBillGenController.saveButton.value == RequestConstant.SUBMIT) Expanded(
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
                          ResetAlert(context);
                        },
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
                            child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.Lable_Font_SIZE,
                                      color: Colors.white
                                  ),
                                )),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MachineryBillCalculations()));
                        },
                      ),
                    ),
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
                                  controller: machineryBillGenController
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
                              value: machineryBillGenController.requestDateController
                                  .text,
                              controller: machineryBillGenController
                                  .requestDateController,
                              selectable:  machineryBillGenController.saveButton.value == RequestConstant.SUBMIT,
                              initialDate: DateTime.tryParse(
                                machineryBillGenController.requestDateController
                                    .text,
                              ) ??
                                  DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              onChanged: (date) {
                                setState(() {
                                  machineryBillGenController.requestDateController
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
                                    if (machineryBillGenController.saveButton.value == RequestConstant.SUBMIT) {
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
                                    if (machineryBillGenController.saveButton.value == RequestConstant.SUBMIT) {
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
                                    if (machineryBillGenController.saveButton.value == RequestConstant.SUBMIT) {
                                      await dailyWrkDone_DPR_Controller.dpr_getSubcotType(type: "machineryDPR");
                                      dailyWrkDone_DPR_Controller.SubcontractorName(context, dailyWrkDone_DPR_Controller.dpr_subcontractorList.value);
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
                          CommonDateFields(
                            date1: CommonDateFieldConfig(
                              title: "Payment Wk Date",
                              value: machineryBillGenController.paymentWKDateController
                                  .text,
                              controller: machineryBillGenController
                                  .paymentWKDateController,
                              selectable:  machineryBillGenController.saveButton.value == RequestConstant.SUBMIT,
                              initialDate: DateTime.tryParse(
                                machineryBillGenController.paymentWKDateController
                                    .text,
                              ) ??
                                  DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              onChanged: (date) {
                                setState(() {
                                  machineryBillGenController.paymentWKDateController
                                      .text =
                                      CommonDateUtils.formatApiDate(date);
                                });
                              },
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
                                  controller: machineryBillGenController.wrkOrderNoController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: 'Work Order No',
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.dcNo),
                                  ),
                                  onTap: ()  async {
                                      await machineryBillGenController.getWorkOrderNoList(
                                          projectController.selectedProjectId.value,
                                          siteController.selectedsiteId.value,
                                          dailyWrkDone_DPR_Controller.TypeSubcontId.value);
                                      bottomsheetControllers.WorkOrderName(context,
                                        machineryBillGenController.getdpDnWrkOrderValue.value,type: "MachineryBill",
                                          );
                                  },
                                  validator: (value)
                                  {
                                    if(value == "--SELECT--" || value == "--Select--")
                                    {
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
                                  machineryBillGenController.preparedByController,
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
                                  machineryBillGenController.remarksController,
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
                      visible: machineryBillGenController.getMacBillDetValue.value.isEmpty
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
                                            MachineryBillListDetails(
                                                context,
                                                scrollController)
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

  Widget MachineryBillItemCard({
    required BuildContext context,
    required MachineryBillDetLocal item,
    required VoidCallback onChanged,
  }) {
    double qty = item.qty ?? 0.0;
    double rate = item.rate ?? 0.0;
    double amount = rate * qty;

    String formatValue(double value) => value.toStringAsFixed(2);

    Widget readOnlyField(String value, {Color? fillColor}) {
      return Container(
        width: double.infinity,
        height: BaseUtitiles.getheightofPercentage(context, 4),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: fillColor ?? const Color(0xffF3F1FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.1))
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
    Widget readingRow(String label, double? value) {
      return Container(
        margin: const EdgeInsets.only(
            top: 5, left: 5, right: 3, bottom: 5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: readOnlyField(formatValue(value ?? 0.0)),
            ),
          ],
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
          children: [
            // Item Description + Unit + Rate
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: item.itemDiscription ?? '',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: " (${item.unit.toString().trim()})",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Rate (₹ ${formatValue(rate)})",
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
              margin: const EdgeInsets.only(
                  top: 13, left: 5, right: 3, bottom: 8),
              child: Row(
                children: [
                  // Qty Label
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Qty",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Qty Input
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(right: 11),
                      height: BaseUtitiles.getheightofPercentage(
                          context, 4),
                      child: DprInputField.numeric(
                        value: item.qty ?? 0.0,
                        onChanged: (v) {
                          item.qty = double.tryParse(v) ?? 0.0;

                          item.amt = (item.rate ?? 0.0) * item.qty!;

                          onChanged();
                        },
                        onSave: () {
                          machineryBillGenController
                              .saveMachineryBillItem(item);
                        },
                      ),
                    ),
                  ),

                  // Amount Label
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Amount Read Only
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      height: BaseUtitiles.getheightofPercentage(
                          context, 4),
                      alignment: Alignment.center,
                      child: readOnlyField(formatValue(amount)),
                    ),
                  ),
                ],
              ),
            ),

            // Start Reading
            // Start Reading + End Reading
            Container(
              margin: const EdgeInsets.only(
                  top: 5, left: 5, right: 3, bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Start Reading",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(right: 11),
                      child: readOnlyField(
                          formatValue(item.startReading ?? 0.0)),
                    ),
                  ),

                  const Expanded(
                    flex: 2,
                    child: Text(
                      "End Reading",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: readOnlyField(
                          formatValue(item.endReading ?? 0.0)),
                    ),
                  ),
                ],
              ),
            ),

            readingRow("Total Reading", item.totalReading),

          ],
        ),
      ),
    );
  }

  Widget MachineryBillListDetails(
      BuildContext context, ScrollController scrollController) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 5 / 100,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 75 / 100,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount:
            machineryBillGenController.getMacBillDetValue.length,
            itemBuilder: (BuildContext context, int index) {
              return MachineryBillItemCard(
                context: context,
                item: machineryBillGenController
                    .getMacBillDetValue[index],
                onChanged: () {
                  machineryBillGenController.getMacBillDetValue.refresh();
                },
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
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
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
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await machineryBillGenController.resetForm();
                          Navigator.pop(context);
                        },
                        child: Text("Reset",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
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
