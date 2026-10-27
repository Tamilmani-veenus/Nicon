import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/supplier_bill_approval_controller.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/supplier_bill_approval_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/common_date_fields.dart';
import '../../../../utilities/requestconstant.dart';

class SupplierBillEntry extends StatefulWidget {
  final String heading;
  const SupplierBillEntry({Key? key,required this.heading}) : super(key: key);

  @override
  State<SupplierBillEntry> createState() => _SupplierBillEntryState();
}

class _SupplierBillEntryState extends State<SupplierBillEntry> {

  SupplierBillApprovalController supplierBillApprovalController = Get.put(SupplierBillApprovalController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SupplierBillApprovalController supplierBillApprovalController = Get.put(SupplierBillApprovalController());

  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      final result = supplierBillApprovalController.suppBillAppEditListValue[0].result;
      supplierBillApprovalController.reqId = result.id;
      supplierBillApprovalController.autoYearWiseNoController.text = result.billNo;
      supplierBillApprovalController.RequestDateController.text = result.entrydate;
      supplierBillApprovalController.billingTypeController.text = result.billType == "C" ? "Company" : "Client";


      // mrn_request_controller.DuedateController.text = element.reqDueDate;
          // projectController.selectedProjectId.value = element.projectId;
          // siteController.selectedsiteId.value = element.siteId;
          // projectController.projectname.text = element.projectName;
          // siteController.Sitename.text = element.siteName;
          // mrn_request_controller.preparedbyController.text = element.preparedbyName;
          // mrn_request_controller.ReqTypeController.text = element.purchaseType=="PO"?"General Items":"Asset Materials";
          // mrn_request_controller.ReqType.value = element.purchaseVal.toString();
          // mrn_request_controller.RemarksController.text = element.reqRemarks;


      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
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
                    //   visible:
                    //   mrn_request_controller.saveButton.value != RequestConstant.VERIFY || mrn_request_controller.saveButton.value != RequestConstant.RESUBMIT
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
                    //               color: Theme.of(context).primaryColor
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
                    //             color: Theme.of(context).primaryColor
                    //
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: Obx(() => Text(
                    //           mrn_request_controller.saveButton.value,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: RequestConstant.Lable_Font_SIZE,
                    //               color: Colors.white
                    //           ),
                    //         ))),
                    //     onTap: () async {
                    //       if (_formKey.currentState!.validate()) {
                    //         _formKey.currentState!.save();
                    //         if (mrn_request_controller
                    //             .Material_itemview_GetDbList.value.isEmpty) {
                    //           BaseUtitiles.showToast("Please select item list");
                    //         } else if (mrn_request_controller.ReqType.value ==
                    //             "0") {
                    //           Fluttertoast.showToast(
                    //               msg: "Please select request type");
                    //         } else {
                    //           bool hasInvalid = false;
                    //           for (int i = 0; i < mrn_request_controller.Material_itemview_GetDbList.length; i++) {
                    //             final controller = mrn_request_controller.Addwork_qtyControllers[i];
                    //             final text = controller.text.trim();
                    //
                    //             if (text.isEmpty) {
                    //               hasInvalid = true;
                    //               break;
                    //             }
                    //
                    //             final value = double.tryParse(text);
                    //             if (value == null || value <= 0) {
                    //               hasInvalid = true;
                    //               break;
                    //             }
                    //           }
                    //           if (hasInvalid) {
                    //             BaseUtitiles.showToast("Qty Should Not be Zero or Empty");
                    //           } else {
                    //             SubmitAlert(context);
                    //           }
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
                  physics: const BouncingScrollPhysics(),
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
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                              controller: supplierBillApprovalController
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
                          value: supplierBillApprovalController.RequestDateController.text,
                          controller: supplierBillApprovalController.RequestDateController,
                          selectable: false,
                          initialDate: DateTime.tryParse(supplierBillApprovalController.RequestDateController.text) ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
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
                              supplierBillApprovalController.billingTypeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Billing Type",
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
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              // dailyEntriesController.textControllersInitiate();
              return SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  // margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, right: 25),
                              child: Text(
                                'Material Name',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin:
                        const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: "PO BalQty",
                                      ),
                                      TextSpan(
                                        text:  "",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      style:
                                      const TextStyle(color: Colors.black),
                                      // controller: dailyEntriesController
                                      //     .EntrySCreenNosControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: Platform.isAndroid
                                          ? TextInputType.numberWithOptions(
                                          decimal: true)
                                          : TextInputType.text,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return RegExp(r'^\d*\.?\d{0,2}$')
                                                  .hasMatch(newValue.text)
                                                  ? newValue
                                                  : oldValue;
                                            }),
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                      )),
                                )),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Bill Qty",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(

                                      style:
                                      const TextStyle(color: Colors.black),
                                      // controller: dailyEntriesController
                                      //     .ExtrasControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: Platform.isAndroid
                                          ? TextInputType.numberWithOptions(
                                          decimal: true)
                                          : TextInputType.text,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return RegExp(r'^\d*\.?\d{0,2}$')
                                                  .hasMatch(newValue.text)
                                                  ? newValue
                                                  : oldValue;
                                            }),
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "PO Rate",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      style:
                                      const TextStyle(color: Colors.black),
                                      // controller: dailyEntriesController
                                      //     .MrngOtHrsControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: Platform.isAndroid
                                          ? TextInputType.numberWithOptions(
                                          decimal: true)
                                          : TextInputType.text,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return RegExp(r'^\d*\.?\d{0,2}$')
                                                  .hasMatch(newValue.text)
                                                  ? newValue
                                                  : oldValue;
                                            }),
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      ),
                                )),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Rate",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                      readOnly: true,
                                      style:
                                      const TextStyle(color: Colors.black),
                                      // controller: dailyEntriesController
                                      //     .MrngOtAmtControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: Platform.isAndroid
                                          ? TextInputType.numberWithOptions(
                                          decimal: true)
                                          : TextInputType.text,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return RegExp(r'^\d*\.?\d{0,2}$')
                                                  .hasMatch(newValue.text)
                                                  ? newValue
                                                  : oldValue;
                                            }),
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                     )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Amount",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(

                                      // controller: dailyEntriesController
                                      //     .EvgOtHrsControllers[index],
                                      style:
                                      const TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: Platform.isAndroid
                                          ? TextInputType.numberWithOptions(
                                          decimal: true)
                                          : TextInputType.text,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return RegExp(r'^\d*\.?\d{0,2}$')
                                                  .hasMatch(newValue.text)
                                                  ? newValue
                                                  : oldValue;
                                            }),
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                     ),
                                )),
                          ],
                        ),
                      ),

                      // Container(
                      //   margin: const EdgeInsets.only(
                      //       top: 10, left: 5, right: 3, bottom: 8),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Expanded(
                      //         flex: 2,
                      //         child: RichText(
                      //           text: const TextSpan(
                      //               style: TextStyle(
                      //                 fontSize: 12.0,
                      //                 fontWeight: FontWeight.normal,
                      //                 color: Colors.black,
                      //               ),
                      //               children: <TextSpan>[
                      //                 TextSpan(
                      //                   text: "Remarks",
                      //                 ),
                      //                 TextSpan(
                      //                   text: "",
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 12.0,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ]),
                      //         ),
                      //
                      //         // Text(
                      //         //   "Remarks",
                      //         //   style: TextStyle(color: Colors.black),
                      //         // ),
                      //       ),
                      //       Expanded(
                      //           flex: 10,
                      //           child: Container(
                      //             margin: const EdgeInsets.only(left: 0),
                      //             height: BaseUtitiles.getheightofPercentage(
                      //                 context, 4),
                      //             child: TextFormField(
                      //               onTap: () {
                      //                 dailyEntriesController
                      //                     .RemarksControllers[index].text = "";
                      //               },
                      //               textAlign: TextAlign.center,
                      //               controller: dailyEntriesController
                      //                   .RemarksControllers[index],
                      //               style: const TextStyle(color: Colors.black),
                      //               cursorColor: Colors.black,
                      //               keyboardType: TextInputType.name,
                      //               decoration: InputDecoration(
                      //                 contentPadding: const EdgeInsets.fromLTRB(
                      //                     8.0, 0.0, 8.0, 0.0),
                      //                 focusedBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                         color: Theme.of(context)
                      //                             .primaryColor),
                      //                     borderRadius: const BorderRadius.all(
                      //                         Radius.circular(10))),
                      //                 enabledBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                         color: Theme.of(context)
                      //                             .primaryColor),
                      //                     borderRadius: const BorderRadius.all(
                      //                         Radius.circular(10))),
                      //               ),
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   dailyEntriesController
                      //                       .updateSubcontDetValue();
                      //                 });
                      //               },
                      //             ),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
      ],
    );
  }
}
