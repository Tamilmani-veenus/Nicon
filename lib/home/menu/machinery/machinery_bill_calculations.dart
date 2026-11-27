import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/billgeneration_boq_controller.dart';
import '../../../controller/machinery_bill_generation_controller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';

class MachineryBillCalculations extends StatefulWidget {
  const MachineryBillCalculations({super.key});

  @override
  State<MachineryBillCalculations> createState() => _MachineryBillCalculationsState();
}

class _MachineryBillCalculationsState extends State<MachineryBillCalculations> {

  MachineryBillGenController machineryBillGenController = Get.put(MachineryBillGenController());
  BillGenerationBoqController billGenerationBoqController=Get.put(BillGenerationBoqController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (machineryBillGenController.saveButton.value ==
          RequestConstant.SUBMIT) {
        machineryBillGenController.refreshBill();
        machineryBillGenController.calculate();
      } else {
        for (var result in machineryBillGenController.macReqEditList) {
          machineryBillGenController.billAmount.text =
              (result.billAmount ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.creditAmount.text =
              (result.creditAmount ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.debitAmount.text =
              (result.debitAmount ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.creditRemarks.text =
              result.creditRemarks ?? "";

          machineryBillGenController.debitRemarks.text =
              result.debitRemarks ?? "";

          machineryBillGenController.netBillAmount.text =
              (result.netBillAmount ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.roundOff.text =
              (result.roundOff ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.finalBillAmount.text =
              (result.finalBillAmount ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.netPayAmount.text =
              (result.netPayAmount ?? 0.0).toStringAsFixed(2);

          machineryBillGenController.setEditAddLessValues(
            result.subContractorMachineryBillAddLessSetupLink,
          );

          machineryBillGenController.calculate(showToast: false);
        }
      }

      if (mounted) {
        setState(() {});
      }
    });
  }
  final _formKey = GlobalKey<FormState>();

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
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Summary & Deductions",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
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
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          controller: machineryBillGenController.billAmount,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Bill Amt",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.discription,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "0.0" ||
                                value == "0.00") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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

                                keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],
                                controller: machineryBillGenController.creditAmount,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Credit Amt",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.creditAmt,
                                  ),

                                ),
                                onChanged: (_) => machineryBillGenController.calculate(),
                                onTap: () {
                                  final c = machineryBillGenController.creditAmount;
                                  if (c.text == "0.00" || c.text == "0.0" || c.text == "0") c.text = "";
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                controller: machineryBillGenController.creditRemarks,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Credit Remarks",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
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
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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

                                keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],
                                controller: machineryBillGenController.debitAmount,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Debit Amt",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.debitAmt,
                                  ),
                                ),
                                onChanged: (_) => machineryBillGenController.calculate(),
                                onTap: () {
                                  final c = machineryBillGenController.debitAmount;
                                  if (c.text == "0.00" || c.text == "0.0" || c.text == "0") c.text = "";
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                controller: machineryBillGenController.debitRemarks,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Debit Remarks",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
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
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                autovalidateMode:
                                AutovalidateMode.always,
                                controller: machineryBillGenController.netBillAmount,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Net Bill Amt",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.length,
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                controller: machineryBillGenController.roundOff,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                keyboardType: Platform.isAndroid
                                    ? const TextInputType.numberWithOptions(decimal: true, signed: true)
                                    : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^-?\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Round Off",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.roundoff),
                                ),
                                onChanged: (_) => machineryBillGenController.calculate(),
                                onTap: () {
                                  final c = machineryBillGenController.roundOff;
                                  if (c.text == "0.00" || c.text == "0.0" || c.text == "0") c.text = "";
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                autovalidateMode:
                                AutovalidateMode.always,
                                controller: machineryBillGenController.finalBillAmount,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Final Bill Amt",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.unit,
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                controller: machineryBillGenController.netPayAmount,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Net Pay Amt",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.netAmt),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx((){
                      return Table(
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(2.5),
                          1: FlexColumnWidth(1.2),
                          2: FlexColumnWidth(1.5),
                          3: FlexColumnWidth(2),
                        },
                        children: [

                          /// HEADER
                          TableRow(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                            children:  [
                              tableHeader("DESCRIPTION"),
                              tableHeader("+/-"),
                              tableHeader("%"),
                              tableHeader("AMOUNT"),
                            ],
                          ),

                          /// ROWS
                          ...List.generate(billGenerationBoqController.directBillGen_ItemReadList.length ,(index) {
                            final item = billGenerationBoqController.directBillGen_ItemReadList[index];

                            return TableRow(
                              children: [
                                tableCellText(item.addLessName ?? ''),

                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: item.addLessType == "+"
                                          ? Colors.green.shade100
                                          : Colors.red.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.addLessType ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: item.addLessType == "+"
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: billGenerationBoqController.percentControllers[index],
                                    keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                    inputFormatters: [
                                      TextInputFormatter.withFunction((oldValue, newValue) {
                                        return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                            ? newValue
                                            : oldValue;
                                      }),
                                    ],
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color: Colors.grey, // normal border color
                                          width: 1,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color: Colors.grey, // focused border color
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      final item =
                                      billGenerationBoqController
                                          .directBillGen_ItemReadList[index];

                                      double oldPercent =
                                          item.percentValue ?? 0.0;

                                      double oldAmount =
                                          item.amount ?? 0.0;

                                      final percent =
                                          double.tryParse(val) ?? 0.0;

                                      bool success = machineryBillGenController.updatePercent(item.addLessId!, percent);

                                      // RESTORE ONLY CURRENT FIELD
                                      if (!success) {

                                        billGenerationBoqController
                                            .percentControllers[index]
                                            .text =
                                        oldPercent == 0
                                            ? ''
                                            : oldPercent.toString();

                                        billGenerationBoqController
                                            .percentControllers[index]
                                            .selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                billGenerationBoqController
                                                    .percentControllers[index]
                                                    .text
                                                    .length,
                                              ),
                                            );

                                        item.percentValue = oldPercent;
                                        item.amount = oldAmount;

                                        billGenerationBoqController
                                            .directBillGen_ItemReadList
                                            .refresh();
                                      }
                                    },
                                    onEditingComplete: () async {
                                      FocusScope.of(context).unfocus();   // closes keyboard
                                      await billGenerationBoqController.saveUpdatedCalcData();
                                    },
                                  ),
                                ),
                                Obx(() {
                                  final updated = billGenerationBoqController.directBillGen_ItemReadList
                                      .firstWhereOrNull((e) => e.addLessId == item.addLessId);

                                  final amount = (updated?.amount ?? 0.0);
                                  final displayAmount = amount == 0 || amount.abs() < 0.005 ? 0.0 : amount;

                                  return tableCellText(
                                    displayAmount.toStringAsFixed(2),
                                    align: TextAlign.right,
                                  );
                                }),

                              ],
                            );

                          }),
                          /// TOTAL ROW
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                            ),
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(),
                                child: const Text(
                                  "Total Add/Less",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(),
                              const SizedBox(),
                              /// TOTAL AMOUNT

                              Obx(() => Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  billGenerationBoqController
                                      .getTotalAddLess()
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ))

                            ],
                          ),
                        ],
                      );}
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 10,
            ),

            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                )
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if(machineryBillGenController.saveButton.value == RequestConstant.SUBMIT)
                      Expanded(
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                color:  Colors.white
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color:  Theme.of(context).primaryColor
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
                      Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color:  Theme.of(context).primaryColor

                          ),
                          alignment: Alignment.center,
                          child: Text(
                            machineryBillGenController.saveButton.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color:Colors.white
                            ),
                          ),
                        ),
                        onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                             if (double.parse(machineryBillGenController.netPayAmount.text) <= 0) {
                              BaseUtitiles.showToast(
                                  "Net pay amount must be greater than 0");
                            }
                            else {
                              SubmitAlert(context);
                            }
                        };
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget tableCellText(
      String text, {
        TextAlign align = TextAlign.left,
      }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: align,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text(
          'Are you sure to ${machineryBillGenController.saveButton.value}?',
        ),
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
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
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
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                          await machineryBillGenController.getMachineryBillDetLocalDatas();
                          await machineryBillGenController.SaveMachineryBillScreen(
                                  context,
                              machineryBillGenController.saveButton.value == RequestConstant.SUBMIT?0:machineryBillGenController.macReqEditList[0].id);
                            }
                        },
                        child: Text(
                          machineryBillGenController.saveButton.value,
                          style: TextStyle(
                            color:
                            Theme.of(context).primaryColor,
                            // Change color when disabled
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
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        // // Generate new BOQ number
                        // await autoYearWiseNoController.AutoYearWiseNo("BILL BOQ");
                        //
                        // billGenerationBoqController.autoYearWiseNoController.text =
                        //     autoYearWiseNoController.BillBoqautoYrsWise.value;
                        //
                        // // Current date
                        // final currentDate = BaseUtitiles.initiateCurrentDateFormat();
                        //
                        // // -----------------------------
                        // // Reset Bill Header
                        // // -----------------------------
                        // billGenerationBoqController.billentryDateController.text = currentDate;
                        // billGenerationBoqController.workid = 0;
                        //
                        // // Project
                        // projectController.projectname.text = "--SELECT--";
                        // projectController.selectedProjectId.value = 0;
                        //
                        // // Site
                        // siteController.Sitename.text = "--SELECT--";
                        // siteController.selectedsiteId.value = 0;
                        //
                        // // Subcontractor
                        // dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
                        // dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
                        //
                        // // Work Order
                        // subcontractorController.WorkOrderNo.text = "--SELECT--";
                        // subcontractorController.selectedWorkOrderId.value = 0;
                        //
                        // billGenerationBoqController.FromdateController.text = currentDate;
                        // billGenerationBoqController.TodateController.text = currentDate;
                        // billGenerationBoqController.billInvoiceDateController.text = currentDate;
                        // billGenerationBoqController.billPaymentWkDateController.text = currentDate;
                        //
                        // subcontractorController.InvoiceNo.clear();
                        //
                        // billGenerationBoqController.RemarksController.clear();
                        //
                        // billGenerationBoqController.to_be_dection_advance = "0.0";
                        //
                        // await billGenerationBoqController.billgen_itemlistTable_Delete();
                        //
                        // billGenerationBoqController.ItemGetTableListdata.clear();
                        //
                        // billGenerationBoqController.billamount.text = "0.0";
                        // billGenerationBoqController.Creditamt.text = "0.0";
                        // billGenerationBoqController.Debitamt.text = "0.0";
                        // billGenerationBoqController.materialDebitamt.text = "0.0";
                        // billGenerationBoqController.netBillAmt.text = "0.0";
                        // billGenerationBoqController.finalBillAmt.text = "0.0";
                        // billGenerationBoqController.netpayamt.text = "0.0";
                        // billGenerationBoqController.materialDebitRemarks.text = "-";
                        // billGenerationBoqController.CreditRemarksController.text = "-";
                        // billGenerationBoqController.DebitRemarksController.text = "-";
                        // billGenerationBoqController.tobededadv.text =
                        //     billGenerationBoqController.to_be_dection_advance;
                        //
                        // billGenerationBoqController.Advded.text =
                        //     billGenerationBoqController.to_be_dection_advance;
                        // billGenerationBoqController.Roundoff.text = "0.0";
                        // for (final controller
                        // in billGenerationBoqController.percentControllers) {
                        //   controller.clear();
                        // }
                        // for (final item
                        // in billGenerationBoqController.directBillGen_ItemReadList) {
                        //   item.percentValue = 0.0;
                        //   item.amount = 0.0;
                        // }
                        // billGenerationBoqController.directBillGen_ItemReadList.refresh();
                        // await billGenerationBoqController.deductionPaymentCalculation();
                        // if (context.mounted) {
                        //   Navigator.pop(context);
                        // }
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
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