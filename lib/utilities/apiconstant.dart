import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApiConfig {

  static const String LIVE_ENDPOINT_1 = "http://49.204.233.151:8080/";

  static const String LIVE_ENDPOINT_2 = "http://122.173.84.247:8080/";

  static const String DEFAULT_BASE_URL = LIVE_ENDPOINT_1 + "VishaalAPI/";

  static String APIURL = "";
  static String WebURL = "";
  static String BASE_URL = "";

  static Future<void> initializeUrl() async {

    final liveEndpoint = await _getLiveEndpoint();

    if (liveEndpoint != null) {

      APIURL = "${liveEndpoint}VishaalAPI/";
      WebURL = "${liveEndpoint}Nicon/";

    } else {

      APIURL = DEFAULT_BASE_URL;
      WebURL = DEFAULT_BASE_URL.replaceAll(
        "VishaalAPI/",
        "Nicon/",
      );
    }

    BASE_URL = APIURL;

    // Update dependent constants
    ApiConstant.BASE_URL_CORE = APIURL;
    ApiConstant.Web_URL = WebURL;

    print("API URL: $APIURL");
    print("WEB URL: $WebURL");
  }

  static Future<String?> _getLiveEndpoint() async {

    final ip1 = Uri.parse(LIVE_ENDPOINT_1).host;
    final ip2 = Uri.parse(LIVE_ENDPOINT_2).host;

    if (await _isEndpointLive(ip1)) {
      return LIVE_ENDPOINT_1;
    } else if (await _isEndpointLive(ip2)) {
      return LIVE_ENDPOINT_2;
    }

    return null;
  }

  static Future<bool> _isEndpointLive(String ip) async {

    try {

      final socket = await Socket.connect(
        ip,
        8080,
        timeout: const Duration(seconds: 5),
      );

      socket.destroy();

      return true;

    } catch (e) {

      debugPrint("Endpoint $ip failed: $e");
      return false;
    }
  }
}

class AppClient {
  static late String packageName;

  static Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    packageName = info.packageName;
  }

  static bool get isAnusamm => packageName == "com.veenus.anusamm";
  static bool get isVrindhavana => packageName == "com.veenus.vrindhavana";
  static bool get isRKCPL => packageName == "com.veenus.rkcpl";
  static bool get isPrahkurti => packageName == "com.veenus.prahkurti";
  static bool get isNicon => packageName == "com.veenus.nicon";
}

class ApiConstant {

  static String BASE_URL_CORE = "";
  static String Web_URL = "";



  /// ---- Get API's ----

  static String get AUTHENTICATION => BASE_URL_CORE + "api/Login/LoginUser";
  static String get POSTREGISTRATIONSAVEAPI => BASE_URL_CORE + "api/Admin/UserCreation";
  static String get GETCOMPANYDROPDOWNLIST => BASE_URL_CORE + "api/GenericMaster/GetCompany";
  static String get GETSUPPLIEROSEXPENSESAPI => BASE_URL_CORE + "api/DailyEntriesReports/SupplierPaymentCheckingReport";
  static String get GETSUBCONTRACTOROSEXPENSESAPI => BASE_URL_CORE + "api/DailyEntriesReports/SubContractorConsolidatedReport";
  static String get GETPROJECTEXPENSESAPI => BASE_URL_CORE + "api/OtherReports/GetSiteExpensesDetailedReport";
  static String get DASHBOARD_API => BASE_URL_CORE + "api/DashBoard/GetMobileDashBoardView";
  static String get LABOURDASHBOARD_API => BASE_URL_CORE + "api/DashBoard/LabourDashBoard";
  static String get ADMINDASHBOARD_API => BASE_URL_CORE + "api/DashBoard/AdminDashBoard";
  static String get MATERIALDASHPROJWISE_API => BASE_URL_CORE + "api/DashBoard/DashBoardProjectWiseFilter";
  static String get MATERIALDASHMATHEAD_API => BASE_URL_CORE + "api/DashBoard/DashBoardMaterialHeadWise";
  static String get HRDASHBOARD_API => BASE_URL_CORE + "api/DashBoard/HRDashBoard";
  static String get HRDASHBOARDCARDS_API => BASE_URL_CORE + "api/DashBoard/HRDashBoardEmployeeName";
  static String get MATERIALDASHSUPWISE_API => BASE_URL_CORE + "api/DashBoard/DashBoardMaterialSupplierWise";
  static String get PUT_PLANNING_CALENDAR_API => BASE_URL_CORE + "api/DashBoard/UpdateMeetingScheduler";
  static String get HRDASHBOARD_PLANNINGCALEN_API => BASE_URL_CORE + "api/DashBoard/GetAllMeetingScheduler";



  static String get PENDINGLISTAPI => BASE_URL_CORE + "api/Menu/GetMobilePendingList";
  static String get REQNOLISTAPI => BASE_URL_CORE + "api/MaterialPurOrdMas/GetReqMasDataByPO";
  static String get NMRLISTAPPROVEAPI => BASE_URL_CORE + "api/SubContractorNMRBill/VerifyOrApproveNMRBill";
  static String get DIRECTLISTAPPROVEAPI => BASE_URL_CORE + "api/SubContractorWorkQty/VerifyOrApproveBillDirect";
  static String get WOLISTAPPROVEAPI => BASE_URL_CORE + "api/SubcontractWorkOrderMas/VerifyOrApproveWOBill";
  static String get REQNORENTALWORKLISTAPI => BASE_URL_CORE + "api/MaterialRentalWork/GetReqMasByWoId";

  static String get GETMRNFINALAPROVALAPI => BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetFinalApproveMasById";
  static String get GETMRPREAPROVALAPI => BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetTobeApprovalByIDS";
  static String get GETPROJECTDROPDOWNLIST => BASE_URL_CORE + "api/GenericMaster/GetProjectBasedOnUserAllocation";
  static String get GETPROJECTREPORTLIST => BASE_URL_CORE + "api/GenericMaster/GetCompanyWiseProject";

  static String get GETFROMPROAGAINSTMRNLIST => BASE_URL_CORE + "api/MaterialTransfer/FromPrject";
  static String get GETFROMSITELIST => BASE_URL_CORE + "api/StoreTransferPending/GetSiteDRP";
  static String get GETREPORTPROJECTDROPDOWNLIST => BASE_URL_CORE + "api/GenericMaster/GetProjects";
  static String get GETREPORTMATERIALDROPDOWNLIST => BASE_URL_CORE + "api/GenericMaster/GetMaterials";
  static String get GETALLMATERIALDROPDOWNLIST => BASE_URL_CORE + "api/GenericMaster/GetAllMaterial";
  static String get GETSUBCONTRACTLIST => BASE_URL_CORE + "api/GenericMaster/GetSubContractorByProject";

  static String get GETSUBCONTRACTLISTRPT => BASE_URL_CORE + "api/BOQReports/GetAllActiveSubContractorName";
  static String get GETCOMPANYLISTRPT => BASE_URL_CORE + "api/GenericMaster/GetCompany";
  static String get GETWRKORDERNOLIST => BASE_URL_CORE + "api/SubContractorWorkQty/GetWorkOrderNoDd";
  static String get GETBOQWRKORDERNOLIST => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/GetWorkOrderNoDd";
  static String get GETINVOICENOLIST => BASE_URL_CORE + "api/SubContractorNMRBill/GetBillNo";
  static String get SITEDROPDWONLISTAPI => BASE_URL_CORE + "api/GenericMaster/GetProjectWiseSiteList";

