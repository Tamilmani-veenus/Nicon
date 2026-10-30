import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../controller/supplier_bill_approval_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class SupplierBillItemList extends StatefulWidget {
  const SupplierBillItemList({super.key});

  @override
  State<SupplierBillItemList> createState() =>
      _SupplierBillItemListState();
}

class _SupplierBillItemListState extends State<SupplierBillItemList> {

  bool isSgstMode = false;
  bool isIgstMode = false;
  double originalNetAmount = 0.0;
  double originalNetPayAmount = 0.0;
  bool originalAmountsInitialized = false;
  double originalNetSgst = 0.0;
  double originalNetCgst = 0.0;
  double originalNetIgst = 0.0;
  bool originalGstAmountsInitialized = false;


  void handleGstChange(String label, String value) {
    final controllers = supplierBillApprovalController.controllers;

    if (label == 'S-GST %') {
      final percentage = double.tryParse(value.trim()) ?? 0.0;

      if (percentage == 0) {
        isSgstMode = false;

        controllers['S-GST Amt']?.text = '0.00';
        controllers['C-GST %']?.text = '0.00';
        controllers['C-GST Amt']?.text = '0.00';

        isIgstMode = false;
      } else {
        isSgstMode = true;
        isIgstMode = false;

        controllers['C-GST %']?.text = value;
      }
    } else if (label == 'I-GST %') {
      final percentage = double.tryParse(value.trim()) ?? 0.0;

      if (percentage == 0) {
        isIgstMode = false;
        controllers['I-GST Amt']?.text = '0.00';
      } else {
        isIgstMode = true;
        isSgstMode = false;

        controllers['S-GST %']?.text = '0.00';
        controllers['S-GST Amt']?.text = '0.00';
        controllers['C-GST %']?.text = '0.00';
        controllers['C-GST Amt']?.text = '0.00';
      }
    }

    calculateSupplierBillAmounts();
    setState(() {});
  }

  void initializeOriginalAmounts() {
    if (originalAmountsInitialized) return;

    final controllers = supplierBillApprovalController.controllers;

    double getInitial(String key) =>
        double.tryParse(controllers[key]?.text.trim() ?? '') ?? 0.0;

    originalNetAmount = getInitial('Net Amount');
    originalNetPayAmount = getInitial('Net Pay Amount');

    originalNetSgst = getInitial('Net S-GST');
    originalNetCgst = getInitial('Net C-GST');
    originalNetIgst = getInitial('Net I-GST');

    originalAmountsInitialized = true;
  }
  final Map<String, IconData> fieldIcons = {
    'Freight Charges': Icons.local_shipping_outlined,
    'Labour Charges': Icons.engineering_outlined,
    'Other Charges': Icons.more_horiz,
    'S-GST %': Icons.percent,
    'S-GST Amt': Icons.currency_rupee,
    'C-GST %': Icons.percent,
    'C-GST Amt': Icons.currency_rupee,
    'I-GST %': Icons.percent,
    'I-GST Amt': Icons.currency_rupee,
    'TCS %': Icons.percent,
    'TCS Amt': Icons.currency_rupee,
    'TDS %': Icons.percent,
    'TDS Amt': Icons.currency_rupee,
    'Discount %': Icons.percent,
    'Disc Amt': Icons.currency_rupee,

    'Net S-GST': Icons.account_balance_wallet_outlined,
    'Net C-GST': Icons.account_balance_wallet_outlined,
    'Net I-GST': Icons.account_balance_wallet_outlined,

    'Round Off': Icons.tune,
    'Net Amount': Icons.receipt_long_outlined,
    'Advance Amount': Icons.payments_outlined,
    'Deduction Amount': Icons.remove_circle_outline,
    'Net Pay Amount': Icons.account_balance_wallet_outlined,
  };

  final Set<String> editableFields = {
    'Freight Charges',
    'Labour Charges',
    'Other Charges',
    'Remarks',
    'S-GST %',
    'I-GST %',
    'TCS %',
    'TDS %',
    'Discount %',
    'Round Off',
    'Deduction Amount',
  };


  final Color primaryColor = Color(0xFF4A3AFF);

