class SubContractMachineryDailyWorkSaveModel {
  int? id;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? billStatus;
  double? totalAmount;
  String? refNo;
  String? remarks;
  int? createdBy;
  int? verifyBy;
  String? verifyStatus;
  int? approvedBy;
  String? approveStatus;
  List<SubContractMachineryDailyWorkDetSaveModel>?
  subContractMachineryDailyWorkdetLink;

  SubContractMachineryDailyWorkSaveModel({
    this.id,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.billStatus,
    this.totalAmount,
    this.refNo,
    this.remarks,
    this.createdBy,
    this.verifyBy,
    this.verifyStatus,
    this.approvedBy,
    this.approveStatus,
    this.subContractMachineryDailyWorkdetLink,
  });

  factory SubContractMachineryDailyWorkSaveModel.fromJson(
      Map<String, dynamic> json) {
    return SubContractMachineryDailyWorkSaveModel(
      id: json['Id'] ?? 0,
      workNo: json['WorkNo'] ?? '',
      workDate: json['WorkDate'] ?? '',
      projectId: json['ProjectId'] ?? 0,
      siteId: json['SiteId'] ?? 0,
      subContractorId: json['SubContractorId'] ?? 0,
      billStatus: json['BillStatus'] ?? 'N',
      totalAmount: (json['TotalAmount'] as num?)?.toDouble() ?? 0.0,
      refNo: json['RefNo'] ?? '-',
      remarks: json['Remarks'] ?? '-',
      createdBy: json['CreatedBy'] ?? 0,
      verifyBy: json['VerifyBy'] ?? 0,
      verifyStatus: json['VerifyStatus'] ?? 'N',
      approvedBy: json['ApprovedBy'] ?? 0,
      approveStatus: json['ApproveStatus'] ?? 'N',
      subContractMachineryDailyWorkdetLink:
      (json['SubContractMachineryDailyWorkdetLink'] as List?)
          ?.map((e) =>
          SubContractMachineryDailyWorkDetSaveModel.fromJson(
              e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'WorkNo': workNo,
      'WorkDate': workDate,
      'ProjectId': projectId,
      'SiteId': siteId,
      'SubContractorId': subContractorId,
      'BillStatus': billStatus,
      'TotalAmount': totalAmount,
      'RefNo': refNo,
      'Remarks': remarks,
      'CreatedBy': createdBy,
      'VerifyBy': verifyBy,
      'VerifyStatus': verifyStatus,
      'ApprovedBy': approvedBy,
      'ApproveStatus': approveStatus,
      'SubContractMachineryDailyWorkdetLink':
      subContractMachineryDailyWorkdetLink
          ?.map((e) => e.toJson())
          .toList(),
    };
  }
}

class SubContractMachineryDailyWorkDetSaveModel {
  int? id;
  int? subContractDailyWorkMasId;
  int? subcontractMachineryWorkOrderDetId;
  int? scaleId;
  String? itemDesc;
  double? rate;
  double? startReading;
  double? endReading;
  double? totalReading;
  double? qty;
  double? amount;
  String? workRemarks;
  String? billStatus;

  SubContractMachineryDailyWorkDetSaveModel({
    this.id,
    this.subContractDailyWorkMasId,
    this.subcontractMachineryWorkOrderDetId,
    this.scaleId,
    this.itemDesc,
    this.rate,
    this.startReading,
    this.endReading,
    this.totalReading,
    this.qty,
    this.amount,
    this.workRemarks,
    this.billStatus,
  });

  factory SubContractMachineryDailyWorkDetSaveModel.fromJson(
      Map<String, dynamic> json) {
    return SubContractMachineryDailyWorkDetSaveModel(
      id: json['Id'] ?? 0,
      subContractDailyWorkMasId:
      json['SubContractDailyWorkMasId'] ?? 0,
      subcontractMachineryWorkOrderDetId:
      json['SubcontractMachineryWorkOrderDetId'] ?? 0,
      scaleId: json['ScaleId'] ?? 0,
      itemDesc: json['ItemDesc'] ?? '',
      rate: (json['Rate'] as num?)?.toDouble() ?? 0.0,
      startReading: (json['StartReading'] as num?)?.toDouble() ?? 0.0,
      endReading: (json['EndReading'] as num?)?.toDouble() ?? 0.0,
      totalReading: (json['TotalReading'] as num?)?.toDouble() ?? 0.0,
      qty: (json['Qty'] as num?)?.toDouble() ?? 0.0,
      amount: (json['Amount'] as num?)?.toDouble() ?? 0.0,
      workRemarks: json['WorkRemarks'] ?? '-',
      billStatus: json['BillStatus'] ?? 'N',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'SubContractDailyWorkMasId': subContractDailyWorkMasId,
      'SubcontractMachineryWorkOrderDetId':
      subcontractMachineryWorkOrderDetId,
      'ScaleId': scaleId,
      'ItemDesc': itemDesc,
      'Rate': rate,
      'StartReading': startReading,
      'EndReading': endReading,
      'TotalReading': totalReading,
      'Qty': qty,
      'Amount': amount,
      'WorkRemarks': workRemarks,
      'BillStatus': billStatus,
    };
  }
}