  static String get TOSITEDROPDWONLISTAPI => BASE_URL_CORE + "api/GenericMaster/GetToSitesByFrSiteDd";
  static String get GETMRNREPORTSLISTAPI => BASE_URL_CORE + "api/MaterialReqOrdMas/GetAllMRNReportViewListMas";
  static String get GETINWARDREPORTSLISTAPI => BASE_URL_CORE + "api/MaterialInward/GetInwardRepViewListMas";
  static String get GETREQTRACKERLISTAPI => BASE_URL_CORE + "api/AdminReports/MRNRequestTracker";
  static String get GETDPRLISTAPI => BASE_URL_CORE + "api/DailyEntriesReports/GetDPRNewReportMasMob";
  static String get GETONCLICK_PENDINGLISTAPI => BASE_URL_CORE + "api/CommonFile/GetPendingRecords";
  static String get MRNONITEMSELCT => BASE_URL_CORE + "api/MaterialReqOrdMas/GetAllMRNReportViewListDet";
  static String get INWARDONITEMSELCT => BASE_URL_CORE + "api/MaterialInward/GetInwardReportViewListDet";
  static String get DPRONITEMSELCT => BASE_URL_CORE + "api/DailyEntriesReports/GetDPRNewReportDetMob";
  static String get GETMATERIAL_SHOW_LIST => BASE_URL_CORE + "api/MaterialOpenStock/GetStockAtSiteViewListProjectWiseDetails";
  static String get GETMATERIALHEAD_REPORT => BASE_URL_CORE + "api/GenericMaster/GetMaterialHeadItem";
  static String get GETDPRNEWHEAD_LIST => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetHeadNameDd";
  static String get GETBOQHEAD_LIST => BASE_URL_CORE + "api/BOQRevised/GetHeadItemBySite";
  static String get GETMANPOWERHEAD_LIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetMeasureHeadItems";
  static String get GETMATERIALSUBHEAD_REPORT => BASE_URL_CORE + "api/GenericMaster/GetMaterialSubByHead";
  static String get GETMATERIALBASEDSUBHEAD_REPORT => BASE_URL_CORE + "api/GenericMaster/GetMaterialSubItemWiseMaterial";
  static String get GETSUBCONT_ENTRY_SHOW_CLICK => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetLabourData";
  static String get GETSUBCONTATTEND_CLICK => BASE_URL_CORE + "api/SubContLabourAttendance/SubContLabcatBasedOnSubContDLR";
  static String get GETMANPOWER_CATEGORY_CLICK => BASE_URL_CORE + "api/GenericMaster/GetActiveLabourCategoryDd";
  static String get GETMANPOWER_EDIT_LEVEL3LIST => BASE_URL_CORE + "api/MaterialReqOrdMas/GetLevel3ItemIds";
  static String get GETAUTONO_YEAR_WISE => BASE_URL_CORE + "api/GenericMaster/GetAutoNumber";
  static String get GETSUBCONT_ATTEN_ENTRY_LIST => BASE_URL_CORE + "api/SubContLabourAttendance/GetAllSubContLabAtt";
  static String get GETMENU_LIST_API => BASE_URL_CORE + "api/Menu/GetMobileMenu";
  static String get GETREPORT_LIST_API => BASE_URL_CORE + "api/Menu/GetMobileMenuReport";
  static String get GETCONTROLL_RIGHTS_ENTRYLIST => BASE_URL_CORE + "api/Admin/GetMenuRightsBasedonMenuIdUserID";
  static String get EDIT_SUBCONT_ENTRYLIST_API => BASE_URL_CORE + "api/SubContLabourAttendance/GetSubContLabAttById";
  static String get GETSUBCONT_NMR_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorNMRBill/GetAllNMRBill";
  static String get GETSUBCONT_NMR_ITEM_LIST => BASE_URL_CORE + "api/SubContractorNMRBill/GetSubContNMRPaymentGeneration";
  static String get GETSUBCONT_NMR_CHECKSTATUS => BASE_URL_CORE + "api/SubContractorNMRBill/GetDetailsNmrBill";
  static String get GETSUBCONT_NMR_COUNT_CHECKSTATUS => BASE_URL_CORE + "api/SubContractorNMRBill/GetNMRBillCount";
  static String get EDIT_NMR_DEDUCTION => BASE_URL_CORE + "api/SubContractorNMRBill/GetNMRBillById";
  static String get GET_DPR_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorDailyWork/GetAllDailyWorkMas";
  static String get GET_DPR_SUBCONTRACTOR_LIST => BASE_URL_CORE + "api/SubContractorDailyWork/GetSubcontractorNameDailyWrk";
  static String get GET_DPR_ITEM_LIST => BASE_URL_CORE + "api/SubContractorDailyWork/GetDPRDetLoad";
  static String get GET_DPR_EDIT_API => BASE_URL_CORE + "api/SubContractorDailyWork/GetDPRDetById";
  static String get GET_DPRNEW_SUBCONTRACTOR_LIST => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetDPRNewSubcontractor";
  static String get GET_DPRNEW_MATERIAL_API => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetMaterialNameDd";
  static String get GET_DPRNEW_BOQDETAILSLIST => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetDetLoad";
  static String get GET_DPRNEW_EDIT_API => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetDPRByIdNew";
  static String get GET_DPRNEW_DET_EDIT_API => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetDPRDetByIdNew";
  static String get GET_DIRECTBILL_ADVANCE_BALANCE => BASE_URL_CORE + "api/SubContractorNMRBill/GetSubContractorAdvanceAmount";
  static String get GET_SUBCONT_ADD_LESS => BASE_URL_CORE + "api/SubContractorNMRBill/GetSubContractorAddLessSetUp";
  static String get GET_WRKORDER_ADD_LESS => BASE_URL_CORE + "api/SubContractorWorkQty/GetWorkOrderAddLess";
  static String get GET_DIRECTBILL_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorWorkQty/GetAllSubContractorWorkQty";
  static String get GET_BOQBILL_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/GetAllSubContractorWorkQty";
  static String get GET_MANPOWER_ENTRY_LIST => BASE_URL_CORE + "api/ManPower/GetAllManPower";
  static String get GET_MANPOWER_LEVEL3_LIST => BASE_URL_CORE + "api/ManPower/GetLevel3ItemManPower";
  static String get GETMAC_INDENT_ENTRY_LIST => BASE_URL_CORE + "api/Machinery/GetAllMachineryMaterialMRN";

  static String get GET_WORKORDDIR_ENTRY_LIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetAllSubcontractWorkOrderMasData";
  static String get GET_WORKORDBOQ_ENTRY_LIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetAllWorkOrderCreationBoQ";
  static String get GET_WORKORDBOQ_TERMSANDCONDITION => BASE_URL_CORE + "api/TermsAndCondition/GetAllTermsAndConditionSubcontractorWo";



  static String get GET_DIRECTBILL_CALCULATION_LIST => BASE_URL_CORE + "api/GenericMaster/GetAddLess";
  static String get GET_WORKORDER_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorWorkQty/GetWorkOrderDet";
  static String get GET_WORKORDERBOQ_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/GetBillBOQDetLoad";
  static String get EDIT_DIRECTBILL_API => BASE_URL_CORE + "api/SubContractorWorkQty/GetSubContractorWorkQtyById";
  static String get EDIT_WORKORDERDIRECT_API => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetlSubcontractWorkOrderById";


