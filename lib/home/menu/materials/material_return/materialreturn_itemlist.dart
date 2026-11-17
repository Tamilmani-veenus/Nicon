import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/materialreturn_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../daily_entries/daily_wrk_done_dpr/type_subcont_alert.dart';


class MaterialReturn_ItemList extends StatefulWidget {
  const MaterialReturn_ItemList({Key? key}) : super(key: key);

  @override
  State<MaterialReturn_ItemList> createState() => _MaterialReturn_ItemListState();
}

class _MaterialReturn_ItemListState extends State<MaterialReturn_ItemList> {
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  MaterialReturn_Controller matreturnController = Get.put(MaterialReturn_Controller());

  @override
  void initState() {
    matreturnController.getGrnMaterialDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(top: false,
        child: Scaffold(
          bottomSheet: SizedBox(
            height: kToolbarHeight,
          ),
          bottomNavigationBar:   Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color:   Theme.of(context).primaryColor ,
                  ),
                  alignment: Alignment.center,
                  child: Text(matreturnController.editCheck == 1 ?"Re-Submit":"Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                        color:   Colors.white ),
                  ),
                ),
                  onTap: () async {
                    if (matreturnController.grnMaterialReadList.isEmpty && matreturnController.GRN_StockInNo_Controller.text == "--SELECT--" ) {
                      BaseUtitiles.showToast("Please add item");
                      return;
                    }
                    if (matreturnController.grnMaterialReadList.isEmpty) {
                      BaseUtitiles.showToast("Please select GRN No");
                      return;
                    }
                    bool allValid = true;

                    for (var controller in matreturnController.ReturnQtyController) {
                      final returnText = controller.text;
                      if (returnText.isEmpty || returnText == "0" || double.tryParse(returnText) == 0.0) {
                        allValid = false;
                        BaseUtitiles.showToast("Return qty should not be empty");
                        break;
                      }
                    }

                    if (allValid) {
                      SubmitAlert(context);
                    }
                  }

              ),
            ),
          ],
        ),
            ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Material Return",
                        style: TextStyle(fontSize: RequestConstant.Heading_Font_SIZE, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          )),

                    ],
                  ),
                ),
                const SizedBox(height: 5),

                Container(
                  margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                        readOnly: true,
                        controller: matreturnController.GRN_StockInNo_Controller,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Item Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: ConstIcons.unit),
                        ),
                        onTap: () async {
                          await  matreturnController.getGrnMaterialDetails();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  GRN_AddMaterialsDialog();
                                });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Enter user name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20,top:10),
                        width: BaseUtitiles.getWidthtofPercentage(context, 25),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: const Text("Add",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white),
                        ),
                      ),
                      onTap: ()  {
                        var duration = const Duration(seconds: 0);
                        Future.delayed(duration, () async {
                          if(matreturnController.selectedGRN_Id.value == "0"){
                            BaseUtitiles.showToast("Please Select Item");
                          }else{
                            await matreturnController.getGRNList(matreturnController.selectedGRN_Id.value);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  GRNList_Alert(list: matreturnController.getGRN_List);
                                });
                          }
                        });
                      },
                    ),
                  ],
                ),

                listDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listDetails() {
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 70/100,
            child: Obx(()=> ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: matreturnController.grnMaterialReadList.value.length,
              itemBuilder: (BuildContext context, int index) {
                matreturnController.textControllersInitiate();
                return Card(
                  color: Colors.white,
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[

                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              matreturnController.grnMaterialReadList[index].transNo,
                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 25,
                                child: Text(
                                  matreturnController.grnMaterialReadList[index].materialName,
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text("",
                                  style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold),
                                ),
                              ),

                              Visibility(
                                visible: true,
                                child: Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: BaseUtitiles.getheightofPercentage(context, 2),
                                    width: BaseUtitiles.getWidthtofPercentage(context, 8),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                title: const Text(RequestConstant.DO_YOU_WANT_DELETE),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      child: const Text(RequestConstant.NO),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                  ElevatedButton(
                                                      child: const Text(RequestConstant.YES),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        await matreturnController.deleteParticularList(matreturnController.grnMaterialReadList[index]);
                                                        await matreturnController.getGrnMaterialTablesDatas();
                                                      }
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      child: Image.asset('assets/cancle.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "Unit",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 11),
                                    height: BaseUtitiles.getheightofPercentage(context, 4),
                                    child: TextFormField(
                                      readOnly: true,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.black),
                                        controller: TextEditingController(text: matreturnController.grnMaterialReadList[index].scale),
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                        ),
                                    ),
                                  )),
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Stock Qty",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    height: BaseUtitiles.getheightofPercentage(context, 4),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      readOnly: true,
                                      controller: TextEditingController(text: matreturnController.grnMaterialReadList[index].stockQty.toString()),
                                      style: const TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      ),
                                    ),),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // 👈 Makes the row only as wide as its children
                              children: <Widget>[
                                const Text(
                                  "Return Qty",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(width: 12), // spacing between label and field
                                SizedBox(
                                  width: 150, // set your preferred width
                                  height: BaseUtitiles.getheightofPercentage(context, 4),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: matreturnController.ReturnQtyController[index],
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    ),
                                    onChanged: (value) async {
                                      matreturnController.clickEdit();
                                    },
                                    onTap: () {
                                      if (matreturnController
                                          .ReturnQtyController[index].text ==
                                          "0.0" ||
                                          matreturnController.ReturnQtyController[index].text == "0") {
                                        matreturnController.ReturnQtyController[index].text = "";
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    matreturnController.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(matreturnController.editCheck == 1 ? 'Are you sure to Re-Submit?' :
        'Are you sure to Submit?' ),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
                              await matreturnController.getGrnMaterialTablesDatas();
                              await matreturnController.SaveButton_GRNMaterialScreen(
                                context, matreturnController.returnId.value,
                              );
                            }
                        },
                        child: Text(
                          matreturnController.editCheck == 1
                              ? RequestConstant.RESUBMIT
                              : RequestConstant.SUBMIT,
                          style: TextStyle(
                            color: matreturnController.buttonControl == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey, // Change color when button is disabled
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


}