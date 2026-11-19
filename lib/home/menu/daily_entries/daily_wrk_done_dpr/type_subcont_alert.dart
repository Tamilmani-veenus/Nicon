import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../controller/materialReturn_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class TypeSubcontAlert extends StatefulWidget {
  const TypeSubcontAlert({Key? key,required this.list}) : super(key: key);
  final List list;

  @override
  State<TypeSubcontAlert> createState() => _TypeSubcontAlertState();
}

class _TypeSubcontAlertState extends State<TypeSubcontAlert> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack( children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        dailyWrkDone_DPR_Controller.dpr_subcontractorList.value=BaseUtitiles.subcontPopupAlert(value,dailyWrkDone_DPR_Controller.dpr_subcontractorList.value);
                      });
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                        prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: BaseUtitiles.getWidthtofPercentage(context, 80),
                  height: BaseUtitiles.getheightofPercentage(context, 55),
                  child: ListView.builder(
                      itemCount: dailyWrkDone_DPR_Controller.dpr_subcontractorList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = dailyWrkDone_DPR_Controller.dpr_subcontractorList[index].subContName;
                              dailyWrkDone_DPR_Controller.TypeSubcontId.value=dailyWrkDone_DPR_Controller.dpr_subcontractorList[index].subContractorId;
                            });
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width:
                                      BaseUtitiles.getWidthtofPercentage(
                                          context, 60),
                                      child: Text(dailyWrkDone_DPR_Controller.dpr_subcontractorList.value[index].subContName
                                          .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                  Divider(
                                    color: Theme.of(context).primaryColorLight,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ]),
    );


  }

}

///-------------GRN_AddMaterials----------


class GRN_AddMaterialsDialog extends StatefulWidget {
  const GRN_AddMaterialsDialog({Key? key}) : super(key: key);

  @override
  State<GRN_AddMaterialsDialog> createState() => _GRN_AddMaterialsDialogState();
}

class _GRN_AddMaterialsDialogState extends State<GRN_AddMaterialsDialog> {
  TextEditingController editingController = TextEditingController();
  MaterialReturn_Controller matreturnController = Get.put(MaterialReturn_Controller());

  // @override
  // void initState() {
  //   matreturnController.getGRN_MaterialList.value = matreturnController.GRNmainlist.value;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack( children: <Widget>[
        SingleChildScrollView(
          child: Container(
            //height: BaseUtitiles.getheightofPercentage(context, 60),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        matreturnController.getGRN_MaterialList.value=BaseUtitiles.grnMaterialDetailsPopupAlert(value,matreturnController.searchCatNameList.value);
                      });
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                        prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: BaseUtitiles.getWidthtofPercentage(context, 80),
                  height: BaseUtitiles.getheightofPercentage(context, 55),
                  child: ListView.builder(
                      itemCount:  matreturnController.getGRN_MaterialList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                              matreturnController.GRN_StockInNo_Controller.text =matreturnController.getGRN_MaterialList.value[index]["materialName"];
                              matreturnController.selectedGRN_Id.value =matreturnController.getGRN_MaterialList.value[index]["id"].toString();
                              Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width:
                                      BaseUtitiles.getWidthtofPercentage(context, 60),
                                      child: Text( matreturnController.getGRN_MaterialList.value[index]["materialName"].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                  Divider(
                                    color: Theme.of(context).primaryColorLight,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ]),
    );

  }
}

///-------------GRN_No List---------

class GRNList_Alert extends StatefulWidget {
  const GRNList_Alert({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<GRNList_Alert> createState() => _GRNList_AlertState();
}

class _GRNList_AlertState extends State<GRNList_Alert> {

  TextEditingController editingController = TextEditingController();
  MaterialReturn_Controller matreturnController = Get.put(MaterialReturn_Controller());

  @override
  void initState() {
    matreturnController.isChecked = List<bool>.filled(widget.list.length, false);
    // matreturnController.getGRN_MaterialList.value = matreturnController.searchCatNameList.value;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack( children: <Widget>[
        SingleChildScrollView(
          child: Container(
            // height: BaseUtitiles.getheightofPercentage(context, 60),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        matreturnController.getGRN_List.value = BaseUtitiles.grnListPopupAlert(value,matreturnController.GRNmainlist.value);
                      });
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                        prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: BaseUtitiles.getWidthtofPercentage(context, 80),
                  height: BaseUtitiles.getheightofPercentage(context, 55),
                  child: ListView.builder(
                      itemCount: matreturnController.getGRN_List.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                      side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                                        width: 1.0,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                      checkColor: Colors.white,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          matreturnController.setCheck(
                                            matreturnController.getGRN_List.value[index]['stockInId'],
                                            value!,
                                          );
                                          matreturnController.getGRN_List.value[index]['isCheck'] = value;
                                        });
                                      },
                                      value: matreturnController.getGRN_List.value[index]['isCheck'] ?? false,
                                    ),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: RequestConstant.ALERT_Font_SIZE,
                                          fontWeight: FontWeight.bold,

                                        ),
                                        children: [
                                          TextSpan(
                                            text: matreturnController.getGRN_List.value[index]['transNo'].toString(),
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Divider(
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ],
                        );
                      }),
                ),

                ElevatedButton(
                  onPressed: () async {
                    bool isAnySelected = matreturnController.getGRN_List.value
                        .any((value) => value['isCheck'] == true);

                    if (isAnySelected) {
                      await matreturnController.grnMaterial_DetailsTableSave(context);
                      await matreturnController.getGrnMaterialTablesDatas();

                      if (widget.list.isNotEmpty) {
                        matreturnController.clearCheck();
                      }
                    }
                    else {
                      BaseUtitiles.showToast("Please select any one");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // Adjusts the row size to match the child widgets
                    children: [
                      Icon(
                        Icons.library_add_check_outlined,
                        color: Colors.white,
                        size: RequestConstant.Heading_Font_SIZE,
                      ),
                      SizedBox(width: 8.0), // Add some space between the icon and the text
                      Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ]),
    );
  }
}