  static String get EDIT_BILLBOQ_API => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/GetSubContractorWorkQtyById";
  static String get EDIT_INWARDPENDING_API => BASE_URL_CORE + "api/MaterialInward/GetInwardDetById";
  static String get EDIT_TRANSFERBET_API => BASE_URL_CORE + "api/MaterialTransfer/GetMaterialTransferbtnProById";
  // static String EDIT_TRANSFERBET_SITE_API = BASE_URL_CORE + "api/StoreTransferPending/loadTransferBetweensiteDet";
  static String get EDIT_TRANSFERBET_SITE_API => BASE_URL_CORE + "api/MaterialSitetosite/GetMaterialTransferById";
  static String get EDIT_ADVANCEREQ_API => BASE_URL_CORE + "api/AdvanceReqVoucher/GetAdvanceReqVoucherById";
  static String get GETINWARD_ENTRY_LIST => BASE_URL_CORE + "api/MaterialInward/GetAllMaterialInward";
  static String get GETMATERIALINWARD_ALLDATAS => BASE_URL_CORE + "api/MaterialInward/GetInwardPendingById";
  static String get GETINWARDWOMAS_ALLDATAS => BASE_URL_CORE + "api/MaterialInward/InwardWoLoadMasById";
  static String get GETINWARDWODET_ALLDATAS => BASE_URL_CORE + "api/MaterialInward/InwardWoLoadDetById";
  static String get GETINWARDSTATUSCHECKAPI => BASE_URL_CORE + "api/MaterialInward/InwardMobilecheck";
  static String get GETTRANSFERSTATUSCHECKAPI => BASE_URL_CORE + "api/MaterialTransfer/checkForUpdateAndDelete";
  static String get GETTRANSPROJECT_ENTRY_LIST => BASE_URL_CORE + "api/MaterialTransfer/GetAllTransBetweenProject";
  static String get GET_MATTRANSREQ_LIST => BASE_URL_CORE + "api/MaterialTransferRequest/GetAllMaterialTransferRequestMas";
  static String get GET_TRANSBETSITE_ENTRYLIST => BASE_URL_CORE + "api/MaterialSitetosite/GetAllSitetoSiteMas";
  static String get GETCASHBOOK_SITE => BASE_URL_CORE + "api/AccountsReports/getCashBookSite";
  static String get GETCASHBOOK_STAFF => BASE_URL_CORE + "api/AccountsReports/getCashBookStaff";
  static String get GETACCOUNTTYPEDROPDOWNLIST => BASE_URL_CORE + "api/SiteVoucher/GetAccountType";
  static String get GETACCOUNTTYPEDROPDOWNLISTADVREQ => BASE_URL_CORE + "api/AdvanceReqVoucher/GetAdvReqVocAccTypeDropDown";
  static String get GetADVREQ_SITEWISEPAYMENTLIST => BASE_URL_CORE + "api/AdvanceReqVoucher/GetSupplierNdSubcontAdvanceReqVoucher";
  static String get GETPAYMODEDROPDOWNLIST => BASE_URL_CORE + "api/GenericMaster/GetPaymentMode";
  static String get GETPAYMENTDROPDOWNLIST => BASE_URL_CORE + "api/SiteVoucher/GetPaymentTypeDet";
  static String get GETPAYFORDROPDOWNLIST => BASE_URL_CORE + "api/SiteVoucher/GetAccountPayFor";
  static String get ACCOUNTNAMEDROPDWONLISTAPI => BASE_URL_CORE + "api/SiteVoucher/GetAccountName";
  static String get STAFFDROPDWONLISTAPI => BASE_URL_CORE + "api/StaffRequisition/GetStaffDd";
  static String get STAFFVOUSTAFFLISTAPI => BASE_URL_CORE + "api/StaffVoucher/GetAllStaffNameDropDown";
  static String get GET_ADVREQ_ENTRY_LIST => BASE_URL_CORE + "api/AdvanceReqVoucher/GetAllAdvanceReqVoucher";
  static String get GETSITEVOC_ENTRY_LIST => BASE_URL_CORE + "api/SiteVoucher/GetAllAccountSiteVoucher";
  static String get GETSTAFFVOC_ENTRY_LIST => BASE_URL_CORE + "api/StaffVoucher/GetAllStaffVoucher";
  static String get GET_SITEVOUCHER_EDIT_API => BASE_URL_CORE + "api/SiteVoucher/GetAccountSiteVoucherById";
  static String get GET_STAFFVOUCHERSITE_EDIT_API => BASE_URL_CORE + "api/StaffVoucher/GetStafVoucherById";
  static String get GET_STAFFVOUCHER_BANKNAMELIST_API => BASE_URL_CORE + "api/GenericMaster/GetBank";
  static String get GETMRNREQUEST_ENTRY_LIST => BASE_URL_CORE + "api/MaterialReqOrdMas/GetAllReqOrdMas";
  static String get GET_MATERIAL_EDIT_API => BASE_URL_CORE + "api/MaterialReqOrdMas/GetReqOrdMasById";
  static String get GET_SUPP_BILL_APP_EDIT_API => BASE_URL_CORE + "api/MaterialPurOrdBill/GetMaterialPurchaseOrdBillById";
  static String get GET_SUPP_BILL_DIRECT_APP_EDIT_API => BASE_URL_CORE + "api/MaterialPurOrdBillDirect/GetbyIdMaterialPurchaseOrdBillDirect";
  static String get GET_MATTRANSREQ_EDIT_API => BASE_URL_CORE + "api/MaterialTransferRequest/GetByIdMTR";
  static String get GET_COMPANY_NMRALLLISTAPI => BASE_URL_CORE + "api/NMRLabourAttendance/GetLabourCategoryDetails";
  static String get GET_CHECKAPPROVALLEVELAPI => BASE_URL_CORE + "api/MaterialReqOrdMas/CheckApprovalLevel";
  static String get GET_APPTYPE_API => BASE_URL_CORE + "api/MaterialReqOrdMas/ApprovalType";
  static String get GETMATERIALLIST => BASE_URL_CORE + "api/MaterialReqOrdMas/GetMRNMatByReqTypeProNdSite";
  static String get CHECKMATERIALLISTBALQTY => BASE_URL_CORE + "api/Admin/Getmaterialcheckingbalqty";
  static String get CHECKBALQTYPROSITE => BASE_URL_CORE + "api/MaterialQtyFixingMas/CheckBalQtyForProAndSite";
  static String get GETCONSUMPTION_ENTRY_LIST => BASE_URL_CORE + "api/MaterialExpenseMas/GetAllMaterialExpenses";
  static String get GETSTOCKMATERIALLIST => BASE_URL_CORE + "api/MaterialExpenseMas/GetMaterialBasedOnProjAndSite";
  static String get GETCONSTYPELIST => BASE_URL_CORE + "api/MaterialExpenseMas/GetExpenseTypeAll";
  static String get GETSTOCKLISTMATERIALWISE => BASE_URL_CORE + "api/MaterialReqOrdMas/MrnApprovalStockList";
  static String get GET_CONSUM_EDIT_API => BASE_URL_CORE + "api/MaterialExpenseMas/GetMaterialExpensesById";
  static String get GET_MANPOWER_EDIT_API => BASE_URL_CORE + "api/ManPower/GetManPowerById";
  static String get GET_BOQ_ENTRY_LIST => BASE_URL_CORE + "api/BOQRevised/GetAllBOQRevise";
  static String get GET_APP_DET_LIST => BASE_URL_CORE + "api/BOQRevised/GetBOQRevisedByIdApprove";
  static String get GETREVISEDITEMLIST => BASE_URL_CORE + "api/BOQRevised/GetBOQItemDescription";
  static String get GETWORKORD_BOQITEMLIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetL2L3Item";
  static String get GET_BOQREVISED_EDIT_API => BASE_URL_CORE + "api/BOQRevised/GetBOQRevisedById";
  static String get GETREQUISITIONSLIP_ENTRY_LIST => BASE_URL_CORE + "api/StaffRequisition/GetAllStaffRequisitionSlip";
  static String get GET_REQUISITION_EDIT_API => BASE_URL_CORE + "api/StaffRequisition/GetStaffRequisitionSlipById";
  static String get GET_TRAACK_PENDING_ALLDATAS_API => BASE_URL_CORE + "api/MaterialAckMas/getByIdAckTransferPending";
  static String get GET_COMPANY_NMRENTRYLISTAPI => BASE_URL_CORE + "api/NMRLabourAttendance/GetAllNMRSubLabAttenance";
  static String get GET_LABOUR_STATUS_LISTAPI => BASE_URL_CORE + "api/NMRLabourAttendance/GetActiveLabourAttendanceType";
  static String get GET_COMPANY_NMRLISTEDIT_API => BASE_URL_CORE + "api/NMRLabourAttendance/GetNMRSubContLabAttById";
  static String get GET_POAPPROVAL_SUPPLIERBUILDLIST_API => BASE_URL_CORE + "api/MaterialPurOrdMas/GetSupplierListByMatId";
  static String get GET_PUNCHIN_STATUS => BASE_URL_CORE + "api/PunchInandOut/GetPunchStatus";
  static String get OLDTODAY_PUNCHIN_STATUS => BASE_URL_CORE + "api/PunchInandOut/GetAllPunInAndOut";
  static String get GET_PUNCH_TYPE_LIST => BASE_URL_CORE + "api/PunchInandOut/GetAllPunchInandOutType";
  static String get GET_STAFF_REQ_TYPE_LIST => BASE_URL_CORE + "api/StaffRequisition/GetStaffReqType";
  static String get GET_MRNVERIFICATION_PENDINGLIST => BASE_URL_CORE + "api/MaterialReqOrdMas/GetAllReqordVerifyPending";
  static String get GET_MRNGM_AMAPPROVAL_PENDINGLIST => BASE_URL_CORE + "api/MaterialReqOrdMas/GetMRNPreApprovalPendingAMGM";
  static String get GET_MRNPREAPPROVAL_PENDINGLIST => BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetAllTobePreApproval";
  static String get GET_MRNAPPROVAL_PENDINGLIST => BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetAllFinalApprovalMas";
  static String get GET_PO_PENDINGLIST => BASE_URL_CORE + "api/MaterialPurOrdMas/GetAllPendingPO";
  static String get GET_POVERIFICATION_PENDINGLIST => BASE_URL_CORE + "api/MaterialPurOrdMas/GetPurOrdVerificationList";
  static String get GET_POAPPROVAL_PENDINGLIST => BASE_URL_CORE + "api/MaterialPurOrdMas/GetAllPoAppPending";
  static String get GET_INWARD_PENDINGLIST => BASE_URL_CORE + "api/MaterialInward/GetAllInwardPending";
  static String get GET_INWARDWO_PENDINGLIST => BASE_URL_CORE + "api/MaterialInward/GetInwardPendingWo";
  static String get GET_TRANSFER_PENDINGLIST => BASE_URL_CORE + "api/MaterialTransfer/GetAllTransferPendingView";
  static String get GET_TRANSFERREQUEST_PENDINGLIST => BASE_URL_CORE + "api/MaterialTransferRequest/GetAllTransferRequestPendingViewMTR";
  static String get GET_TRANSFER_ACKNOWLEGDEMENT_LIST => BASE_URL_CORE + "api/MaterialAckMas/getAllTranferAckPending";
  static String get GET_SUBCON_APPROVAL_LIST => BASE_URL_CORE + "api/SubContLabourAttendance/GetToBeApproved";
  static String get GET_TRANSFER_DET_LIST => BASE_URL_CORE + "api/MaterialTransfer/DetLoadBasedOnNo";
  static String get GET_TRANSFER_VERIFI_PEND_LIST => BASE_URL_CORE + "api/MaterialTransferRequestVerify/GetMTRVerifyDetails";
  static String get GET_TRANSFER_APPROVE_PEND_LIST => BASE_URL_CORE + "api/MaterialTransferRequestApproval/GetAllMTRToBeApproval";
  static String get GET_SITEREQ_VERIFY_PEND_LIST => BASE_URL_CORE + "api/SiteRequest/GetAllPreIndentVerifyPendingDetails";
  static String get GET_SITEREQ_APPROVAL_PEND_LIST => BASE_URL_CORE + "api/SiteRequest/GetAllTobePreIndentApproval";
  static String get GET_SUPPLIER_QUOTE_APPROVAL_LIST => BASE_URL_CORE + "api/MaterialQuote/GetSupplierQuoteApproval";
  static String get GET_PURCHASE_ORDER_NO_API => BASE_URL_CORE + "api/GenericMaster/GetAutoNoBasedOnEntryDate";
  static String get GET_PURCHASE_ORDER_NO_COMPANYWISE_API => BASE_URL_CORE + "api/GenericMaster/GetAutoNoCompanyWiseWithYearPo";
  static String get GET_SUP_BILL_INWARDNO_API => BASE_URL_CORE + "api/MaterialPurOrdBill/GetGRNDd";
  static String get GET_SUP_BILL_INWIMAGE_API => BASE_URL_CORE + "api/MaterialInward/GetInwardImageList";
  static String get GET_SUP_BILL_POIMAGE_API => BASE_URL_CORE + "api/MaterialPurOrdBillDirect/GetPurOrdBillImageList";

