import 'package:nicon/controller/punch_in_controller.dart';
import 'package:nicon/controller/requisitionslip_controller_new.dart';
import 'package:nicon/controller/site_location_controller.dart';
import 'package:nicon/home/menu/main_menu/workOrder_BOQ/workOrder_BOQ_entrylist.dart';
import 'package:nicon/home/menu/materials/material_return/material_return_entryList.dart';
import '../controller/billgenerationdirect_controller.dart';
import '../controller/cashbook_site_controller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/dailywrk_done_dprlabour_controller.dart';
import '../controller/dailywrk_done_dprnew_controller.dart';
import '../controller/inward_pending_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/sitevoucher_controller.dart';
import '../controller/staffvoucher_controller.dart';
import '../controller/transferbw_project_controller.dart';
import '../controller/transferbw_site_controller.dart';
import '../home/menu/accounts/cash_book_site/casebook_site_new.dart';
import '../home/menu/accounts/cash_book_staff/case_book_staff.dart';
import '../home/menu/accounts/site_voucher/site_voucher_new/site_voucher_entrylist_new.dart';
import '../home/menu/accounts/staff_voucher/staff_voucher_entrylist.dart';
import '../home/menu/daily_entries/advancereques_voucher_new/advance_req_entrylist_new.dart';
import '../home/menu/daily_entries/bill_generation/bill_generation_boq_entrylist.dart';
import '../home/menu/daily_entries/bill_generation_direct/bill_generation_entrylist.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_entrylist.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_main.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(labour)/daily_wrkdone_dpr_labour.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/daily_wrkdone_dpr_entrylistnew.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_entrylist.dart';
import '../home/menu/daily_entries/man_power_screens/man_power_entrylist.dart';
import '../home/menu/daily_entries/pre_approval/preapproval_main.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
import '../home/menu/daily_entries/subcontractor_attendance_VCPL/subattendance_site_entry_list.dart';
import '../home/menu/machinery/machinery_entrylist.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entrylist.dart';
import '../home/menu/main_menu/workOrder_Direct/workOrder_Direct_Entrylist.dart';
import '../home/menu/materials/consumption/consumption_list.dart';
import '../home/menu/materials/inward/inward_list.dart';
import '../home/menu/materials/materialTransferRequest/materialTransReq_list.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/menu/materials/mrn_request(preIndent)/mrnreq_preindent_list.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_list.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_list.dart';
import '../home/menu/payroll/requisitionslip/list_requisitionslip.dart';
import '../home/menu/repair/repair_Consumption_Entrylist.dart';
import '../models/home_menulistres_model.dart';
import '../models/report_list_model.dart';
import '../provider/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'advance_reqvoucher_new_controller.dart';
import 'boqrevised_controller.dart';
import 'company_nmr_controller.dart';
import 'consumption_controller.dart';
import 'mrn_request_indent_controller.dart';
import 'mrnrequest_preIndent_controller.dart';
import 'nmrweeklybill_controller.dart';


