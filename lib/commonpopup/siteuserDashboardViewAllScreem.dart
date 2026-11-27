
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



class UpcomingTasksViewAllScreen extends StatelessWidget {
  const UpcomingTasksViewAllScreen({super.key});

  static const Color primaryColor = Color(0xFF2864F0);
  static const Color borderColor = Color(0xFFDCE1E9);

  final List<Map<String, dynamic>> tasks = const [
    {
      "day": "04",
      "month": "OCT",
      "year": "2026",
      "title": "Slab Work Concreting",
      "block": "Block B",
      "team": "Civil Team A",
      "priority": "High",
      "status": "Planned",
    },
    {
      "day": "05",
      "month": "OCT",
      "year": "2026",
      "title": "Rebar Inspection & Testing",
      "block": "Block A",
      "team": "Quality Inspector",
      "priority": "High",
      "status": "Planned",
    },
    {
      "day": "06",
      "month": "OCT",
      "year": "2026",
      "title": "Plumbing Shaft Pressure Test",
      "block": "Block C",
      "team": "MEP Subcontractor",
      "priority": "Medium",
      "status": "In Progress",
    },
    {
      "day": "07",
      "month": "OCT",
      "year": "2026",
      "title": "External Scaffolding Erection",
      "block": "Block B",
      "team": "Scaffold Crew",
      "priority": "Medium",
      "status": "Planned",
    },
    {
      "day": "08",
      "month": "OCT",
      "year": "2026",
      "title": "Electrical Conduit Inspection",
      "block": "Block A",
      "team": "Electrical Team",
      "priority": "High",
      "status": "Planned",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color(0xFF172033),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Upcoming Site Tasks",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),
        ),
        body: Column(
          children: [
            // Summary Header
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      "Site Execution Tasks & Milestones",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF344054),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF0FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "5 Tasks",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Task List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: tasks.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return _taskCard(tasks[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskCard(Map<String, dynamic> task) {
    final String priority = task["priority"];
    final String status = task["status"];

    final Color priorityColor = priority == "High"
        ? const Color(0xFFD94848)
        : const Color(0xFFD98716);

    final Color priorityBg = priority == "High"
        ? const Color(0xFFFFEEEE)
        : const Color(0xFFFFF5E5);

    final Color statusColor = status == "In Progress"
        ? const Color(0xFFD98716)
        : const Color(0xFF3478F6);

    final Color statusBg = status == "In Progress"
        ? const Color(0xFFFFF5E5)
        : const Color(0xFFEFF5FF);

    final String initials = task["team"]
        .toString()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0])
        .take(2)
        .join()
        .toUpperCase();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date + Work Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFF),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task["month"],
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      task["day"],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172033),
                      ),
                    ),
                    // Text(
                    //   task["year"],
                    //   style: const TextStyle(
                    //     fontSize: 8,
                    //     color: Color(0xFF8994A7),
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  task["title"],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
              _badge(
                status,
                statusColor,
                statusBg,
                showDot: true,
              ),
            ],
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0xFFEDF0F4)),
          const SizedBox(height: 8),

          // Block and Team
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.apartment_outlined,
                size: 14,
                color: Color(0xFF8994A7),
              ),
              const SizedBox(width: 5),
              Text(
                task["block"],
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF536176),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 17,
                height: 17,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF0FF),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  task["team"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF536176),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Priority",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8994A7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 7),
                  _badge(
                    priority,
                    priorityColor,
                    priorityBg,
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(
      String label,
      Color color,
      Color background, {
        bool showDot = false,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}




class BoqDprViewAllPage extends StatefulWidget {
  const BoqDprViewAllPage({super.key});

  @override
  State<BoqDprViewAllPage> createState() =>
      _BoqDprViewAllPageState();
}

class _BoqDprViewAllPageState extends State<BoqDprViewAllPage> {
  static const Color primary = Color(0xFF3D7BFF);
  static const Color text = Color(0xFF202B3F);
  static const Color muted = Color(0xFF8995A8);
  static const Color border = Color(0xFFE8ECF2);
  static const Color green = Color(0xFF08B982);

  final TextEditingController searchController =
  TextEditingController();

  String selectedStatus = 'All Statuses';
  int? expandedIndex;

  final List<Map<String, dynamic>> records = [
    {
      'project': 'Skyline Heights Phase-1',
      'site': 'Sector 62 - Site A',
      'wo': 'WO/2026/0481',
      'category': 'Foundation',
      'fixed': 500,
      'done': 300,
      'balance': 200,
      'unit': 'Cum',
      'progress': 60,
      'status': 'In Progress',
    },
    {
      'project': 'Skyline Heights Phase-1',
      'site': 'Sector 62 - Site A',
      'wo': 'WO/2026/0482',
      'category': 'Structure',
      'fixed': 800,
      'done': 650,
      'balance': 150,
      'unit': 'Cum',
      'progress': 81,
      'status': 'On Track',
    },
    {
      'project': 'Grand Palm Residences',
      'site': 'Block B - West Wing',
      'wo': 'WO/2026/0495',
      'category': 'Brick Work',
      'fixed': 1000,
      'done': 750,
      'balance': 250,
      'unit': 'Sqm',
      'progress': 75,
      'status': 'On Track',
    },
    {
      'project': 'Grand Palm Residences',
      'site': 'Block B - West Wing',
      'wo': 'WO/2026/0498',
      'category': 'Plastering',
      'fixed': 800,
      'done': 520,
      'balance': 280,
      'unit': 'Sqm',
      'progress': 65,
      'status': 'In Progress',
    },
    {
      'project': 'Emerald Commercial Hub',
      'site': 'Tower C - Floor 4',
      'wo': 'WO/2026/0512',
      'category': 'Electrical',
      'fixed': 400,
      'done': 250,
      'balance': 150,
      'unit': 'Points',
      'progress': 63,
      'status': 'Delayed',
    },
    {
      'project': 'Emerald Commercial Hub',
      'site': 'Tower C - Floor 4',
      'wo': 'WO/2026/0518',
      'category': 'Plumbing',
      'fixed': 300,
      'done': 180,
      'balance': 120,
      'unit': 'Rmt',
      'progress': 60,
      'status': 'In Progress',
    },
  ];

  final List<String> filters = [
    'All Statuses',
    'On Track',
    'In Progress',
    'Delayed',
    'Completed',
  ];

  List<Map<String, dynamic>> get filteredRecords {
    final query = searchController.text.toLowerCase().trim();

    return records.where((item) {
      final matchesStatus = selectedStatus == 'All Statuses' ||
          item['status'] == selectedStatus;

      final matchesSearch =
          item['project'].toString().toLowerCase().contains(query) ||
              item['site'].toString().toLowerCase().contains(query) ||
              item['wo'].toString().toLowerCase().contains(query) ||
              item['category'].toString().toLowerCase().contains(query);

      return matchesStatus && matchesSearch;
    }).toList();
  }

  Color statusColor(String status) {
    switch (status) {
      case 'On Track':
        return const Color(0xFF08A978);
      case 'In Progress':
        return const Color(0xFFE59A20);
      case 'Delayed':
        return const Color(0xFFE45656);
      case 'Completed':
        return const Color(0xFF3976E8);
      default:
        return muted;
    }
  }

  Color statusBackground(String status) {
    switch (status) {
      case 'On Track':
        return const Color(0xFFE7F8F1);
      case 'In Progress':
        return const Color(0xFFFFF4E2);
      case 'Delayed':
        return const Color(0xFFFFEBEB);
      case 'Completed':
        return const Color(0xFFEAF1FF);
      default:
        return const Color(0xFFF0F2F5);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredRecords;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                size: 19, color: text),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'BOQ vs DPR Details',
            style: TextStyle(
              color: text,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            _searchSection(),
            // _filterSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 9),
              child: Row(
                children: [
                  const Text(
                    'Work Order Details',
                    style: TextStyle(
                      color: text,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${data.length} Records',
                    style: const TextStyle(
                      color: muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: data.isEmpty
                  ? _emptyView()
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  final isExpanded = expandedIndex == index;

                  return _workCard(
                    item,
                    index,
                    isExpanded,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _searchSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {
                expandedIndex = null;
              }),
              style: const TextStyle(
                fontSize: 12,
                color: text,
              ),
              decoration: InputDecoration(
                hintText: 'Search project, WO, category...',
                hintStyle: const TextStyle(
                  color: muted,
                  fontSize: 10,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 19,
                  color: muted,
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
                fillColor: const Color(0xFFF6F8FB),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 11,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: primary,
                    width: 1.2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 9),

          // Status dropdown
          Container(
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 9),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStatus,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: primary,
                ),
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: text,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
                items: filters.map((filter) {
                  return DropdownMenuItem<String>(
                    value: filter,
                    child: Text(filter),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedStatus = value;
                      expandedIndex = null;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _filterSection() {
    return Container(
      color: Colors.white,
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = selectedStatus == filter;

          final count = filter == 'All Statuses'
              ? records.length
              : records.where((e) => e['status'] == filter).length;

          final color = filter == 'All Statuses'
              ? primary
              : statusColor(filter);

          return Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedStatus = filter;
                  expandedIndex = null;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? color.withOpacity(0.11)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? color : border,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      filter,
                      style: TextStyle(
                        fontSize: 10,
                        color: selected ? color : muted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 9,
                        color: selected ? color : muted,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _workCard(
      Map<String, dynamic> item,
      int index,
      bool isExpanded,
      ) {
    final progress = item['progress'] as int;
    final status = item['status'] as String;
    final color = statusColor(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isExpanded ? primary.withOpacity(0.45) : border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () {
          setState(() {
            expandedIndex = isExpanded ? null : index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item['category'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: text,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _statusBadge(status),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item['project'],
                style: const TextStyle(
                  fontSize: 11,
                  color: text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 12,
                    color: muted,
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      item['site'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: muted,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.receipt_long_outlined,
                    size: 12,
                    color: primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item['wo'],
                    style: const TextStyle(
                      fontSize: 9,
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 11),
                child: Divider(height: 1, color: border),
              ),
              Row(
                children: [
                  _quantity('FIXED QTY', item['fixed'], item['unit']),
                  _verticalDivider(),
                  _quantity('CQ DONE', item['done'], item['unit'],
                      valueColor: green),
                  _verticalDivider(),
                  _quantity('BALANCE', item['balance'], item['unit'],
                      valueColor: const Color(0xFFE59A20)),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  const Text(
                    'Execution Progress',
                    style: TextStyle(
                      fontSize: 10,
                      color: muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$progress%',
                    style: TextStyle(
                      fontSize: 13,
                      color: progress == 100 ? green : primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  minHeight: 7,
                  backgroundColor: const Color(0xFFFFEBC1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress == 100 ? green : const Color(0xFF08B982),
                  ),
                ),
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FC),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'WORK ORDER SUMMARY',
                        style: TextStyle(
                          color: muted,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 9),
                      _detailRow('Project', item['project']),
                      _detailRow('Site', item['site']),
                      _detailRow('Work Order', item['wo']),
                      _detailRow('Work Category', item['category']),
                      _detailRow('Unit', item['unit']),
                      _detailRow('Completion', '$progress%'),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    isExpanded ? 'Show Less' : 'View Details',
                    style: const TextStyle(
                      color: primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final color = statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: statusBackground(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantity(
      String title,
      int value,
      String unit, {
        Color valueColor = text,
      }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              color: muted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 15,
              color: valueColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 9,
              color: muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 9),
      color: border,
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: muted,
              ),
            ),
          ),
          const Text(': ',
              style: TextStyle(fontSize: 10, color: muted)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                color: text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: muted.withOpacity(0.5),
          ),
          const SizedBox(height: 10),
          const Text(
            'No work orders found',
            style: TextStyle(
              fontSize: 13,
              color: text,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Try changing your search or status filter',
            style: TextStyle(
              fontSize: 11,
              color: muted,
            ),
          ),
        ],
      ),
    );
  }
}

class LabourDistributionViewAll extends StatefulWidget {
  const LabourDistributionViewAll({super.key});

  @override
  State<LabourDistributionViewAll> createState() =>
      _LabourDistributionViewAllState();
}

class _LabourDistributionViewAllState
    extends State<LabourDistributionViewAll> {
  final TextEditingController searchController =
  TextEditingController();

  final Color primary = const Color(0xFF397BFF);
  final Color textColor = const Color(0xFF172033);
  final Color muted = const Color(0xFF8995A8);
  final Color borderColor = const Color(0xFFE5E9F0);

  final List<Map<String, dynamic>> labourList = [
    {
      'category': 'NMR',
      'subcontractor': 'Sri Murugan Enterprises',
      'required': 40,
      'present': 35,
      'shortage': 5,
      'rate': 700,
      'cost': 24500,
      'attendance': 88,
      'color': Color(0xFF397BFF),
    },
    {
      'category': 'MC',
      'subcontractor': 'Direct Site Team',
      'required': 20,
      'present': 18,
      'shortage': 2,
      'rate': 800,
      'cost': 14400,
      'attendance': 90,
      'color': Color(0xFF0D9488),
    },
    {
      'category': 'FC',
      'subcontractor': 'Direct Site Team',
      'required': 15,
      'present': 15,
      'shortage': 0,
      'rate': 900,
      'cost': 13500,
      'attendance': 100,
      'color': Color(0xFF10B981),
    },
    {
      'category': 'Mason',
      'subcontractor': 'Star Builders Labour',
      'required': 12,
      'present': 8,
      'shortage': 4,
      'rate': 1000,
      'cost': 8000,
      'attendance': 67,
      'color': Color(0xFFF59E0B),
    },
    {
      'category': 'Carpenter',
      'subcontractor': 'Shuttering Works Co',
      'required': 10,
      'present': 9,
      'shortage': 1,
      'rate': 850,
      'cost': 7650,
      'attendance': 90,
      'color': Color(0xFF8B5CF6),
    },
    {
      'category': 'Electrician',
      'subcontractor': 'PowerTech MEP',
      'required': 8,
      'present': 6,
      'shortage': 2,
      'rate': 900,
      'cost': 5400,
      'attendance': 75,
      'color': Color(0xFFE85D75),
    },
  ];

  List<Map<String, dynamic>> get filteredList {
    final query = searchController.text.toLowerCase().trim();

    if (query.isEmpty) return labourList;

    return labourList.where((item) {
      return item['category']
          .toString()
          .toLowerCase()
          .contains(query) ||
          item['subcontractor']
              .toString()
              .toLowerCase()
              .contains(query);
    }).toList();
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
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19,
              color: Color(0xFF172033),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Labour Distribution',
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(14, 5, 14, 14),
                child: Column(
                  children: [
                    _summaryCard(),
                    const SizedBox(height: 8),
                    _searchField(),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    12, 12, 12, 20,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 11),
                      child: _labourCard(filteredList[index]),
                    );
                  },
                ),
              ),

              _bottomTotal(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4FF),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '6 CATEGORIES',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w700,
              letterSpacing: .6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _summaryValue('105', 'Required', textColor),
              _summaryValue('91', 'Present',
                  const Color(0xFF079568)),
              _summaryValue('14', 'Shortage',
                  const Color(0xFFD97706)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryValue(
      String value,
      String label,
      Color color,
      ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: searchController,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF172033),
      ),
      decoration: InputDecoration(
        hintText: 'Search category or subcontractor...',
        hintStyle: const TextStyle(
          fontSize: 11,
          color: Color(0xFF8995A8),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 19,
          color: Color(0xFF8995A8),
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
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primary),
        ),
      ),
    );
  }

  Widget _labourCard(Map<String, dynamic> item) {
    final Color color = item['color'];
    final int attendance = item['attendance'];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category and attendance
          Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(.10),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    item['category']
                        .toString()
                        .substring(0, 1),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item['category'],
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: attendance >= 90
                      ? const Color(0xFFE5F8EF)
                      : attendance >= 75
                      ? const Color(0xFFFFF5DF)
                      : const Color(0xFFFFE9E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$attendance% Attendance',
                  style: TextStyle(
                    color: attendance >= 90
                        ? const Color(0xFF079568)
                        : attendance >= 75
                        ? const Color(0xFFB7791F)
                        : const Color(0xFFE04444),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Subcontractor
          Row(
            children: [
              Icon(
                Icons.business_outlined,
                size: 14,
                color: muted,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item['subcontractor'],
                  style: TextStyle(
                    color: muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Divider(height: 1, color: borderColor),
          const SizedBox(height: 8),

          // Workforce details
          Row(
            children: [
              _metric(
                'Required',
                '${item['required']}',
                textColor,
              ),
              _metric(
                'Present',
                '${item['present']}',
                const Color(0xFF079568),
              ),
              _metric(
                'Shortage',
                '${item['shortage']}',
                item['shortage'] == 0
                    ? const Color(0xFF079568)
                    : const Color(0xFFD97706),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Wage details
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _wageValue(
                    'Daily Rate',
                    '₹${item['rate']}',
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: borderColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _wageValue(
                    'Total Cost',
                    '₹${item['cost']}',
                    highlight: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(
      String label,
      String value,
      Color color,
      ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF8995A8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _wageValue(
      String label,
      String value, {
        bool highlight = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8995A8),
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: highlight
                ? primary
                : textColor,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _bottomTotal() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Wage Cost',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF667085),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '₹${filteredList.fold<int>(
              0,
                  (sum, item) => sum + (item['cost'] as int),
            )}',
            style: TextStyle(
              fontSize: 16,
              color: primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}