  static String get GET_PENDING_QUOTE_LIST => BASE_URL_CORE + "api/MaterialQuote/GetPendingQuote";
  static String get GET_VERIFY_QUOTE_LIST => BASE_URL_CORE + "api/MaterialQuote/GetQuoteVerificationPending";
  static String get GET_APPROVE_QUOTE_LIST => BASE_URL_CORE + "api/MaterialQuote/GetQuoteApprovalPending";
  static String get GET_STORETRANS_PEND_LIST => BASE_URL_CORE + "api/StoreTransferPending/GetAllStoreTransferPending";
  static String get GETSUBCONT_DPRAPPROVAL => BASE_URL_CORE + "api/SubContractorDailyWork/GetToBeApprovedDPR";
  static String get GETNMRBILLVERIFYLIST => BASE_URL_CORE + "api/SubContractorNMRBill/GetNMRVerificationPending";
  static String get GETNMRBILLAPPROVELIST => BASE_URL_CORE + "api/SubContractorNMRBill/GetNMRApprovalPending";
  static String get GETBILLDIRECTVERIFYLIST => BASE_URL_CORE + "api/SubContractorWorkQty/GetSubContractorBillVerificationPending";
  static String get GETBILLBOQVERIFYLIST => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/GetToBeVerifiedBillBoq";
  static String get GETBILLBOQAPPROVELIST => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/GetToBeApprovedBillBoq";
  static String get GETBILLDIRECTAPPROVELIST => BASE_URL_CORE + "api/SubContractorWorkQty/GetSubContractorToBeApproved";
  static String get GETSTAFFREQVERIFYLIST => BASE_URL_CORE + "api/StaffRequisition/GetToBeVerified";
  static String get GETSTAFFREQAPPLIST => BASE_URL_CORE + "api/StaffRequisition/GetToBeApproved";
  static String get GETSTORETRANSPENDINGVIEWLIST => BASE_URL_CORE + "api/StoreTransferPending/GetReqordDetailsById";
  static String get GETBOQAPPROLIST => BASE_URL_CORE + "api/BOQRevised/GetBOQRevisedToBeApproved";
  static String get GETSITEVOUCHERAPPROLIST => BASE_URL_CORE + "api/SiteVoucher/GetAccountSiteVoucherToBeApproved";
  static String get GETADVREQAPPROLIST => BASE_URL_CORE + "api/AdvanceReqVoucher/GetAdvanceReqToBeApproved";
  static String get GETCOMPANYNMRAPPROLIST => BASE_URL_CORE + "api/NMRLabourAttendance/GetApprovalPendingNMRAttendance";
  static String get GETPO_SUPTRADERSAGEN_PENDLIST => BASE_URL_CORE + "api/MaterialPurOrdMas/GetAllPendingPOBySupplierCategory";
  static String get GET_ONDUTY_PUNCHINOUT_VERIFILIST => BASE_URL_CORE + "api/PunchInandOut/GetAllOnDutyverificationpending";
  static String get GET_NONALLOT_PUNCHINOUT_VERIFILIST => BASE_URL_CORE + "api/PunchInandOut/GetAllPunchinandoutverificationpending";
  static String get GET_ONDUTY_PUNCHINOUT_APPRLIST => BASE_URL_CORE + "api/PunchInandOut/GetAllOnDutyApprovepending";
  static String get GET_NONALLOT_PUNCHINOUT_APPRLIST => BASE_URL_CORE + "api/PunchInandOut/GetAllPunchinandoutApprovepending";
  static String get GET_WORKORDERVERIFYLIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetAllSubcontractWorkOrderToBeVerifyData";
  static String get GET_WORKORDERBOQ_VERIFYLIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetWorkOrderVerificationPendingBOQ";
  static String get GET_SUPPLIER_BILL_APPROVAL_LIST => BASE_URL_CORE + "api/MaterialPurOrdBill/GetBillToBeApprovedNotifctn";
  static String get DIRECT_TRANSFERBETPROJECTS_PENDING => BASE_URL_CORE + "api/MaterialTransfer/GetMaterialDirectTransferApprovalPending";

