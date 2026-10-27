import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

}