class Menu_Controller extends GetxController {
  LoginController loginController = Get.put(LoginController());
  DailyEntriesController dailyEntriesController=Get.put(DailyEntriesController());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  BillGenerationDirectController billGenerationDirectController=Get.put(BillGenerationDirectController());
  TransferBW_project_Controller transferBW_project_Controller=Get.put(TransferBW_project_Controller());
  TransferBt_Site_Controller transferBt_Site_Controller=Get.put(TransferBt_Site_Controller());
  // AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  AdvanceReqVoucherController_new advanceReqVoucherController_new =Get.put(AdvanceReqVoucherController_new());
  SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
  StaffVoucher_Controller staffVoucher_Controller=Get.put(StaffVoucher_Controller());
  MRN_Request_Controller mrn_request_controller=Get.put(MRN_Request_Controller());
  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());
  Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());
  InwardPending_Controller inward_controller = Get.put(InwardPending_Controller());
  CashBookSiteController cashBookSiteController=Get.put(CashBookSiteController());
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  // PreApprovalController preApprovalController=Get.put(PreApprovalController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  RequisitionSlipControllerNew requisitionSlipController = Get.put(RequisitionSlipControllerNew());
  PunchInController punchInController = Get.put(PunchInController());
  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller = Get.put(MRNRequest_PreIndent_Controller());

  RxList menuListDatas = [].obs;
  RxList reportListDatas = [].obs;

  RxString formName = "".obs;
  RxInt formMenuId = 0.obs;
  RxString commonMenuId = "0".obs;
  // List<SubMenuReports> subMenusReportList = [];
  // RxList<SubMenuReports> subMenusList = <SubMenuReports>[].obs;

  List<Menu> subMatList = [];
  List<Menu> subMainmenuList = [];
  List<Menu> dailyEntryList = [];
  List<Menu> accountsList = [];
  List<Menu> payrollList = [];
  List<Menu> machineryList = [];
  List<Menu> projPlanningList = [];


  Future getMenuList(BuildContext context) async {
    menuListDatas.value = [];

    print("User Id :: ${loginController.user.value.userId}");

    await MenuProvider.getMenuListProvider().then((value) {
      if (value != null) {
        if (value.success == true) {
          if (value.result!.isNotEmpty) {

            menuListDatas.value = value.result!;

          } else {
            BaseUtitiles.showToast("No Data Found");
          }
        } else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      } else {
        BaseUtitiles.showToast(
            'Something went wrong..'
        );
      }
    });
  }


  // Future getReportsList() async {
  //   print("User Id :: ${loginController.user.value.userId}");
  //   await MenuProvider.getReportsListProvider(loginController.user.value.userId!).then((value)  {
  //     if (value != null && value.length > 0) {
  //       reportListDatas.value = value;
  //       subMenusList.clear();
  //       for (var menu in reportListDatas.value) {
  //         subMenusList.addAll(menu.subMenu);
  //       }
  //       return reportListDatas.value;
  //     }
  //     update();
  //     return reportListDatas.value;
  //   });
  // }

  Future getReportsList() async {
    reportListDatas.value.clear();
    var response = await MenuProvider.getReportsListProvider();
    if (response != null) {
      if (response.success == true) {
        List<ReportResult> materialList = response.result!;
        if (materialList!.isNotEmpty) {
          reportListDatas.assignAll(materialList);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

// Small helper so each route is one line
  Future<void> _go(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<void> navigateToMenu(
      String value,
      String menuName,
      BuildContext context,
      ) async {
    switch (value) {
    // ==========================================================
    // MATERIALS
    // ==========================================================

      case "MRN Request (Indent)":
      // Non-Anusamm: always allowed
        if (!AppClient.isAnusamm) {
          await _go(context, MRN_RequestIndent_Entrylist(heading: menuName));
          return;
        }

        // Admin / Owner: always allowed
        final userType = loginController.user.value.userType;
        if (userType == "A" || userType == "O") {
          await _go(context, MRN_RequestIndent_Entrylist(heading: menuName));
          return;
        }

        // Others: only Tuesday & Wednesday
        await punchInController.getNetworkTime();
        if (!context.mounted) return;

        if (punchInController.dayName == "Tuesday" ||
            punchInController.dayName == "Wednesday") {
          await _go(context, MRN_RequestIndent_Entrylist(heading: menuName));
        } else {
          BaseUtitiles.showToast(
            "You can't save this record on this date. "
                "It is only allowed on Tuesday and Wednesday.",
          );
        }
        break;

      case "Site Request (Issue Slip)":
        await _go(context, MRNRequest_PreIndent_List(heading: menuName));
        break;

      case "Inward":
        await _go(context, Inward_ListScreen(heading: menuName));
        break;

      case "Transfer Between Projects":
        await _go(context, TransferBtweenProjects_Entrylist(heading: menuName));
        break;

      case "Transfer Between Sites":
        await _go(context, TransferBetweenSites_Entrylist(heading: menuName));
        break;

      case "Material Transfer Request":
        await _go(context, MatTransReqList(heading: menuName));
        break;

      case "Consumption":
        await _go(context, Consumption_List(heading: menuName));
        break;

      case "Material Return":
        await _go(context, MaterialReturnEntryList(heading: menuName));
        break;

    // ==========================================================
    // DAILY ENTRIES
    // ==========================================================

      case "SubContractor Attendance":
        await _go(context, SubAttendanceSiteEntryList(heading: menuName));
        break;

      case "Company NMR Attendance":
        await _go(context, Company_nmr_entrylist(heading: menuName));
        break;

      case "SubCont NMR Wkly Bill - Generation":
        await _go(context, Subcont_NMR_EntryListScreen_Site(heading: menuName));
        break;

      case "Daily Work Done (DPR)":
        await _go(context, DailyWork_done_DPR_EntryList(heading: menuName));
        break;

      case "Daily Work Done [DPR New]":
        await _go(context, DailyWork_done_DPR_EntryListNew(heading: menuName));
        break;

      case "Daily Work Done (DPR Labour)":
        await _go(context, DailyWrk_Done_DPR_Labour(0));
        break;

      case "Bill Generation":
        await _go(context, Bill_Generation_Boq_Entrylist(heading: menuName));
        break;

      case "Bill Generation - Direct":
        await _go(context, Bill_Generation_direct_Entrylist(heading: menuName));
        break;

      case "Advance Requisition Voucher":
        await _go(context, AdvReq_Voucher_EntryList_new(heading: menuName));
        break;

      case "Man Power":
        await _go(context, Man_Power_Entrylist(heading: menuName));
        break;

    // ==========================================================
    // ACCOUNTS
    // ==========================================================

      case "Site Voucher":
        await _go(context, SiteVoucher_EntryListNew(heading: menuName));
        break;

      case "Staff Voucher":
        await _go(context, Staff_Voucher_EntryListScreen(heading: menuName));
        break;

      case "Cash Book/Staff":
        await _go(context, Case_Book_Staff(heading: menuName));
        break;

      case "Cash Book/Site":
        await _go(context, CashBook_Site(heading: menuName));
        break;

    // ==========================================================
    // PROJECT PLANNING
    // ==========================================================

      case "BOQ - Revised":
        await _go(context, Boq_Revised_EntryList(heading: menuName));
        break;

      case "Work Order - Direct":
        await _go(context, WorkOrderDirect_EntryList(heading: menuName));
        break;

      case "Work Order - BOQ":
        await _go(context, WorkOrderBoqEntrylist(heading: menuName));
        break;

    // ==========================================================
    // PAYROLL
    // ==========================================================

      case "Staff L & P Slip":
        await _go(context, Requisitionslip_EntryList(heading: menuName));
        break;

    // ==========================================================
    // MACHINERY
    // ==========================================================

      case "Machinery Indent":
        await _go(context, MachineryIndentEntryList(heading: menuName));
        break;

      case "Machinery DPR":
        await _go(context, MachineryDPREntryList
          (heading: menuName));
        break;

      case "Repair Consumption":
        await _go(context, RepairConsumptionEntryList(heading: menuName));
        break;

    // ==========================================================
    // MASTERS
    // ==========================================================

      // case "Labour Creation":
      //   await _go(context, Lab_creation_EntryList(heading: menuName));
      //   break;
    }
  }
}