  static String get GET_WORKORDERAPPROVALLIST => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetAllSubcontractWorkOrderVerifyData";
  static String get GET_MANPOWERAPPROVALLIST => BASE_URL_CORE + "api/ManPower/GetManPowerApprovalPending";

  static String get GET_PREVIOUSLEAVE_TAKEN_LIST => BASE_URL_CORE + "api/PayRollReport/GetPreviousLeaveAndPermissionTakenCount";

  static String get GET_MACHINERY_EDIT_API => BASE_URL_CORE + "api/Machinery/GetMachineryReqOrdMasById";
  static String get GET_MACHINERY_VERIFY_API => BASE_URL_CORE + "api/Machinery/GetMachineryVerifyPendingReqOrdById";
  static String get GET_MACHINERY_PREAPPROVE_API => BASE_URL_CORE + "api/Machinery/GetMachineryTobeApprovalByIDS";
  static String get GET_MACHINERY_APPROVE_API => BASE_URL_CORE + "api/Machinery/GetMachineryFinalApproveMasById";
  static String get GETMACHINERYMATERIALLIST => BASE_URL_CORE + "api/GenericMaster/GetAllMachineryMaterialMas";


  static String get GETPROJECTDROPDOWNLISTALL => BASE_URL_CORE + "api/CommonFile/GetProjectAll";
  static String get GETSITE_REPORTS => BASE_URL_CORE + "api/CommonFile/GetSiteReport";
  static String get GETATTENDANCEREPORTLIST => BASE_URL_CORE + "api/SubContLabourAttendance/GetDlrReportViewListMas";
  static String get ATTENDANCEONITEMSELCT => BASE_URL_CORE + "api/SubContLabourAttendance/GetDlrReportViewListDet";
  static String get GETMATERIAL_DETAILS_LIST => BASE_URL_CORE + "api/MaterialOpenStock/GetStockAtSiteDetails";
  static String get GET_DPR_NEW_ENTRY_LIST => BASE_URL_CORE + "api/SubContractorDailyWorkNew/GetAllDailyWorkMasNew";

  static String get GETMRNREQUEST_PREINDENT_ENTRYLIST => BASE_URL_CORE + "api/SiteRequest/GetAllPreIndent";
  static String get GET_MATERIALREQPREINDEDNT_EDIT_API => BASE_URL_CORE + "api/SiteRequest/GetPreIndentByID";
  static String get GET_PENDING_QUOTE_MORE_API => BASE_URL_CORE + "api/MaterialQuote/GetQuoteDetView";
  static String get GET_STORETRANFER_MORE_API => BASE_URL_CORE + "api/StoreTransferPending/GetStoreTransferPendingView";
  static String get GET_POSUPTRADAGEN_MORE_API => BASE_URL_CORE + "api/MaterialPurOrdMas/GetPendingPoViewSubBySupplierCategory";


  static String get MRN_VERIFICATION_MOREDETAILS => BASE_URL_CORE + "api/MaterialReqOrdMas/GetReqOrdMasById";
  static String get MRN_PREAPPROVAL_MOREDETAILS => BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetTobeApprovalByIDS";
  static String get MRN_FINALAPPROVAL_MOREDETAILS => BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetFinalApproveMasById";
  static String get PENDING_PO_MOREDETAILS => BASE_URL_CORE + "api/MaterialPurOrdMas/GetPendingPoViewSub";
  static String get POVERIFICATION_MOREDETAILS => BASE_URL_CORE + "api/MaterialPurOrdMas/GetPurchaseOrderDetaisloadById";
  static String get PORENTALVERIFICATION_MOREDETAILS => BASE_URL_CORE + "api/MaterialRentalWork/GetRentalWorkById";

  static String get INWARD_MOREDETAILS => BASE_URL_CORE + "api/MaterialInward/GetInwardPendingById";
  static String get INWARDWO_MOREDETAILS => BASE_URL_CORE + "api/MaterialInward/GetInwardWoPendingMaterialList";
  static String get TRANSFERPENDING_MOREDETAILS => BASE_URL_CORE + "api/MaterialTransfer/GetTransferDetails";
  static String get TRANSFER_REQUESTPENDING_MOREDETAILS => BASE_URL_CORE + "api/MaterialTransferRequest/GetMTRViewAndSearch";
  static String get TRANSFERACKPENDING_MOREDETAILS => BASE_URL_CORE + "api/MaterialAckMas/getByIdAckTransferPending";
  static String get TRANSFERREQ_PEND_APPROVE_MOREDETAILS => BASE_URL_CORE + "api/MaterialTransferRequest/GetByIdMTR";
  static String get WORKORDERBOQ_HEADITEM => BASE_URL_CORE + "api/SubcontractWorkOrderMas/GetHeadItemName";



  /// ---Reports---


  static String get GETSUPPLIER_REPORTS => BASE_URL_CORE + "api/SupplierMas/GetAllSupplierMas";
  static String get GET_SITE_LOCATION => BASE_URL_CORE + "api/PunchInandOut/GetProjectForPinLoc";
  static String get GET_INWARD_IMAGE_LIST => BASE_URL_CORE + "api/MaterialInward/GetInwardImageList";
  static String get GET_DLR_IMAGE_LIST => BASE_URL_CORE + "api/SubContLabourAttendance/GetDLRImageList";
  static String get GET_VOC_IMAGE_LIST => BASE_URL_CORE + "api/SiteVoucher/GetSiteVoucherImageList";
  static String get GET_STAFF_VOC_IMAGE_LIST => BASE_URL_CORE + "api/StaffVoucher/GetStaffVoucherImageList";

  static String get GET_DPR_IMAGE_LIST => BASE_URL_CORE + "api/SubContractorDailyWork/GetDPRImageList";
  static String get GETPUNCHREPORTSTAFF => BASE_URL_CORE + "api/GenericMaster/GetEmployee";





  /// ----- Put API's -----

  static String get PUTCHANGEPASSWORDAPI => BASE_URL_CORE + "api/Admin/UpdatePassword";
  static String get PUT_NMR_UPDATE_API => BASE_URL_CORE + "api/SubContractorNMRBill/UpdateNMRBill";
  static String get PUT_DPR_UPDATE_API => BASE_URL_CORE + "api/SubContractorDailyWork/UpdateDailyWork";
  static String get PUT_DPR_NEW_UPDATE_API => BASE_URL_CORE + "api/SubContractorDailyWorkNew/UpdateDailyWorkNew";
  static String get PUT_DIRECTBILL_UPDATE_API => BASE_URL_CORE + "api/SubContractorWorkQty/UpdateSubContractorWorkQty";
  static String get PUT_WORKORDER_UPDATE_API => BASE_URL_CORE + "api/SubcontractWorkOrderMas/UpdateWorkOrder";

  static String get PUT_DIRECTBOQ_UPDATE_API => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/UpdateSubContractorWorkQty";
  static String get PUT_POAPPROVAL_API => BASE_URL_CORE + "api/MaterialPurOrdMas/ApproveSelectedRowById";
  static String get PUT_POVERIFY_API => BASE_URL_CORE + "api/MaterialPurOrdMas/VerifySelectedRowsbyId";
  static String get PUT_INWARDPENDING_UPDATE_API => BASE_URL_CORE + "api/MaterialInward/UpdateMaterialInward";
  static String get PUT_TRANSFERBET_SITE_UPDATE_API => BASE_URL_CORE + "api/MaterialSitetosite/UpdateMaterialSitetoSiteMas";
  static String get PUT_ADVREQ_UPDATE_API => BASE_URL_CORE + "api/AdvanceReqVoucher/UpdateAdvanceReqVoucher";
  static String get PUT_SITEVOUCHER_UPDATE_API => BASE_URL_CORE + "api/SiteVoucher/UpdateAccountSiteVoucher";
  static String get PUT_STAFFVOUCHER_UPDATE_API => BASE_URL_CORE + "api/StaffVoucher/UpdateAccountStafVoucher";
  static String get PUT_MATERIALREQUEST_UPDATE_API => BASE_URL_CORE + "api/MaterialReqOrdMas/UpdateReqOrdMas";
  static String get PUT_MACHINERY_UPDATE_API => BASE_URL_CORE + "api/Machinery/UpdateMachineryReqOrdMas";
  static String get PUT_MACHINERY_PREAPPROVE_API => BASE_URL_CORE + "api/Machinery/UpdateMachineryPreApprovalMas";

