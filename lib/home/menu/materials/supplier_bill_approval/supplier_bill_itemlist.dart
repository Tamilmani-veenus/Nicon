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

  final Map<String, String> initialValues = {
    // Additional Charges
    'Freight Charges': '1500.00',
    'Labour Charges': '750.00',
    'Other Charges': '250.00',

    // Taxes
    'S-GST %': '9.00',
    'S-GST Amt': '900.00',
    'Net S-GST': '900.00',
    'C-GST %': '9.00',
    'C-GST Amt': '900.00',
    'Net C-GST': '900.00',
    'I-GST %': '0.00',
    'I-GST Amt': '0.00',
    'Net I-GST': '0.00',
    'TCS %': '1.00',
    'TCS Amt': '100.00',
    'TDS %': '2.00',
    'TDS Amt': '200.00',
    'Discount %': '5.00',
    'Disc Amt': '500.00',

    // Payment Details
    'Round Off': '0.00',
    'Net Amount': '22700.00',
    'Advance Amount': '5000.00',
    'Deduction Amount': '200.00',
    'Net Pay Amount': '17500.00',
  };

  final Map<String, IconData> fieldIcons = {
    'Freight Charges': Icons.local_shipping_outlined,
    'Labour Charges': Icons.engineering_outlined,
    'Other Charges': Icons.more_horiz,
    'S-GST %': Icons.percent,
    'S-GST Amt': Icons.currency_rupee,
    'Net S-GST': Icons.account_balance_wallet_outlined,
    'C-GST %': Icons.percent,
    'C-GST Amt': Icons.currency_rupee,
    'Net C-GST': Icons.account_balance_wallet_outlined,
    'I-GST %': Icons.percent,
    'I-GST Amt': Icons.currency_rupee,
    'Net I-GST': Icons.account_balance_wallet_outlined,
    'TCS %': Icons.percent,
    'TCS Amt': Icons.currency_rupee,
    'TDS %': Icons.percent,
    'TDS Amt': Icons.currency_rupee,
    'Discount %': Icons.percent,
    'Disc Amt': Icons.currency_rupee,
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

    for (final entry in initialValues.entries) {
      supplierBillApprovalController.controllers.putIfAbsent(
        entry.key,
            () => TextEditingController(text: entry.value),
      );
    }
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
                          'Net S-GST',
                          'C-GST %',
                          'C-GST Amt',
                          'Net C-GST',
                          'I-GST %',
                          'I-GST Amt',
                          'Net I-GST',
                          'TCS %',
                          'TCS Amt',
                          'TDS %',
                          'TDS Amt',
                          'Discount %',
                          'Disc Amt',
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
          readOnly: !isEditable,
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

}