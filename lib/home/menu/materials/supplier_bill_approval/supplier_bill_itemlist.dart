import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupplierBillItemList extends StatefulWidget {
  const SupplierBillItemList({super.key});

  @override
  State<SupplierBillItemList> createState() =>
      _SupplierBillItemListState();
}

class _SupplierBillItemListState extends State<SupplierBillItemList> {

  final Map<String, TextEditingController> controllers = {};

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
  };

  final Color primaryColor = Color(0xFF4A3AFF);


  @override
  void initState() {
    super.initState();

    for (final entry in initialValues.entries) {
      controllers[entry.key] =
          TextEditingController(text: entry.value);
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Supplier Bill',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: primaryColor.withOpacity(0.25),
          width: 1.2,
        ),
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
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 21,
                ),
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
            ],
          ),

          const SizedBox(height: 14),

          // TextFormField Cards
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

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white70,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 3,
          left: 10,
          right: 8,
          bottom: 5,
        ),
        child: TextFormField(
          controller: controllers[label],
          readOnly: !isEditable,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: Platform.isAndroid
              ? const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          )
              : TextInputType.text,
          cursorColor: Colors.black,
          style: TextStyle(
            color: isNetPay ? primaryColor : Colors.black,
            fontSize: 13,
            fontWeight:
            isNetPay ? FontWeight.w700 : FontWeight.normal,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              child: Icon(
                fieldIcons[label] ?? Icons.edit_outlined,
                size: 18,
                color:  primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }


}