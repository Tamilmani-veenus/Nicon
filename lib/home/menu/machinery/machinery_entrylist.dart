// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../../../app_theme/app_colors.dart';
// import '../../../controller/comman_controller.dart';
// import '../../../controller/logincontroller.dart';
// import '../../../controller/machinery_indent_controller.dart';
// import '../../../controller/mrn_request_indent_controller.dart';
// import '../../../controller/punch_in_controller.dart';
// import '../../../utilities/baseutitiles.dart';
// import '../../../utilities/common_list_sceen.dart';
// import '../../../utilities/requestconstant.dart';
// import 'machinery_entry.dart';
//
// class MachineryIndentEntryList extends StatefulWidget {
//   final String heading;
//   const MachineryIndentEntryList({Key? key,required this.heading}) : super(key: key);
//
//   @override
//   State<MachineryIndentEntryList> createState() => _MachineryIndentEntryListState();
// }
//
// class _MachineryIndentEntryListState extends State<MachineryIndentEntryList> {
//   MachineryIndentController machineryIndentController = Get.put(MachineryIndentController());
//   MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
//   CommanController commonController = Get.put(CommanController());
//   TextEditingController editingController = TextEditingController();
//   int? expandedIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     CommonDateUtils.setCommonDateRange(
//       fromController: machineryIndentController.macIndentListFrDate,
//       toController: machineryIndentController.macIndentListToDate,
//     );
//     machineryIndentController.getMacIndentEntryList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         }
//       },
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           backgroundColor: Setmybackground,
//           bottomNavigationBar: Obx(
//                 () => CommonRequestBottomBar(
//               totalCount: machineryIndentController.mainEtyList.length,
//               showAdd: commonController.addMode.value == 1,
//               onAdd: () {
//                 machineryIndentController.saveButton.value =
//                     RequestConstant.SUBMIT;
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MachineryIndentEntry(
//                       heading: widget.heading,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           body: Column(
//             children: [
//               CommonPageHeader(
//                 title: widget.heading,
//                 onBack: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               CommonDateFilter(
//                 fromController:
//                 machineryIndentController.macIndentListFrDate,
//
//                 toController:
//                 machineryIndentController.macIndentListToDate,
//
//                 onShow: () async {
//                   setState(() {
//                     editingController.text = "";
//                   });
//
//                   await machineryIndentController.getMacIndentEntryList();
//                 },
//               ),
//               CommonSearchField(
//                 controller: editingController,
//                 onChanged: (value) {
//                   setState(() {
//                     machineryIndentController.macReqEtyList.value =
//                         BaseUtitiles.filterSearchResults(
//                           value,
//                           machineryIndentController.mainEtyList,
//                               (item) {
//                                 final String typeText =
//                                 item.requestType.toString().trim() == "M"
//                                     ? "Machinery Items"
//                                     : "-";
//
//                                 return [
//                                   typeText,
//                               item.projectName.toString(),
//                               item.siteName.toString(),
//                               CommonDateUtils.formatDateForDisplay(item.reqOrdDate.toString()),
//                               CommonDateUtils.formatDateForDisplay(item.reqDueDate.toString()),
//                               item.reqOrdNo.toString(),
//                               item.createdByName.toString(),
//                             ];
//                           },
//                         );
//                   });
//                 },
//               ),
//               Expanded(child: ListDetails()),
//             ],
//           ),
//         ),
//
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Obx(
//           () => CommonRequestList(
//         items: machineryIndentController.macReqEtyList.value,
//
//         expandedIndex: expandedIndex,
//
//         onExpand: (index) {
//           setState(() {
//             expandedIndex =
//             expandedIndex == index ? null : index;
//           });
//         },
//
//         date: (item) =>
//             item.reqOrdDate.toString(),
//
//         day: (item) =>
//             BaseUtitiles().extractDay(
//               item.reqOrdDate.toString(),
//             ),
//
//         requestNo: (item) =>
//             item.reqOrdNo.toString(),
//
//         dynamicContent: (item) {
//           return Column(
//             crossAxisAlignment:
//             CrossAxisAlignment.start,
//             children: [
//
//               Row(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//
//                   Expanded(
//                       child: CommonKeyValue(
//                         label: "PROJECT",
//                         value: item.projectName.toString(),
//                       )
//                   ),
//
//                   const SizedBox(width: 12),
//
//                   Expanded(
//                     child: CommonKeyValue(
//                       label:"SITE",
//                       value:item.siteName.toString(),
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 12),
//
//               Row(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//
//                   Expanded(
//                     child: CommonKeyValue(
//                       label:"DUE DATE",
//                       value:CommonDateUtils.formatDateForDisplay(item.reqDueDate.toString()),
//                       color:
//                       const Color(0xFF1C1B29),
//                     ),
//                   ),
//
//                   const SizedBox(width: 12),
//
//                   Expanded(
//                     child: CommonKeyValue(
//                       label:"REQ TYPE",
//                       value:item.requestType.toString().trim() == "M"
//                           ? "Machinery Items"
//                           : "-",
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//
//         preparedBy: (item) =>
//             item.createdByName.toString(),
//
//         showEdit:
//         commonController.editMode.value == 1,
//
//         showDelete:
//         commonController.deleteMode.value == 1,
//
//
//         onEdit: (item, index) async {
//           mrn_request_controller.delete_MaterialIntent_itemlist_Table();
//           mrn_request_controller.Material_itemview_GetDbList.clear();
//
//           FocusScope.of(context).unfocus();
//
//           await machineryIndentController
//               .machineryIndentEdit(
//             item.id,
//             widget.heading,
//             context,
//             "Edit"
//           );
//
//           setState(() {
//             expandedIndex = null;
//           });
//         },
//
//         onDelete: (item, index) {
//           setState(() {
//             expandedIndex = null;
//           });
//
//           machineryIndentController.deleteAlert(
//             context,
//             index,
//           );
//         },
//
//         bottomPadding: BaseUtitiles.getheightofPercentage(
//           context,
//           7,
//         ),
//       ),
//     );
//   }
// }