  static String get PUT_Conum_UPDATE_API => BASE_URL_CORE + "api/MaterialExpenseMas/UpdateMaterialExpenses";
  static String get PUT_BOQREVISED_UPDATE_API => BASE_URL_CORE + "api/BOQRevised/UpdateBoqRevise";
  static String get PUT_BOQREVISED_APPROVE_API => BASE_URL_CORE + "api/BOQRevised/ApproveBoqRevise";
  static String get PUT_REQUISITIONSLIP_UPDATE_API => BASE_URL_CORE + "api/StaffRequisition/UpdateStaffRequisitionSlip";
  static String get PUT_MRNFINALAPPROVAL_APPROVE_API => BASE_URL_CORE + "api/MaterialPreApprovalRequest/UpdateFinalApprovalMas";
  static String get PUT_SUPP_BILL_APPROVE_API => BASE_URL_CORE + "api/MaterialPurOrdBill/UpdatematerialPurOrdBillMas";

  static String get PROJECT_NAME_TRANSFER => BASE_URL_CORE + "api/GenericMaster/ToProDiff";
  static String get TOPROJECT_NAME_TRANSFER => BASE_URL_CORE + "api/GenericMaster/GetAllToPro";
  static String get PUT_MATERIALREQUEST_PREINDENT_UPDATE_API => BASE_URL_CORE + "api/SiteRequest/UpdatePreIndent";
  static String get PUT_PENDING_QUOTE_API => BASE_URL_CORE + "api/MaterialQuote/SubmitQuote";
  static String get PUT_QUOTE_REVERT_API => BASE_URL_CORE + "api/MaterialQuote/RevertQuote";
  static String get PUT_QUOTE_VERIFY_APPROVAL_API => BASE_URL_CORE + "api/MaterialQuote/ApproveOrVerify";
  static String get PUT_TERMSANDCONDITION => BASE_URL_CORE + "api/TermsAndCondition/UpdateTermsAndConditionSubcontractorWo";



  /// ----- POST API's -----

  static String get SUBCONTLABATTAENDANCE_SAVE_API => BASE_URL_CORE + "api/SubContLabourAttendance/AddOrUpdateSubContLabAtt";
  static String get NMR_SAVE_DEDUCTION => BASE_URL_CORE + "api/SubContractorNMRBill/AddSubContractorNMRBill";
  static String get DPR_SAVE_API => BASE_URL_CORE + "api/SubContractorDailyWork/AddDailyWorkMas";
  static String get DPR_NEW_SAVE_API => BASE_URL_CORE + "api/SubContractorDailyWorkNew/AddDailyWorkMasNew";
  static String get DIRECTBILL_SAVE_API => BASE_URL_CORE + "api/SubContractorWorkQty/AddSubContractorWorkQty";
  static String get WORKORDERDIRECT_SAVE_API => BASE_URL_CORE + "api/SubcontractWorkOrderMas/AddWorkOrder";

  static String get BOQBILL_SAVE_API => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/AddSubContractorWorkQty";
  static String get INWARDPENDING_SAVE_API => BASE_URL_CORE + "api/MaterialInward/AddMaterialInward";
  static String get TRANSFERBET_SAVE_API => BASE_URL_CORE + "api/MaterialTransfer/AddOrUpdateMaterialTransfer";
  static String get MatTransReq_SAVE_API => BASE_URL_CORE + "api/MaterialTransferRequest/AddOrUpdateTransferReq";
  static String get MATTRANSREQ_VERIFY_API => BASE_URL_CORE + "api/MaterialTransferRequestVerify/ToVerify";
  static String get MATTRANSREQ_APPROVE_API => BASE_URL_CORE + "api/MaterialTransferRequestApproval/ToApproval";
  static String get TRANSFERBET_SITE_SAVE_API => BASE_URL_CORE + "api/MaterialSitetosite/AddMaterialSitetoSite";
  static String get TOKEN_SAVE => BASE_URL_CORE + "api/Login/AddUserTokenMas";
  static String get ADVREQ_SAVE => BASE_URL_CORE + "api/AdvanceReqVoucher/AddAdvanceReqVoucher";
  static String get TRANSFER_ACKNOW_ENTRYSAVE => BASE_URL_CORE + "api/MaterialAckMas/AddOrUpdateAck";
  static String get SITEVOUCHER_SAVE => BASE_URL_CORE + "api/SiteVoucher/AddAccountSiteVoucher";
  static String get STAFFVOUCHER_SAVE => BASE_URL_CORE + "api/StaffVoucher/AddStaffVoc";
  static String get MATERIALREQUEST_SAVE => BASE_URL_CORE + "api/MaterialReqOrdMas/AddReqOrdMas";
  static String get TERMSANDCONDITION_SAVEAPI => BASE_URL_CORE + "api/TermsAndCondition/AddTermsAndConditionSubcontractorWo";
  static String get MACHINERY_REQUEST_SAVE => BASE_URL_CORE + "api/Machinery/AddMachineryReqOrdMas";

  static String get COMPANY_NMR_SAVE_API => BASE_URL_CORE + "api/NMRLabourAttendance/AddOrUpdateNMRLabAttendance";
  static String get CONSUM_SAVE => BASE_URL_CORE + "api/MaterialExpenseMas/AddMaterialExpenses";
  static String get MANPOWER_SAVE => BASE_URL_CORE + "api/ManPower/AddManPower";
  static String get MANPOWER_EDIT => BASE_URL_CORE + "api/ManPower/UpdateManPower";
  static String get BOQREVISED_SAVE => BASE_URL_CORE + "api/BOQRevised/AddBoqRevised";
  static String get REQUISITION_SAVE => BASE_URL_CORE + "api/StaffRequisition/AddStaffRequisitionSlip";
  static String get ACCOUNTNAME_SAVE => BASE_URL_CORE + "api/SiteVoucher/AddAccountName";
  static String get ACCOUNTNAME_UPDATE => BASE_URL_CORE + "api/SiteVoucher/UpdateAccountName";
  static String get PUT_MRNPREAPPROVAL_APPROVE_API => BASE_URL_CORE + "api/MaterialPreApprovalRequest/UpdatePreApprovalMas";
  static String get POAMENDMENT_APPROVAL_SAVEAPI => BASE_URL_CORE + "api/MaterialInward/SaveSelectItemAndPoAmd";
  static String get PUNCH_IN => BASE_URL_CORE + "api/PunchInandOut/AddOrUpdatePunchAndOut";
  static String get PUNCH_IN_VERIFY_APPROVE => BASE_URL_CORE + "api/PunchInandOut/VerifyAndApprovePunchinandOut";

  static String get SET_SITE_LOCATION => BASE_URL_CORE + "api/PunchInandOut/AddPinLocation";
  static String get MATERIALREQUEST_PREINDENT_SAVE => BASE_URL_CORE + "api/SiteRequest/AddPreIndentDetails";


  /// ----- Delete API's -----
  static String get PO_APPROVE_DELETE => BASE_URL_CORE + "api/MaterialPurOrdMas/DeletePOVerification";
  static String get TRANSFER_VERIFICATION_DELETE => BASE_URL_CORE + "api/MaterialTransferRequestVerify/DeleteVerify";
  static String get TRANSFERREQ_PENDAPPROVAL_DELETE => BASE_URL_CORE + "api/MaterialTransferRequestApproval/DeleteMTRApproval";
  static String get DELETE_SUBCONT_ENTRYLIST_API => BASE_URL_CORE + "api/SubContLabourAttendance/DeleteSubContLabAtt";

