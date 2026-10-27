import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/supplier_bill_approval_controller.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../utilities/baseutitiles.dart';
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

              ),
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
