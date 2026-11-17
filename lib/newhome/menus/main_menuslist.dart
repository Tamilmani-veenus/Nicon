import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/comman_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../utilities/baseutitiles.dart';
import '../maindashboard/dashboard.dart';
import '../maindashboard/dashboard_otheruser.dart';

class MainManusList extends StatefulWidget {
  const MainManusList({Key? key}) : super(key: key);

  @override
  State<MainManusList> createState() => _MainManusListState();
}

class _MainManusListState extends State<MainManusList> {
  CommanController commanController = Get.put(CommanController());
  Menu_Controller menuController = Get.put(Menu_Controller());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    menuController.formMenuId.value = 0;
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      await menuController.getMenuList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: WillPopScope(
        onWillPop: () => homeScreen(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(child: rowDetails()),
            )
          ],
        ),
      ),
    );
  }

  homeScreen() {
    if (loginController.user.value.userType == "A") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Dashboard_screen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
  }

  Widget rowDetails() {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        await menuController.getMenuList(context);
      },
      child: Obx(
            () => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.only(
            bottom: BaseUtitiles.getheightofPercentage(context, 5),
          ),
          itemCount: menuController.menuListDatas.value.length,
          itemBuilder: (context, index) {
            final module = menuController.menuListDatas.value[index];
            final String? moduleName = module.moduleName;

            // Empty module
            if (moduleName == null ||
                module.menu == null ||
                module.menu!.isEmpty) {
              return const SizedBox.shrink();
            }

            // Hidden modules
            if (moduleName == "Home" ||
                moduleName == "Main Menu" ||
                moduleName == "Approvals" ||
                moduleName == "Reports") {
              return const SizedBox.shrink();
            }

            return buildModuleSection(
              title: moduleName,
              items: module.menu!,
              getIcon: (item) => getMenuIcon(item.menuName),
              getIconSize: (item) => getMenuIconSize(item.menuName),
              getName: (item) => item.dynamicMenuName ?? "-",
              onTap: (item) {
                return () async {
                  menuController.navigateToMenu(
                    item.menuName!,
                    item.dynamicMenuName!,
                    context,
                  );

                  menuController.formName.value = item.menuName!;
                  menuController.formMenuId.value = item.menuId!;

                  await commanController.getControllEntryListRights();
                };
              },
            );
          },
        ),
      ),
    );
  }

// ================== ICONS ==================

  IconData getMenuIcon(String? name) {
    switch (name) {
    // Materials
      case "MRN Request (Indent)":
        return FontAwesomeIcons.penToSquare;
      case "Site Request (Issue Slip)":
        return FontAwesomeIcons.fileInvoice;
      case "Inward":
        return FontAwesomeIcons.listCheck;
      case "Transfer Between Projects":
        return FontAwesomeIcons.arrowsTurnToDots;
      case "Transfer Between Sites":
        return FontAwesomeIcons.arrowsSpin;
      case "Material Transfer Request":
        return FontAwesomeIcons.trailer;
      case "Consumption":
        return FontAwesomeIcons.personDigging;
      case "Material Return":
        return FontAwesomeIcons.boxesPacking;

    // Daily Entries
      case "SubContractor Attendance":
        return Icons.how_to_reg;
      case "Company NMR Attendance":
        return Icons.engineering;
      case "SubCont NMR Wkly Bill - Generation":
        return Icons.receipt_long_outlined;
      case "Daily Work Done (DPR)":
        return FontAwesomeIcons.trowelBricks;
      case "Daily Work Done [DPR New]":
        return FontAwesomeIcons.trowel;
      case "Daily Work Done (DPR Labour)":
        return Icons.account_tree;
      case "Bill Generation":
        return Icons.description;
      case "Bill Generation - Direct":
        return FontAwesomeIcons.fileSignature;
      case "Advance Requisition Voucher":
        return Icons.add_business_outlined;
      case "Man Power":
        return Icons.groups_outlined;

    // Project Planning
      case "BOQ - Revised":
        return FontAwesomeIcons.diagramSuccessor;
      case "Work Order - Direct":
        return FontAwesomeIcons.fileContract;
      case "Work Order - BOQ":
        return Icons.assignment_outlined;

    // Masters
      case "Labour Creation":
        return FontAwesomeIcons.userPlus;

    // Accounts
      case "Site Voucher":
        return Icons.vertical_split_outlined;
      case "Staff Voucher":
        return FontAwesomeIcons.laptopFile;
      case "Cash Book/Staff":
        return FontAwesomeIcons.fileInvoiceDollar;
      case "Cash Book/Site":
        return Icons.add_card;

    // Payroll
      case "Staff L & P Slip":
        return Icons.receipt_long_outlined;

    // Machinery
      case "Machinery Indent":
        return Icons.precision_manufacturing;

      default:
        return Icons.apps_rounded;
    }
  }

// Old UI sizes: FontAwesome icons = 20, Material icons = 25
  double getMenuIconSize(String? name) {
    const fontAwesomeMenus = {
      "MRN Request (Indent)",
      "Site Request (Issue Slip)",
      "Inward",
      "Transfer Between Projects",
      "Transfer Between Sites",
      "Material Transfer Request",
      "Consumption",
      "Material Return",
      "Daily Work Done (DPR)",
      "Daily Work Done [DPR New]",
      "Bill Generation - Direct",
      "BOQ - Revised",
      "Work Order - Direct",
      "Labour Creation",
      "Staff Voucher",
      "Cash Book/Staff",
    };
    return fontAwesomeMenus.contains(name) ? 20 : 25;
  }

// ================== MODULE SECTION (OLD UI) ==================

  Widget buildModuleSection({
    required String title,
    required List<dynamic> items,
    required IconData Function(dynamic item) getIcon,
    required double Function(dynamic item) getIconSize,
    required String Function(dynamic item) getName,
    required VoidCallback Function(dynamic item) onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module title
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Card + grid
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 140,
                  childAspectRatio: 6 / 6,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  final item = items[i];

                  return InkWell(
                    onTap: onTap(item),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Icon box
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    getIcon(item),
                                    color: Colors.white,
                                    size: getIconSize(item),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Menu name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                getName(item),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