  static String get DELETE_NMR_ENTRYLIST_API => BASE_URL_CORE + "api/SubContractorNMRBill/DeleteNMRBill";
  static String get DELETE_DPR_ENTRYLIST_API => BASE_URL_CORE + "api/SubContractorDailyWork/DeleteDailyWork";
  static String get DELETE_DPRNEW_ENTRYLIST_API => BASE_URL_CORE + "api/SubContractorDailyWorkNew/DeleteDailyWorkNew";

  static String get DELETE_DIRECTBILL_API => BASE_URL_CORE + "api/SubContractorWorkQty/DeleteSubContractorWorkQty";
  static String get DELETE_WORKORDERDIRECT_API => BASE_URL_CORE + "api/SubcontractWorkOrderMas/DeleteWorkOrder";
  static String get DELETE_WORKORDER_BOQ_API => BASE_URL_CORE + "api/SubcontractWorkOrderMas/DeleteWorkOrder";


  static String get DELETE_BOQBILL_API => BASE_URL_CORE + "api/SubContractorWorkQtyBOQ/DeleteSubContractorWorkQty";
  static String get DELETE_MANPOWERLIST_API => BASE_URL_CORE + "api/ManPower/DeleteManPower";
  static String get DELETE_MACHINERY_ENTRYLIST_API => BASE_URL_CORE + "api/Machinery/DeleteMachinery";

  static String get DELETE_INWARDPENDINGLIST_API => BASE_URL_CORE + "api/MaterialInward/DeleteMaterialInward";
  static String get DELETE_TRANSFERBET_API => BASE_URL_CORE + "api/MaterialTransfer/DeleteMaterialTransfer";
  static String get DELETE_TRANSFERBET_SITE_API => BASE_URL_CORE + "api/MaterialSitetosite/DeleteMaterialTransfer";
  static String get DELETE_ADVREQVOUCHER_API => BASE_URL_CORE + "api/AdvanceReqVoucher/DeleteAdvanceReqVoucher";
  static String get USERTOKENDELETE_API => BASE_URL_CORE + "api/Login/logout";
  static String get DELETE_SITEVOUCHER_ENTRYLIST_API => BASE_URL_CORE + "api/SiteVoucher/DeleteAccountSiteVoucher";
  static String get DELETE_STAFFVOUCHERSITE_ENTRYLIST_API => BASE_URL_CORE + "api/StaffVoucher/DeleteStaffVoucher";
  static String get DELETE_MATERIAL_ENTRYLIST_API => BASE_URL_CORE + "api/MaterialReqOrdMas/Delete";
  static String get DELETE_MATTRANSREQLIST_API => BASE_URL_CORE + "api/MaterialTransferRequest/DeleteTransferReq";
  static String get DELETE_CONSUM_ENTRYLIST_API => BASE_URL_CORE + "api/MaterialExpenseMas/DeleteMaterialExpenses";
  static String get DELETE_BOQREVISED_ENTRYLIST_API => BASE_URL_CORE + "api/BOQRevised/DeleteBOQRevised";
  static String get DELETE_REQUISITION_ENTRYLIST_API => BASE_URL_CORE + "api/StaffRequisition/DeleteStaffRequisitionSlip";
  static String get DELETE_ACCOUNTNAME_API => BASE_URL_CORE + "api/SiteVoucher/DeleteAccountName";
  static String get DELETE_COMPANYNMRLIST_API => BASE_URL_CORE + "api/NMRLabourAttendance/DeleteNMRSubContLabAtt";
  static String get DELETE_INWARD_IMAGE_API => BASE_URL_CORE + "api/MaterialInward/DeleteInwardImg";
  static String get DELETE_DLR_IMAGE_API => BASE_URL_CORE + "api/SubContLabourAttendance/DeleteDLRImg";
  static String get SITE_VOC_IMAGE_DELETE => BASE_URL_CORE + "api/SiteVoucher/DeleteSitVoucherImg";
  static String get STAFF_VOC_IMAGE_DELETE => BASE_URL_CORE + "api/StaffVoucher/DeleteStaffVoucherImg";
  static String get DPR_IMAGE_DELETE => BASE_URL_CORE + "api/SubContractorDailyWork/DeleteDPRImage";
  static String get DELETE_MATERIALREQPREINDENT_ENTRYLIST_API => BASE_URL_CORE + "api/SiteRequest/DeletePreIndent";
  static String get DELETE_TERMSANDCONDITION => BASE_URL_CORE + "api/TermsAndCondition/DeleteTermsAndConditionSubcontractorWo";


