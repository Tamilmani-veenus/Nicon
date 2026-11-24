
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../newhome/maindashboard/siteuser_Dashboard.dart';

class MaterialStatusDetailsPage extends StatefulWidget {
  final List<MaterialItems> materialsItem;

  const MaterialStatusDetailsPage({
    super.key,
    required this.materialsItem,
  });

  @override
  State<MaterialStatusDetailsPage> createState() => _MaterialStatusDetailsPageState();
}

class _MaterialStatusDetailsPageState extends State<MaterialStatusDetailsPage> {
  final TextEditingController searchController =
  TextEditingController();

  MaterialFilter selectedFilter = MaterialFilter.total;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<MaterialItems> get filteredMaterials {
    return widget.materialsItem.where((item) {
      final search = searchController.text.toLowerCase().trim();

      final matchesSearch =
      item.name.toLowerCase().contains(search);

      final matchesFilter =
          selectedFilter == MaterialFilter.total ||
              item.status == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Color statusColor(MaterialFilter status) {
    switch (status) {
      case MaterialFilter.available:
        return const Color(0xFF00B982);
      case MaterialFilter.lowStock:
        return const Color(0xFFFFA000);
      case MaterialFilter.shortage:
        return const Color(0xFFFF315E);
      default:
        return const Color(0xFF2878FF);
    }
  }

  String statusText(MaterialFilter status) {
    switch (status) {
      case MaterialFilter.available:
        return 'Available';
      case MaterialFilter.lowStock:
        return 'Low Stock';
      case MaterialFilter.shortage:
        return 'Shortage';
      default:
        return 'All';
    }
  }

  @override
  Widget build(BuildContext context) {
    final available = materialItem.where(
          (e) => e.status == MaterialFilter.available,
    ).length;

    final lowStock = materialItem.where(
          (e) => e.status == MaterialFilter.lowStock,
    ).length;

    final shortage = materialItem.where(
          (e) => e.status == MaterialFilter.shortage,
    ).length;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Color(0xFF344054),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Material Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),
        ),

        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // SUMMARY
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE0E5ED),
                ),
              ),
              child: Row(
                children: [
                  _summaryItem(
                    'TOTAL ITEMS',
                    materialItem.length.toString(),
                    const Color(0xFF172033),
                  ),
                  _summaryItem(
                    'AVAILABLE',
                    available.toString(),
                    const Color(0xFF00B982),
                  ),
                  _summaryItem(
                    'LOW STOCK',
                    lowStock.toString(),
                    const Color(0xFFFFA000),
                  ),
                  _summaryItem(
                    'SHORTAGE',
                    shortage.toString(),
                    const Color(0xFFFF315E),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _searchAndFilter(),

            const SizedBox(height: 14),
            // SECTION TITLE
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'All Materials',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF172033),
                    ),
                  ),
                ),
                Text(
                  '${filteredMaterials.length} Items',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF98A2B3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // MATERIAL LIST
            ...filteredMaterials.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final color = statusColor(item.status);

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: const Color(0xFFE0E5ED),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.025),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MATERIAL NAME AND STATUS
                    Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.code,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF263244),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Material ${index + 1}  •  ${item.unit}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF98A2B3),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: color.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            statusText(item.status),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    const Divider(
                      height: 1,
                      color: Color(0xFFEEF0F4),
                    ),

                    const SizedBox(height: 12),

                    // QUANTITY DETAILS
                    Row(
                      children: [
                        Expanded(
                          child: _detailValue(
                            'STOCK QTY',
                            item.available.toString(),
                            const Color(0xFF172033),
                          ),
                        ),
                        Expanded(
                          child: _detailValue(
                            'REQUIRED QTY',
                            item.required.toString(),
                            const Color(0xFF172033),
                          ),
                        ),
                        Expanded(
                          child: _detailValue(
                            'REORDER LEVEL',
                            item.
                            reorderLevel.toString(),
                            const Color(0xFFFFA000),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _searchAndFilter() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 42,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: 'Search materials...',
                hintStyle: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF98A2B3),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 18,
                  color: Color(0xFF98A2B3),
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFDDE3EA),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFDDE3EA),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF2463FF),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          flex: 2,
          child: SizedBox(
            height: 42,
            child: DropdownButtonFormField<MaterialFilter>(
              value: selectedFilter,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 18,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 8,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFDDE3EA),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFDDE3EA),
                  ),
                ),
              ),
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF344054),
                fontWeight: FontWeight.w600,
              ),
              items: const [
                DropdownMenuItem(
                  value: MaterialFilter.total,
                  child: Text('All Status'),
                ),
                DropdownMenuItem(
                  value: MaterialFilter.available,
                  child: Text('Available'),
                ),
                DropdownMenuItem(
                  value: MaterialFilter.lowStock,
                  child: Text('Low Stock'),
                ),
                DropdownMenuItem(
                  value: MaterialFilter.shortage,
                  child: Text('Shortage'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedFilter = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _summaryItem(
      String title,
      String value,
      Color color,
      ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Color(0xFF98A2B3),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailValue(
      String title,
      String value,
      Color color,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: Color(0xFF98A2B3),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}



class UpcomingInwardViewAllScreen extends StatefulWidget {
  const UpcomingInwardViewAllScreen({super.key});

  @override
  State<UpcomingInwardViewAllScreen> createState() =>
      _UpcomingInwardViewAllScreenState();
}

class _UpcomingInwardViewAllScreenState
    extends State<UpcomingInwardViewAllScreen> {
  final TextEditingController searchController =
  TextEditingController();

  final List<Map<String, String>> inwardList = [
    {
      "date": "04 Oct 2026",
      "material": "Cement",
      "supplier": "ABC Supplier",
      "qty": "500 Bag",
      "po": "PO-1025",
      "vehicle": "TN 09 BX 4412",
      "status": "In Transit",
    },
    {
      "date": "05 Oct 2026",
      "material": "Steel",
      "supplier": "XYZ Supplier",
      "qty": "10 Ton",
      "po": "PO-1028",
      "vehicle": "TN 22 CZ 9021",
      "status": "Expected",
    },
    {
      "date": "06 Oct 2026",
      "material": "Bricks",
      "supplier": "Local Supplier",
      "qty": "5000 Nos",
      "po": "PO-1030",
      "vehicle": "TN 14 D 7714",
      "status": "Confirmed",
    },
    {
      "date": "07 Oct 2026",
      "material": "M-Sand",
      "supplier": "RMC Supplier",
      "qty": "20 Ton",
      "po": "PO-1032",
      "vehicle": "TN 05 AF 3320",
      "status": "In Transit",
    },
    {
      "date": "08 Oct 2026",
      "material": "Electrical Items",
      "supplier": "Electricals Co.",
      "qty": "50 Nos",
      "po": "PO-1035",
      "vehicle": "Courier Express",
      "status": "Expected",
    },
  ];

  List<Map<String, String>> get filteredList {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) return inwardList;

    return inwardList.where((item) {
      return item.values.any(
            (value) => value.toLowerCase().contains(query),
      );
    }).toList();
  }

  Color statusColor(String status) {
    switch (status) {
      case "Confirmed":
        return Colors.green;
      case "Expected":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  Widget _info(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF292936),
          ),
        ),
      ],
    );
  }

  Widget _inwardCard(Map<String, String> item) {
    final color = statusColor(item["status"]!);

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFEDEDF2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Material Name and Status
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xFF7C3AED),
                  size: 15,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  item["material"]!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item["status"]!,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Supplier and Quantity
          Row(
            children: [
              Expanded(
                child: _info(
                  "Supplier",
                  item["supplier"]!,
                ),
              ),
              _info(
                "Quantity",
                item["qty"]!,
              ),
            ],
          ),

          const SizedBox(height: 9),

          // Vehicle Number
          _info(
            "Vehicle No",
            item["vehicle"]!,
          ),

          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),

          // PO Reference and Expected Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "PO: ${item["po"]}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        item["date"]!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredList;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7FA),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, // Back arrow color
          ),
          title: const Text(
            "Upcoming Inward Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Search Field
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
              child: TextField(
                controller: searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Search material, supplier, PO, vehicle...",
                  hintStyle: const TextStyle(fontSize: 12),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 19,
                    color: Colors.grey,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close, size: 17),
                  )
                      : null,
                  filled: true,
                  fillColor: const Color(0xFFFAFAFC),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFEDEDF2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFEDEDF2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                ),
              ),
            ),

            // Record Count
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "All Inward Details",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${data.length} Records",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7C3AED),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Inward List
            Expanded(
              child: data.isEmpty
                  ? const Center(
                child: Text(
                  "No inward records found",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _inwardCard(data[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class LabourAllocationViewAllScreen extends StatefulWidget {
  const LabourAllocationViewAllScreen({super.key});

  @override
  State<LabourAllocationViewAllScreen> createState() =>
      _LabourAllocationViewAllScreenState();
}

class _LabourAllocationViewAllScreenState
    extends State<LabourAllocationViewAllScreen> {

  final TextEditingController searchController = TextEditingController();

  String selectedFilter = "All";

  final Color primaryColor = const Color(0xFF2864F0);

  final List<Map<String, dynamic>> labourList = [
    {
      "category": "NMR",
      "subcontractor": "Sri Murugan Enterprises",
      "required": 40,
      "present": 35,
      "shortage": 5,
      "rate": 700,
      "cost": 24500,
      "attendance": 88,
      "color": const Color(0xFF397BFF),
    },
    {
      "category": "MC",
      "subcontractor": "Direct Site Team",
      "required": 20,
      "present": 18,
      "shortage": 2,
      "rate": 800,
      "cost": 14400,
      "attendance": 90,
      "color": const Color(0xFF6565F5),
    },
    {
      "category": "FC",
      "subcontractor": "Direct Site Team",
      "required": 15,
      "present": 15,
      "shortage": 0,
      "rate": 900,
      "cost": 13500,
      "attendance": 100,
      "color": const Color(0xFF10B981),
    },
    {
      "category": "Mason",
      "subcontractor": "Star Builders Labour",
      "required": 12,
      "present": 8,
      "shortage": 4,
      "rate": 1000,
      "cost": 8000,
      "attendance": 67,
      "color": const Color(0xFFF59E0B),
    },
    {
      "category": "Carpenter",
      "subcontractor": "Shuttering Works Co",
      "required": 10,
      "present": 9,
      "shortage": 1,
      "rate": 850,
      "cost": 7650,
      "attendance": 90,
      "color": const Color(0xFF9657F5),
    },
    {
      "category": "Electrician",
      "subcontractor": "PowerTech MEP",
      "required": 8,
      "present": 6,
      "shortage": 2,
      "rate": 900,
      "cost": 5400,
      "attendance": 75,
      "color": const Color(0xFF0EA5A4),
    },
  ];

  int get totalRequired => labourList.fold(
      0, (sum, item) => sum + item["required"] as int);

  int get totalPresent => labourList.fold(
      0, (sum, item) => sum + item["present"] as int);

  int get totalShortage => labourList.fold(
      0, (sum, item) => sum + item["shortage"] as int);

  int get totalCost => labourList.fold(
      0, (sum, item) => sum + item["cost"] as int);

  List<Map<String, dynamic>> get filteredList {
    final query = searchController.text.trim().toLowerCase();

    return labourList.where((item) {
      final matchesSearch =
          item["category"].toString().toLowerCase().contains(query) ||
              item["subcontractor"].toString().toLowerCase().contains(query);

      final matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Shortage" && item["shortage"] > 0) ||
          (selectedFilter == "Fully Allocated" && item["shortage"] == 0);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  String formatAmount(int amount) {
    return "₹${amount.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => "${match[1]},",
    )}";
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Labour Allocation Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  // Summary


                  // Heading
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Category-wise Allocation",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF172033),
                          ),
                        ),
                      ),
                      Text(
                        "${filteredList.length} Records",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8994A7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Search
                  _searchField(),

                  const SizedBox(height: 12),

                  // Filters
                  _filterSection(),

                  const SizedBox(height: 15),
                  _summarySection(),

                  const SizedBox(height: 12),

                  // Labour cards
                  if (filteredList.isEmpty)
                    _emptyState()
                  else
                    ...filteredList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _labourCard(item),
                      );
                    }),
                ],
              ),
            ),

            // Bottom total
            _bottomTotal(),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // SUMMARY SECTION
  // --------------------------------------------------

  Widget _summarySection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE6E9F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.groups_outlined,
                  color: primaryColor,
                  size: 15,
                ),
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  "Work-wise Labour Requirement",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "6 Categories",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF2864F0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  "Required",
                  totalRequired.toString(),
                  const Color(0xFF2864F0),
                  Icons.groups_outlined,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _summaryItem(
                  "Present",
                  totalPresent.toString(),
                  const Color(0xFF10A875),
                  Icons.person_outline,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _summaryItem(
                  "Shortage",
                  totalShortage.toString(),
                  const Color(0xFFEF5555),
                  Icons.person_off_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
      String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF8994A7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // SEARCH FIELD
  // --------------------------------------------------

  Widget _searchField() {
    return TextField(
      controller: searchController,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: "Search category or subcontractor...",
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFF9AA4B5),
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 19,
          color: Color(0xFF8994A7),
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
          onPressed: () {
            searchController.clear();
            setState(() {});
          },
          icon: const Icon(Icons.close, size: 18),
        )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Color(0xFFE3E7EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Color(0xFFE3E7EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // FILTER SECTION
  // --------------------------------------------------

  Widget _filterSection() {
    final filters = ["All", "Shortage", "Fully Allocated"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final selected = selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? primaryColor
                      : const Color(0xFFE0E5ED),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF697386),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --------------------------------------------------
  // LABOUR CATEGORY CARD
  // --------------------------------------------------

  Widget _labourCard(Map<String, dynamic> item) {
    final Color categoryColor = item["color"];
    final int required = item["required"];
    final int present = item["present"];
    final int shortage = item["shortage"];
    final int attendance = item["attendance"];

    final bool isFull = shortage == 0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E8EF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category and present count
          Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["category"],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172033),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item["subcontractor"],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF8994A7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$present/$required",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),
                  const Text(
                    "PRESENT / REQUIRED",
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF9AA4B5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Worker Availability",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF8994A7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "$attendance%",
                style: TextStyle(
                  fontSize: 11,
                  color: isFull
                      ? const Color(0xFF10A875)
                      : categoryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: required == 0 ? 0 : present / required,
              minHeight: 7,
              backgroundColor: const Color(0xFFF0F1F5),
              valueColor: AlwaysStoppedAnimation<Color>(
                categoryColor,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Required, present and shortage
          Row(
            children: [
              _workerInfo("Required", required.toString(),
                  const Color(0xFF2864F0)),
              _workerInfo("Present", present.toString(),
                  const Color(0xFF10A875)),
              _workerInfo("Shortage", shortage.toString(),
                  isFull
                      ? const Color(0xFF10A875)
                      : const Color(0xFFEF5555)),
            ],
          ),

          const SizedBox(height: 8),

          const Divider(
            height: 1,
            color: Color(0xFFD1D5DE),
          ),

          const SizedBox(height: 6),

          // Cost details
          Row(
            children: [
              Expanded(
                child: _costInfo(
                  "Daily Rate",
                  formatAmount(item["rate"]),
                  Icons.payments_outlined,
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: const Color(0xFFE9ECF2),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: _costInfo(
                    "Total Cost",
                    formatAmount(item["cost"]),
                    Icons.account_balance_wallet_outlined,
                  ),
                ),
              ),
              if (!isFull)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2E8),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    "$shortage Short",
                    style: const TextStyle(
                      color: Color(0xFFEA7B25),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9F9F1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text(
                    "Full",
                    style: TextStyle(
                      color: Color(0xFF0B9B67),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _workerInfo(String title, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF9AA4B5),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _costInfo(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: const Color(0xFF8994A7)),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF8994A7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF263247),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // EMPTY STATE
  // --------------------------------------------------

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(
            Icons.search_off,
            size: 38,
            color: Color(0xFFB0B8C6),
          ),
          SizedBox(height: 10),
          Text(
            "No labour categories found",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF697386),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // BOTTOM TOTAL
  // --------------------------------------------------

  Widget _bottomTotal() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Labour Cost",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF8994A7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatAmount(totalCost),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF172033),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.groups_outlined,
                  size: 16,
                  color: primaryColor,
                ),
                const SizedBox(width: 6),
                Text(
                  "$totalPresent / $totalRequired",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

