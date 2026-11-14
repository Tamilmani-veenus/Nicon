import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/supplier_bill_approval_controller.dart';
import 'package:nicon/home/menu/materials/supplier_bill_approval/supplier_bill_itemlist.dart';
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
  const SupplierBillEntry({Key? key, required this.heading}) : super(key: key);

  @override
  State<SupplierBillEntry> createState() => _SupplierBillEntryState();
}

class _SupplierBillEntryState extends State<SupplierBillEntry> {
  SupplierBillApprovalController supplierBillApprovalController =
      Get.put(SupplierBillApprovalController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (supplierBillApprovalController.suppBillAppEditListValue.isEmpty) {
        return;
      }

      final result =
          supplierBillApprovalController.suppBillAppEditListValue[0].result;

      final controllers = supplierBillApprovalController.controllers;

      // Additional Charges
      controllers['Freight Charges']!.text =
          (result.frieghtCharges ?? 0).toString();

      controllers['Labour Charges']!.text =
          (result.labourCharges ?? 0).toString();

      controllers['Other Charges']!.text =
          (result.otherCharges ?? 0).toString();

      controllers['Round Off']!.text = (result.roundOff ?? 0).toString();

      // Taxes
      controllers['S-GST %']!.text = (result.sgstPercentage ?? 0).toString();

      controllers['S-GST Amt']!.text = (result.sgstAmount ?? 0).toString();

      controllers['Net S-GST']!.text = (result.netSgstAmount ?? 0).toString();

      controllers['C-GST %']!.text = (result.cgstPercentage ?? 0).toString();

      controllers['C-GST Amt']!.text = (result.cgstAmount ?? 0).toString();

      controllers['Net C-GST']!.text = (result.netCgstAmount ?? 0).toString();

      controllers['I-GST %']!.text = (result.igstPercentage ?? 0).toString();

      controllers['I-GST Amt']!.text = (result.igstAmount ?? 0).toString();

      controllers['Net I-GST']!.text = (result.netIgstAmount ?? 0).toString();

      controllers['TDS %']!.text = (result.tdsPercentage ?? 0).toString();

      controllers['TDS Amt']!.text = (result.tdsAmount ?? 0).toString();

      controllers['TCS %']!.text = (result.tcsPercentage ?? 0).toString();

      controllers['TCS Amt']!.text = (result.tcsAmount ?? 0).toString();

      controllers['Disc Amt']!.text = (result.discntAmount ?? 0).toString();

      controllers['Discount %']!.text =
          (result.discntPercentage ?? 0).toString();

      // Payment Details
      controllers['Net Amount']!.text = (result.netAmount ?? 0).toString();

      controllers['Advance Amount']!.text =
          (result.advanceAmountEdit ?? 0).toString();

      controllers['Net Pay Amount']!.text =
          (result.netPayAmount ?? 0).toString();

      controllers['Deduction Amount']!.text =
          (result.advanceAmount ?? 0).toString();

      // Remarks — if this controller exists
      controllers['Remarks']?.text = result.remarks ?? '';

      supplierBillApprovalController.isGstInclusive.value = result.gstApply;
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
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white),
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
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0].result.billNo
                                      .toString()),
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
                          value: supplierBillApprovalController
                              .suppBillAppEditListValue[0].result.entrydate
                              .toString(),
                          selectable: false,
                          initialDate: DateTime.tryParse(
                                  supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .entrydate
                                      .toString()) ??
                              DateTime.now(),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .projectName
                                      .toString()),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .siteName
                                      .toString()),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .supplierName
                                      .toString()),
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
                      if (supplierBillApprovalController
                              .suppBillAppEditListValue[0].result.poBillType ==
                          "P") ...{
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
                                autovalidateMode: AutovalidateMode.always,
                                readOnly: true,
                                controller: TextEditingController(
                                    text: supplierBillApprovalController
                                        .suppBillAppEditListValue[0]
                                        .result
                                        .purOrdMasNo
                                        .toString()),
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Order No",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          RequestConstant.Lable_Font_SIZE),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0].result.dcNo
                                      .toString()),
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
                          value: supplierBillApprovalController
                              .suppBillAppEditListValue[0].result.dcDate
                              .toString(),
                          selectable: false,
                          initialDate: DateTime.tryParse(
                                  supplierBillApprovalController
                                      .suppBillAppEditListValue[0].result.dcDate
                                      .toString()) ??
                              DateTime.now(),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .invoiceNo
                                      .toString()),
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
                          value: supplierBillApprovalController
                              .suppBillAppEditListValue[0].result.billDate
                              .toString(),
                          selectable: false,
                          initialDate: DateTime.tryParse(
                                  supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .billDate
                                      .toString()) ??
                              DateTime.now(),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                              .suppBillAppEditListValue[0]
                                              .result
                                              .billType ==
                                          "C"
                                      ? "Company"
                                      : "Client"),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .poBillDesc
                                      .toString()),
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
                              autovalidateMode: AutovalidateMode.always,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .companyName
                                      .toString()),
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
                      if (supplierBillApprovalController
                              .suppBillAppEditListValue[0].result.poBillType ==
                          "W") ...{
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
                                autovalidateMode: AutovalidateMode.always,
                                readOnly: true,
                                controller: TextEditingController(
                                    text: supplierBillApprovalController
                                        .suppBillAppEditListValue[0]
                                        .result
                                        .fromDate
                                        .toString()),
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "From Date",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.date,
                                  ),
                                ),
                              ),
                            ),
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
                                autovalidateMode: AutovalidateMode.always,
                                readOnly: true,
                                controller: TextEditingController(
                                    text: supplierBillApprovalController
                                        .suppBillAppEditListValue[0]
                                        .result
                                        .toDate
                                        .toString()),
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "To Date",
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
                                autovalidateMode: AutovalidateMode.always,
                                readOnly: true,
                                controller: TextEditingController(
                                    text: supplierBillApprovalController
                                        .suppBillAppEditListValue[0]
                                        .result
                                        .workOrdMasNo
                                        .toString()),
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Rental Work Order No",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.dcNo,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      },
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 32),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).primaryColor),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Bill Images",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          await supplierBillApprovalController
                              .suppBillApprovalImageApi(
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
                          borderRadius: BorderRadius.only(
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
                                      const SizedBox(height: 10),
                                      ListDetails(context, scrollController)
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

  Widget _supplierInput(BuildContext context,
      {String? initialValue,
      TextEditingController? controller,
      bool readOnly = false,
      bool validateNumber = true,
      EdgeInsets margin = const EdgeInsets.only(right: 11),
      ValueChanged<String>? onChanged,
      VoidCallback? onTap}) {
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
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        keyboardType: Platform.isAndroid
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        inputFormatters: validateNumber ? _supplierNumberFormatters() : null,
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
            Expanded(
              flex: 2,
              child: Text(
                leftLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),

            Expanded(
              flex: (leftLabel == 'Desc' &&
                  supplierBillApprovalController
                      .suppBillAppEditListValue[0]
                      .result.poBillType == "W")
                  ? 10
                  : 4,
              child: leftField,
            ),

            if (!(leftLabel == 'Desc' &&
                supplierBillApprovalController
                    .suppBillAppEditListValue[0]
                    .result.poBillType == "W")) ...[
              label(rightLabel),
              Expanded(
                flex: 4,
                child: rightField,
              ),
            ],
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
          child: Obx(() {
            final items =
                supplierBillApprovalController.getSupplierBillItemViewDbList;

            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: BaseUtitiles.getheightofPercentage(context, 10),
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
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
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: item.materialName ?? '',
                                        style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' (${item.scaleName.toString().trim()})',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (supplierBillApprovalController
                                    .suppBillAppEditListValue[0]
                                    .result
                                    .poBillType !=
                                "W")
                              InkWell(
                                onTap: () => showAmountDetailsDialog(
                                  context,
                                  item,
                                  index,
                                ),
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
                        if (supplierBillApprovalController
                                .suppBillAppEditListValue[0]
                                .result
                                .poBillType ==
                            "P") ...{
                          // PO BalQty and PO Rate
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
                        },
                        // Bill Qty and Rate
                        _supplierFieldRow(
                          context,
                          leftLabel: 'Bill Qty',
                          leftField: _supplierInput(
                            context,
                            controller: supplierBillApprovalController
                                .itemlist_qtyControllers[index],
                            readOnly: supplierBillApprovalController
                                .suppBillAppEditListValue[0]
                                .result
                                .poBillType ==
                                "W",
                            onChanged: (value) async {
                              await supplierBillApprovalController
                                  .updateBillQty(
                                      index,
                                      value,
                                      supplierBillApprovalController
                                          .suppBillAppEditListValue[0]
                                          .result
                                          .poBillType);
                            },
                            onTap: () {
                              final controller = supplierBillApprovalController
                                  .itemlist_qtyControllers[index];

                              if (controller.text == '0.0' ||
                                  controller.text == '0') {
                                controller.clear();
                              }
                            },
                          ),
                          rightLabel: 'Rate',
                          rightField: _supplierInput(
                            context,
                            initialValue: item.rate.toString(),
                            readOnly: supplierBillApprovalController
                                    .suppBillAppEditListValue[0]
                                    .result
                                    .poBillType !=
                                "G",
                            onChanged: (value) {
                              if (supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .poBillType ==
                                  "G") {
                                supplierBillApprovalController
                                    .updateGeneralBillItem(
                                        index, 'rate', value);
                              }
                            },
                            margin: const EdgeInsets.only(left: 8),
                          ),
                        ),

                        // Description and Amount
                        _supplierFieldRow(
                          context,
                          leftLabel: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .poBillType !=
                                  "W"
                              ? 'Desc'
                              : "Approx\nDays",
                          leftField: supplierBillApprovalController
                                      .suppBillAppEditListValue[0]
                                      .result
                                      .poBillType !=
                                  "W"
                              ? _supplierInput(
                                  context,
                                  initialValue: item.description ?? '',
                                  readOnly: supplierBillApprovalController
                                          .suppBillAppEditListValue[0]
                                          .result
                                          .poBillType ==
                                      "P",
                                  validateNumber: false,
                                  onChanged: (value) {
                                    if (supplierBillApprovalController
                                            .suppBillAppEditListValue[0]
                                            .result
                                            .poBillType ==
                                        "G") {
                                      supplierBillApprovalController
                                          .updateGeneralBillItem(
                                              index, 'description', value);
                                    }
                                  },
                                )
                              : _supplierInput(
                                  context,
                                  initialValue: item.approxDays.toString() ,
                                  readOnly: true,
                                  validateNumber: false,
                                ),
                          rightLabel: 'Amount',
                          rightField: Container(
                              margin: const EdgeInsets.only(left: 8),
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  (item.amount ?? 0).toString(),
                                  softWrap: false,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )),
                        ),
                        if(supplierBillApprovalController
                            .suppBillAppEditListValue[0]
                            .result
                            .poBillType ==
                            "W") Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: _supplierFieldRow(
                            context,
                            leftLabel:  'Desc',
                            leftField: _supplierInput(
                              context,
                              initialValue: item.description.toString() ,
                              readOnly: true,
                              validateNumber: false,
                              margin: const EdgeInsets.only(left: 0),
                            ),
                            rightLabel: '',
                            rightField: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
      ],
    );
  }

  final Map<String, TextEditingController> amountDetailControllers = {
    'Disc %': TextEditingController(),
    'Disc Amt': TextEditingController(),
    'SGST %': TextEditingController(),
    'SGST Amt': TextEditingController(),
    'CGST %': TextEditingController(),
    'CGST Amt': TextEditingController(),
    'IGST %': TextEditingController(),
    'IGST Amt': TextEditingController(),
    'Net Amount': TextEditingController(),
    'Expiry Date': TextEditingController(),
  };

  final Map<String, IconData> amountDetailIcons = {
    'Disc %': Icons.percent_rounded,
    'Disc Amt': Icons.currency_rupee_rounded,
    'SGST %': Icons.percent_rounded,
    'SGST Amt': Icons.currency_rupee_rounded,
    'CGST %': Icons.percent_rounded,
    'CGST Amt': Icons.currency_rupee_rounded,
    'IGST %': Icons.percent_rounded,
    'IGST Amt': Icons.currency_rupee_rounded,
    'Net Amount': Icons.account_balance_wallet_rounded,
    'Expiry Date': Icons.calendar_month_sharp,
  };

  void _syncAmountDetailControllers(item, String currentField) {
    String amount(dynamic value) {
      final number = double.tryParse(value?.toString() ?? '') ?? 0.0;
      return number.toStringAsFixed(2);
    }

    final updatedValues = {
      'Disc Amt': item.disc_Amt,
      'SGST %': item.sgstPer,
      'SGST Amt': item.sgstAmt,
      'CGST %': item.cgstPer,
      'CGST Amt': item.cgstAmt,
      'IGST %': item.igstPer,
      'IGST Amt': item.igstAmt,
      'Net Amount': item.netAmount,
    };

    updatedValues.forEach((key, value) {
      // Don't overwrite the field currently being typed
      if (key == currentField) return;

      amountDetailControllers[key]?.text = amount(value);
    });
  }

  void showAmountDetailsDialog(BuildContext context, item, int index) {
    final Color primaryColor = Theme.of(context).primaryColor;

    final Map<String, String> values = {
      'Disc %': item.disc_Per.toString(),
      'Disc Amt': item.disc_Amt.toString(),
      'SGST %': item.sgstPer.toString(),
      'SGST Amt': item.sgstAmt.toString(),
      'CGST %': item.cgstPer.toString(),
      'CGST Amt': item.cgstAmt.toString(),
      'IGST %': item.igstPer.toString(),
      'IGST Amt': item.igstAmt.toString(),
      'Net Amount': item.netAmount.toString(),
      'Expiry Date': item.expiryDate ?? "Not Applicable".toString(),
    };

    values.forEach((key, value) {
      amountDetailControllers[key]?.text = value;
    });

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            titlePadding: const EdgeInsets.fromLTRB(18, 12, 12, 4),
            contentPadding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 10.0;
                        const columnCount = 2;

                        final fieldWidth = (constraints.maxWidth -
                                spacing * (columnCount - 1)) /
                            columnCount;

                        final fields = values.keys
                            .where(
                                (e) => e != 'Net Amount' && e != 'Expiry Date')
                            .toList();

                        return Wrap(
                          spacing: spacing,
                          runSpacing: 10,
                          children: fields.map((field) {
                            return SizedBox(
                              width: fieldWidth,
                              child: _buildAmountDetailField(
                                field,
                                primaryColor,
                                item: item,
                                index: index,
                                setDialogState: setDialogState,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    // Net Amount
                    _buildAmountDetailField(
                      'Expiry Date',
                      primaryColor,
                      item: item,
                      index: index,
                      setDialogState: setDialogState,
                    ),

                    const SizedBox(height: 14),

                    _buildAmountDetailField(
                      'Net Amount',
                      primaryColor,
                      item: item,
                      index: index,
                      setDialogState: setDialogState,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildAmountDetailField(
    String label,
    Color primaryColor, {
    required dynamic item,
    required int index,
    required StateSetter setDialogState,
  }) {
    final bool isNetAmount = label == 'Net Amount';
    final poBillType = supplierBillApprovalController
        .suppBillAppEditListValue[0].result.poBillType;

    final double sgstValue = double.tryParse(
          amountDetailControllers['SGST %']?.text.trim() ?? '0',
        ) ??
        0.0;

    final double igstValue = double.tryParse(
          amountDetailControllers['IGST %']?.text.trim() ?? '0',
        ) ??
        0.0;

    final bool isEditable =
        poBillType == "G" && ['Disc %', 'SGST %', 'IGST %'].contains(label);

    final bool isReadOnly = !isEditable ||
        (label == 'IGST %' && sgstValue != 0) ||
        (label == 'SGST %' && igstValue != 0);

    return Container(
      decoration: BoxDecoration(
        color: isNetAmount
            ? primaryColor.withOpacity(0.10)
            : isEditable && !isReadOnly
                ? Colors.white
                : const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isNetAmount
              ? primaryColor.withOpacity(0.30)
              : isEditable && !isReadOnly
                  ? primaryColor.withOpacity(0.45)
                  : const Color(0xFFE8EAF0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: TextFormField(
          controller: amountDetailControllers[label],
          readOnly: isReadOnly,
          cursorColor: primaryColor,
          onChanged: (value) {
            if (!isEditable) return;

            final field = label == 'Disc %'
                ? 'disc'
                : label == 'SGST %'
                    ? 'sgst'
                    : 'igst';

            supplierBillApprovalController.updateGeneralBillItem(
              index,
              field,
              value,
            );

            _syncAmountDetailControllers(item, label);

            if (label == 'SGST %' || label == 'IGST %') {
              setDialogState(() {});
            }
          },
          onTap: () {
            if (!isEditable || isReadOnly) return;

            final controller = amountDetailControllers[label];

            final value = double.tryParse(controller?.text.trim() ?? '');

            if (value == 0) {
              controller?.clear();
            }
          },
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          style: TextStyle(
            color: isNetAmount ? primaryColor : const Color(0xFF29234D),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(
              color: isNetAmount ? primaryColor : Colors.grey.shade600,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            ),
            prefixIcon: Icon(
              amountDetailIcons[label] ?? Icons.calculate_rounded,
              size: 17,
              color: primaryColor,
            ),
            suffixIcon: isNetAmount
                ? Icon(
                    Icons.check_circle_rounded,
                    size: 17,
                    color: primaryColor,
                  )
                : null,
          ),
        ),
      ),
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
                    maxHeight: MediaQuery.of(context).size.height * 0.55,
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
                          final viewUrl = Uri.parse(imageUrl).replace(
                            queryParameters: {
                              ...Uri.parse(imageUrl).queryParameters,
                              'time': DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                            },
                          ).toString();

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
                              Uri.parse(imageUrl).replace(
                                queryParameters: {
                                  ...Uri.parse(imageUrl).queryParameters,
                                  'time': DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                },
                              ).toString(),
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