  static String get ACCOUNTDELETION => BASE_URL_CORE + "api/IOSUser/DeleteAccount";



///old API's
// static String DASHBOARD_API = BASE_URL + "api/CommonFile/GetDashboard";
// static String GETCHECKDEVICE = BASE_URL + "api/CommonFile/GetCheckDevice";
// static String GETVERSIONAPI = BASE_URL + "api/CommonFile/GetVersion";
// static String GETPROJECTCOMPANYWISE_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetProjectCompwise";
// static String GET_HEAD_DROPDOWNLIST = BASE_URL + "api/SubContDPRNew/GetHeadname";
// static String GETSUBCONTRACTDROPDOWNLIST = BASE_URL + "api/CommonFile/GetSubContractorAll";
// static String GETNMRBILLNO = BASE_URL + "api/SubcontNMR/GetProjectCumContractorNo";
// static String GETSUBCONTRACTBILLDIRLIST = BASE_URL + "api/SubContDirectBill/GetSubcontList";
// static String GETNMRREPORT = BASE_URL + "api/Report/GetNmrReportMas";
// static String GETLABOURLIST = BASE_URL + "api/CommonFile/GetLabour";
// static String GETCOMPANYDROPDOWNLIST = BASE_URL + "api/CommonFile/GetCompany";
// static String GETCOMPANYALL_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetCompanyAll";
// static String GETPROJECTEXPENSESAPI = BASE_URL + "api/CommonFile/GetProjectExpenses";
// static String GETSUPPLIEROSEXPENSESAPI = BASE_URL + "api/CommonFile/GetSupplierExpenses";
// static String GETSUBCONTRACTOREXPENSESAPI = BASE_URL + "api/CommonFile/GetSubConExpenses";
// static String GETSUPPLIERDROPDOWNAPI = BASE_URL + "api/CommonFile/GetSupplier";
// static String GETMATERIAL_SUBHAED_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialHead";
// static String GETMATERIALSUBDRPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialSub";
// static String GETMATERIALSUBMAT_REPORTLIST = BASE_URL + "api/CommonFile/GetMaterialSubReport";
// static String GETMATERIALWISEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialSubAll";
// static String GETMATERIALWISEREPORTLIST = BASE_URL + "api/CommonFile/GetMaterialSubAllReport";
// static String GETMATERIALWISE_SHOW_LIST = BASE_URL + "api/Report/GetStockAbstract";
// static String EDIT_TRANSFER_ACKNOW_API = BASE_URL + "api/MaterialTransferAck/GetTransferAckById";
// static String EDIT_TRANSFERBET_SITE_API = BASE_URL_CORE + "api/MaterialSitetosite/GetMaterialTransferById";
// static String GET_DPR_LABOUR_ENTRY_LIST = BASE_URL + "api/SubContDPRNewLabour/GetDPREntryList";
// static String GET_DPR_LABOUR_EDIT_API = BASE_URL + "api/SubContDPRNewLabour/GetDprById";
// static String GETSUBCONT_ATTEN_ENTRY_LIST = BASE_URL + "api/SubContLabAttendanceShiftBasis/GetShiftBasisAttendanceEntryList";
// static String GETSUBCONT_NMR_ADVANCE_BALANCE = BASE_URL + "api/SubcontNMR/GetSubContNMRAdvBalance";
// static String EDIT_SUBCONT_ENTRYLIST_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/GetShiftBasisAttendanceById";
// static String GETFROMPROJECTDROPDOWNLIST = BASE_URL + "api/MaterialTransferProject/GetFromProject";
// static String GETTRANSALLDATASLIST = BASE_URL + "api/MaterialTransferProject/GetReqById";
// static String GETTRANSITEMLIST = BASE_URL + "api/MaterialTransferProject/GetMaterialList";
// static String GETMATTRANSREQ = BASE_URL + "api/MaterialTransferRequest/GetMaterialListbyPRJSIT";
// static String GETMATERIALREQUESTTYPE = BASE_URL + "api/commonfile/Get_Material_Item_ReqType";
// static String GET_MRNREQ_ADD_QTY = BASE_URL + "api/CommonFile/GetScale";
// static String GET_TRAACK_ENTYLIST_API = BASE_URL + "api/MaterialTransferAck/GetTransferAckEntryList";
// static String GETONCLICK_PENDINGLISTDetAPI = BASE_URL + "api/CommonFile/GetPendingRecordsItemsList";
// static String GETONCLICK_AgainstMRNApprovalDetAPI = BASE_URL + "api/MaterialTransferProject/GetPendingRecordsItemsList";
// static String GET_PREAPPROVALENTRYLIST_API = BASE_URL + "api/PreApproval/GetPreApprovalEntryList";
// static String GET_PREAPPROVALTYPELIST_API = BASE_URL + "api/CommonFile/GetPreApprovalType";
// static String GET_PREAPPROVAL_EDIT_API = BASE_URL + "api/PreApproval/GetPreApprovalById";
// static const String GET_PUNCHIN_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandoutStatus";
// static String TODAY_PUNCHIN_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandOutTodayWiseReports";
// static String GET_TRANSFERACKPENDING_LIST = BASE_URL + "api/MaterialTransferAck/GetMatTransAckMaterialList";
// static String PUNCH_FILTER_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandOutReports";
// static String GET_INVOICEANDDCNOCHECK = BASE_URL + "api/MaterialInward/GetCheckNo";
// static String PUNCH_OUT = BASE_URL + "api/StaffPunching/PUTStaffPunchOutUpdate";
// static String PUNCH_OUT = BASE_URL + "api/StaffPunching/PutPunchOutUploadStaffImageSave";
// static String DPR_LABOUR_SAVE_API = BASE_URL + "api/SubContDPRNewLabour/POSTDprSave";
// static String SET_SITE_LOCATION = BASE_URL + "api/CommonFile/PostSetSiteLocationSave";
// static const String INWARDIMAGE_SAVEAPI = BASE_URL + "api/Image/PostInwardImageSave";
// static String SITEVOCIMAGE_SAVEAPI = BASE_URL + "api/Image/PostSiteVoucherImageSave";
// static String SUBIMAGE_SAVEAPI = BASE_URL + "api/Image/PostSubcontractorAttImageSave";
// static String DeviceModelAPI = BASE_URL + "api/CommonFile/POSTDeviceCheck";
// static String DELETE_DPRLABOUR_ENTRYLIST_API = BASE_URL + "api/SubContDPRNewLabour/DeleteDPR";
// static String DELETE_TRANSACKENTRYLIST_API = BASE_URL + "api/MaterialTransferAck/DeleteTransferAck";
// static String LABR_ATTEN_IMAGE_DELETE = BASE_URL + "api/Image/DeleteSubcontAttImage";
// static String DELETE_SUBCONT_ENTRYLIST_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/DeleteShiftBasisAttendance";
// static String DELETE_PREAPPROVAL_ENTRYLIST_API = BASE_URL + "api/PreApproval/DeletePreApproval";
// static String MRL_FINAL_APPROVIAL_DELETE = BASE_URL + "api/CommonFile/Deletelistdata";
// static String MRL_VERIFY_DELETE = BASE_URL + "api/CommonFile/Deletelistdata";
// static String MRL_PREAPPROVE_DELETE = BASE_URL + "api/CommonFile/Deletelistdata";
// static String POSTMATERIALSAVEAPI = BASE_URL + "api/CommonFile/POSTMaterial";
// static String SUBCONTLABATTAENDANCE_SAVE_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/POSTShiftBasisAttendanceSave";
// static String SUBCONTLABATTAENDANCE_SAVE_SITE_API = BASE_URL + "api/SubContLabAttendance/POSTAttendanceSavesite";
// static String POST_PREAPPROVAL_SAVE_API = BASE_URL + "api/PreApproval/POSTPreApprovalSave";
// static String PUT_TRANSFERACKNOW_UPDATE_API = BASE_URL + "api/MaterialTransferAck/PUTTransferAckUpdate";
// static String PUT_ACCOUNTNAME_UPDATE_API = BASE_URL + "api/CommonFile/PUTAccountNameUpdate";
// static String PUT_PREAPPROVAL_UPDATE_API = BASE_URL + "api/PreApproval/PUTPreApprovalUpdate";
// static String PUT_PREAPPROVAL_APPROVE_API = BASE_URL + "api/PreApproval/PUTPreApprovalApprove";
// static String PUT_MATERIALREQUEST_APPROVAL_API = BASE_URL + "api/MaterialRequest/PUTRequestApproval";
// static String PUT_COMPANYNMR_UPDATE_API = BASE_URL + "api/CompanyLabAttendance/PUTAttendanceUpdate";
// static String PUT_COMPANYNMR_APPROVAL_API = BASE_URL + "api/CompanyLabAttendance/PUTAttendanceApprove";
// static String PUT_DPR_APROVE_API = BASE_URL + "api/SubContDPR/PUTDprApprove";
// static String PUT_DPR_NEW_APROVE_API = BASE_URL + "api/SubContDPRNew/PUTDprApprove";
// static String PUT_DPR_LABOUR_APROVE_API = BASE_URL + "api/SubContDPRNewLabour/PUTDprApprove";
// static String PUT_DPR_LABOUR_UPDATE_API = BASE_URL + "api/SubContDPRNewLabour/PUTDprUpdate";
// static String PUT_UPPDATE_API = BASE_URL + "api/SubContLabAttendance/PUTAttendanceUpdate";
// static String PUT_UPPDATE_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/PUTShiftBasisAttendanceUpdate";
// static String PUT_APROVAL_API = BASE_URL + "api/SubContLabAttendance/PUTAttendanceApprove";
// static String PUT_APROVAL_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/PUTShiftBasisAttendanceApprove";
// static String PUT_TRANSFERBET_UPDATE_API = BASE_URL + "api/MaterialTransferProject/PUTTransferUpdate";
// static String PUT_MATTRANSREQ_UPDATE_API = BASE_URL + "api/MaterialTransferRequest/PUTMaterialReqTransferUpdate";
// static String PUT_SUBCONTNMRBILL_APPROVAL_API = BASE_URL + "api/SubcontNMR/PUTNMRApprove";
// static String PUT_BILLGEN_APPROVAL_API = BASE_URL + "api/SubContDirectBill/PUTDirectBillApprove";
// static const String PUT_ADVANCEREQ_APPROVAL_API = BASE_URL + "api/AdvRequisitionVoucher/PUTAdvVoucherApprove";
// static const String GETSUBCONTACTOR_REPORTS = BASE_URL + "api/CommonFile/GetSubContractor";
// static  String GETSUBCONTACTOR_REPORTS = BASE_URL + "api/CommonFile/GetSubCont_ProjwiseReport";
// static const String GET_SITE_LOCATION = BASE_URL + "api/CommonFile/GetSite_PinAllocation";
// static String GET_SITE_LOCATION = BASE_URL + "api/commonfile/GetSite_PinAllocationStatus";
// static String GETPROJECT_REPORTS = BASE_URL + "api/CommonFile/GetProjectReport";
// static String GETPROJECT_REQUISITIONSLIP = BASE_URL + "api/HR/GetLocation";
// static String GET_ATTEN_IMAGE_LIST = BASE_URL + "api/Image/GetSubContAttImageList";
// static String GET_REQLEAVETYPE_LIST = BASE_URL + "api/Report/GetStaffAttdReportMas";
// static String GETSTAFFLEAVECAL = BASE_URL + "api/CommonFile/GetStaffLeaveDetails";




}
