import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/supplier_bill_approval_controller.dart';
import 'package:nicon/home/menu/materials/supplier_bill_approval/supplier_bill_itemlist.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../utilities/common_date_fields.dart';
import '../../../../utilities/image_view.dart';
import '../../../../utilities/requestconstant.dart';

class SupplierBillEntry extends StatefulWidget {
  final String heading;
  const SupplierBillEntry({Key? key,required this.heading}) : super(key: key);

  @override
  State<SupplierBillEntry> createState() => _SupplierBillEntryState();
}

class _SupplierBillEntryState extends State<SupplierBillEntry> {

  SupplierBillApprovalController supplierBillApprovalController = Get.put(SupplierBillApprovalController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      projectController.selectedProjectId.value = result.projectId;
      siteController.selectedsiteId.value = result.siteId;
      projectController.projectname.text = result.projectName;
      siteController.Sitename.text = result.siteName;
      supplierBillApprovalController.selectedSupplierId.value = result.supplierId;
      supplierBillApprovalController.supplierNameController.text = result.supplierName;
      supplierBillApprovalController.dcNoController.text = result.dcNo;
      supplierBillApprovalController.dcDateController.text = result.dcDate;
      supplierBillApprovalController.invoiceNoController.text = result.invoiceNo;
      supplierBillApprovalController.invoiceDateController.text = result.billDate;
      supplierBillApprovalController.againstTypeController.text = result.poBillDesc;
      supplierBillApprovalController.companyNameController.text = result.companyName;
      supplierBillApprovalController.orderNoController.text = result.purOrdMasNo;



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
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: BaseUtitiles.getWidthtofPercentage(context, 25),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor

                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupplierBillItemList()));

                      },
                    ),
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
                                labelText: "Bill No",
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
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
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
                              controller: supplierBillApprovalController.supplierNameController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Supplier Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.supplierName),
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
                      if(supplierBillApprovalController.suppBillAppEditListValue[0].result.poBillType=="P")...{
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
                      controller: supplierBillApprovalController
                          .orderNoController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Order No",
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
                       },
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
                              controller: supplierBillApprovalController.dcNoController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "DC No",
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
                      CommonDateFields(
                        date1: CommonDateFieldConfig(
                          title: "DC Date",
                          value: supplierBillApprovalController.dcDateController.text,
                          controller: supplierBillApprovalController.dcDateController,
                          selectable: false,
                          initialDate: DateTime.tryParse(supplierBillApprovalController.dcDateController.text) ?? DateTime.now(),
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
                              controller: supplierBillApprovalController.invoiceNoController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Invoice No",
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
                      CommonDateFields(
                        date1: CommonDateFieldConfig(
                          title: "Invoice Date",
                          value: supplierBillApprovalController.invoiceDateController.text,
                          controller: supplierBillApprovalController.invoiceDateController,
                          selectable: false,
                          initialDate: DateTime.tryParse(supplierBillApprovalController.invoiceDateController.text) ?? DateTime.now(),
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
                              supplierBillApprovalController.againstTypeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Against Type",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                ),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.preparedBy,
                                ),
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
                              controller:
                              supplierBillApprovalController.companyNameController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Company",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                ),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.accountName,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: BaseUtitiles.getWidthtofPercentage(context, 32),
                          height: BaseUtitiles.getheightofPercentage(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).primaryColor
                          ),
                          alignment: Alignment.center,
                          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.image_outlined,color: Colors.white,size: 20,),
                              Text(
                                "Bill Images",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          await supplierBillApprovalController.suppBillApprovalImageApi(
                            supplierBillApprovalController
                                .suppBillAppEditListValue[0].result.id,
                            supplierBillApprovalController
                                .suppBillAppEditListValue[0].result.poBillType,
                          );

                          showDialog(
                            context: context,
                            builder: (context) => SelectTypeDialog(
                              imagePaths: supplierBillApprovalController
                                  .supplierBillImageList
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: height),
                    ],
                  ),
                ),
                SizedBox(
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
              ])),
        ),
      ),
    );
  }

  InputDecoration _supplierInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List<TextInputFormatter> _supplierNumberFormatters() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
            ? newValue
            : oldValue;
      }),
    ];
  }

  Widget _supplierInput(
      BuildContext context, {
        String? initialValue,
        TextEditingController? controller,
        bool readOnly = false,
        bool validateNumber = true,
        EdgeInsets margin = const EdgeInsets.only(right: 11),
        ValueChanged<String>? onChanged,
        VoidCallback? onTap
      }) {
    return Container(
      margin: margin,
      height: BaseUtitiles.getheightofPercentage(context, 4),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        readOnly: readOnly,
        onChanged: onChanged,
        onTap: onTap,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight:  FontWeight.w500 ,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        keyboardType: Platform.isAndroid
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        inputFormatters:
        validateNumber ? _supplierNumberFormatters() : null,
        textAlign: TextAlign.center,
        decoration: _supplierInputDecoration(context).copyWith(
          filled: true,
          fillColor: readOnly
              ? Theme.of(context).primaryColor.withOpacity(0.05)
              : Colors.white,
        ),
      ),
    );
  }

  Widget _supplierFieldRow(
      BuildContext context, {
        required String leftLabel,
        required Widget leftField,
        required String rightLabel,
        required Widget rightField,
      }) {
    Widget label(String text) {
      return Expanded(
        flex: 2,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 10, left: 5, right: 3),
      child: Row(
        children: [
          label(leftLabel),
          Expanded(flex: 4, child: leftField),
          label(rightLabel),
          Expanded(flex: 4, child: rightField),
        ],
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
            padding: EdgeInsets.only(
              bottom: BaseUtitiles.getheightofPercentage(context, 10),
            ),
            itemCount: supplierBillApprovalController
                .getSupplierBillItemViewDbList.length,
            itemBuilder: (BuildContext context, int index) {
              final value = supplierBillApprovalController
                  .getSupplierBillItemViewDbList.value;

              final item = value[index];
              final primary = Theme.of(context).primaryColor;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Colors.white,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 7,
                  ),
                  child: Column(
                    children: [
                      // Material name and View Details
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 5,
                                right: 12,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${item.materialName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      ' (${item.scaleName.toString().trim()})',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => showAmountDetailsDialog(context,item),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View Details',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primary,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: primary,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // PO BalQty and Bill Qty
                      _supplierFieldRow(
                        context,
                        leftLabel: 'PO BalQty',
                        leftField: _supplierInput(
                          context,
                          initialValue: item.balQty.toString(),
                          readOnly: true,
                          validateNumber: false,
                        ),

                        rightLabel: 'PO Rate',
                        rightField: _supplierInput(
                          context,
                          initialValue: item.poRate.toString(),
                          readOnly: true,
                          validateNumber: false,
                          margin: const EdgeInsets.only(left: 8),
                        ),
                      ),

                      // PO Rate and Rate
                      _supplierFieldRow(
                        context,
                        leftLabel: 'Bill Qty',
                        leftField: _supplierInput(
                            context,
                          initialValue: item.billQty.toString(),
                          controller:
                          supplierBillApprovalController.Itemlist_qtyControllers[index],
                          onChanged: (value) {
                            supplierBillApprovalController.updateBillQty(index, value);
                          },
                          onTap: () {
                            final controller =
                            supplierBillApprovalController.Itemlist_qtyControllers[index];

                            if (controller.text == '0.0' || controller.text =="0") {
                              controller.clear();
                            }
                          },
                        ),
                        rightLabel: 'Rate',
                        rightField: _supplierInput(
                          context,
                          initialValue: item.rate.toString(),
                          readOnly: true,
                          margin: const EdgeInsets.only(left: 8),
                        ),
                      ),

                      // Desc and Amount
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: _supplierFieldRow(
                          context,
                          leftLabel: 'Desc',
                          leftField: _supplierInput(context,
                              initialValue: item.description.toString(),
                              readOnly: true,
                              validateNumber: false),
                          rightLabel: 'Amount',
                          rightField: _supplierInput(
                            context,
                            initialValue: item.amount.toString(),
                            readOnly: true,
                            margin: const EdgeInsets.only(left: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ),
        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
      ],
    );
  }

  void showAmountDetailsDialog(BuildContext context,item) {
    final Color primaryColor = Theme.of(context).primaryColor;

    final List<Map<String, String>> details = [
      {'label': 'Disc %', 'value': item.disc_Per.toString()},
      {'label': 'Disc Amt', 'value': item.disc_Amt.toString()},
      {'label': 'SGST %', 'value': item.sgstPer.toString()},
      {'label': 'SGST Amt', 'value': item.sgstAmt.toString()},
      {'label': 'CGST %', 'value': item.cgstPer.toString()},
      {'label': 'CGST Amt', 'value': item.cgstAmt.toString()},
      {'label': 'IGST %', 'value': item.igstPer.toString()},
      {'label': 'IGST Amt', 'value': item.igstAmt.toString()},
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: const EdgeInsets.fromLTRB(18, 10, 12, 4),
          contentPadding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
          title: Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: primaryColor,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Amount Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(dialogContext),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: details.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.2,
                    ),
                    itemBuilder: (context, index) {
                      final item = details[index];

                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['label']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item['value']!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Net Amount',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                         Text(
                          '₹ ${item.netAmount}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectTypeDialog extends StatelessWidget {
  final List<String> imagePaths;

  const SelectTypeDialog({
    super.key,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      elevation: 8,
      shadowColor: primary.withOpacity(.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: primary.withOpacity(.18),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: primary.withOpacity(.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: primary.withOpacity(.12),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(.10),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.photo_library_outlined,
                        color: primary,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bill Images",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF20243A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${imagePaths.length} images available",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.close_rounded,
                            size: 21,
                            color: primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Image grid
              if (imagePaths.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text("No images available"),
                  ),
                )
              else
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                    MediaQuery.of(context).size.height * 0.55,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(3),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 9,
                      childAspectRatio: 1,
                    ),
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      final imageUrl = imagePaths[index];
                      final cacheBuster =
                          "time=${DateTime.now().millisecondsSinceEpoch}";

                      return GestureDetector(
                        onTap: () {
                          final viewUrl = Uri.parse(imageUrl)
                              .replace(
                            queryParameters: {
                              ...Uri.parse(imageUrl).queryParameters,
                              'time': DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                            },
                          )
                              .toString();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageViewPage(
                                imageUrl: viewUrl,
                                netUrl: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: grey.withOpacity(.15),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              Uri.parse(imageUrl)
                                  .replace(
                                queryParameters: {
                                  ...Uri.parse(imageUrl).queryParameters,
                                  'time': DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                },
                              )
                                  .toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return Container(
                                  color: Colors.grey.shade100,
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: primary,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade100,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}