  SupplierBillApprovalController supplierBillApprovalController = Get.put(SupplierBillApprovalController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: BaseUtitiles.getheightofPercentage(context, 6)),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Additional Charges, Taxes & Payment Details",
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
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSection(
                        title: 'Additional Charges',
                        subtitle: 'Enter extra bill charges',
                        icon: Icons.add_card_outlined,
                        fields: const [
                          'Freight Charges',
                          'Labour Charges',
                          'Other Charges',
                          'Remarks'
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildSection(
                        title: 'Taxes',
                        subtitle: 'Tax and discount breakdown',
                        icon: Icons.receipt_long_outlined,
                        fields: const [
                          'S-GST %',
                          'S-GST Amt',
                          'C-GST %',
                          'C-GST Amt',
                          'I-GST %',
                          'I-GST Amt',
                          'TCS %',
                          'TCS Amt',
                          'TDS %',
                          'TDS Amt',
                          'Discount %',
                          'Disc Amt',
                          'Net S-GST',
                          'Net C-GST',
                          'Net I-GST',
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildSection(
                        title: 'Payment Details',
                        subtitle: 'Bill total and payment summary',
                        icon: Icons.account_balance_wallet_outlined,
                        fields: const [
                          'Round Off',
                          'Net Amount',
                          'Advance Amount',
                          'Deduction Amount',
                          'Net Pay Amount',
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<String> fields,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E7F5)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, color: primaryColor, size: 21),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF858B98),
                      ),
                    ),
                  ],
                ),
              ),
              if (title == 'Additional Charges') ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: supplierBillApprovalController
                            .isGstInclusive.value,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            supplierBillApprovalController
                                .isGstInclusive.value = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'GST Inclusive',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF29234D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 14),

          // Text Fields
          LayoutBuilder(
            builder: (context, constraints) {
              final int columnCount =
              constraints.maxWidth >= 650 ? 3 : 2;

              const double spacing = 10;

              final double fieldWidth =
                  (constraints.maxWidth -
                      spacing * (columnCount - 1)) /
                      columnCount;

              return Wrap(
                spacing: spacing,
                runSpacing: 10,
                children: fields.map((field) {
                  return SizedBox(
                    width: fieldWidth,
                    child: _buildTextField(field),
                  );
                }).toList(),
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _buildTextField(String label) {
    final bool isEditable = editableFields.contains(label);
    final bool isNetPay = label == 'Net Pay Amount';
    final bool isRemarks = label == 'Remarks';

    final Color fieldColor = isEditable
        ? Colors.white
        : isNetPay
        ? primaryColor.withOpacity(0.10)
        : const Color(0xFFF5F6FA);

    final Color borderColor = isEditable
        ? primaryColor.withOpacity(0.45)
        : isNetPay
        ? primaryColor.withOpacity(0.30)
        : const Color(0xFFE8EAF0);

    return Container(
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: borderColor,
          width: isEditable ? 1.3 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: TextFormField(
          controller: supplierBillApprovalController.controllers[label],
          readOnly: !isEditable ||
              (label == 'I-GST %' && isSgstMode) ||
              (label == 'S-GST %' && isIgstMode) ||
              (label == 'C-GST %'),
          keyboardType: isRemarks
              ? TextInputType.text
              : const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          onTap: () {
            final textController = supplierBillApprovalController.controllers[label];
            final value = double.tryParse(textController?.text.trim() ?? '');

            if (value == 0) {
              textController?.clear();
            }
          },
          onChanged: (value) {
            if (label == 'S-GST %' || label == 'I-GST %') {
              handleGstChange(label, value);
            } else if (label == 'Freight Charges' ||
                label == 'Labour Charges' ||
                label == 'Other Charges') {
              calculateSupplierBillAmounts();
            }
          },
          cursorColor: primaryColor,
          style: TextStyle(
            color: isNetPay
                ? primaryColor
                : isEditable
                ? const Color(0xFF29234D)
                : const Color(0xFF4B5060),
            fontSize: 13,
            fontWeight: isNetPay || isEditable
                ? FontWeight.w600
                : FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(
              color: isEditable
                  ? primaryColor
                  : Colors.grey.shade600,
              fontSize: 11,
              fontWeight:
              isEditable ? FontWeight.w600 : FontWeight.normal,
            ),
            floatingLabelStyle: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            ),
            prefixIcon: Icon(
              fieldIcons[label] ?? Icons.edit_outlined,
              size: 17,
              color: isEditable || isNetPay
                  ? primaryColor
                  : Colors.grey.shade500,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 25,
            ),
            suffixIcon: isNetPay
                ? Icon(
              Icons.check_circle_rounded,
              size: 17,
              color: primaryColor,
            )
                : null,
          ),
        ),
      ),
    );
  }

  void calculateSupplierBillAmounts() {
    final controllers = supplierBillApprovalController.controllers;

    double getAmount(String key) {
      return double.tryParse(controllers[key]?.text.trim() ?? '') ?? 0.0;
    }

    void setAmount(String key, double value) {
      controllers[key]?.text = value.toStringAsFixed(2);
    }

    // 1. Preserve original API values
    initializeOriginalAmounts();

    // 2. Additional charges
    final freight = getAmount('Freight Charges');
    final labour = getAmount('Labour Charges');
    final other = getAmount('Other Charges');

    final additionalCharges = freight + labour + other;

    // 3. SGST + CGST calculation
    if (isSgstMode) {
      final sgstPercentage = getAmount('S-GST %');
      final sgstAmount = additionalCharges * sgstPercentage / 100;

      setAmount('S-GST Amt', sgstAmount);

      controllers['C-GST %']?.text =
          controllers['S-GST %']?.text ?? '0';

      setAmount('C-GST Amt', sgstAmount);

      setAmount('I-GST Amt', 0);
    }

    // 4. IGST calculation
    else if (isIgstMode) {
      final igstPercentage = getAmount('I-GST %');
      final igstAmount = additionalCharges * igstPercentage / 100;

      setAmount('I-GST Amt', igstAmount);

      setAmount('S-GST Amt', 0);
      setAmount('C-GST Amt', 0);
      controllers['S-GST %']?.text = '0.00';
      controllers['C-GST %']?.text = '0.00';
    }

    // 5. Net GST = original API value + current GST amount
    setAmount(
      'Net S-GST',
      originalNetSgst + getAmount('S-GST Amt'),
    );

    setAmount(
      'Net C-GST',
      originalNetCgst + getAmount('C-GST Amt'),
    );

    setAmount(
      'Net I-GST',
      originalNetIgst + getAmount('I-GST Amt'),
    );

    // 6. Total GST added during this edit
    final sgstAmount = getAmount('S-GST Amt');
    final cgstAmount = getAmount('C-GST Amt');
    final igstAmount = getAmount('I-GST Amt');

    final totalGst = sgstAmount + cgstAmount + igstAmount;

    // 7. Net Amount = original API amount + additional charges + GST
    final netAmount =
        originalNetAmount + additionalCharges + totalGst;

    setAmount('Net Amount', netAmount);

    // 8. Net Pay Amount = original API amount + additional charges + GST
    final netPayAmount =
        originalNetPayAmount + additionalCharges + totalGst;

    setAmount('Net Pay Amount', netPayAmount);
  }}