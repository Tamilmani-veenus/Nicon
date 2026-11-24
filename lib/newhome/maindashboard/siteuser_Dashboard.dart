import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/siteuserDashboard_controller.dart';
import 'dart:math';
import '../../commonpopup/siteuserDashboardViewAllScreem.dart';
import '../../controller/logincontroller.dart';
import '../../utilities/baseutitiles.dart';
import 'hrDashboard.dart';

class SiteHomeScreen extends StatefulWidget {
  const SiteHomeScreen({super.key});

  @override
  State<SiteHomeScreen> createState() => _SiteHomeScreenState();
}

class _SiteHomeScreenState extends State<SiteHomeScreen> {
  LoginController loginController = Get.put(LoginController());
  SiteUserDashboardController siteUserDashboardController = Get.put(SiteUserDashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    siteUserDashboardController.entryFromDate.text =
        currentDate.toString().substring(0, 10);
    siteUserDashboardController.entryToDate.text =
        currentDate.toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: 125,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Header content
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${BaseUtitiles().getGreeting()}, ${loginController.UserName()}!  👋",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Track site execution, workforce & materials in real-time",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Date filter - Bottom Right
                    Positioned(
                      bottom: 8,
                      right: 10,
                      child: SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonCompactDateField(
                              title: "From",
                              controller: siteUserDashboardController.entryFromDate,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (date != null) {
                                  setState(() {
                                    siteUserDashboardController.entryFromDate.text =
                                        date.toString().substring(0, 10);
                                  });

                                  // _refreshIndicatorKey.currentState?.show();
                                }
                              },
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: Color(0xff667085),
                              ),
                            ),
                            CommonCompactDateField(
                              title: "To",
                              controller: siteUserDashboardController.entryToDate,
                              onTap: () async {
                                final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme.of(context).primaryColor,
                                            onPrimary: Colors.white,
                                            onSurface: Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors.black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                if (date != null) {
                                  setState(() {
                                    siteUserDashboardController.entryToDate.text =
                                        date.toString().substring(0, 10);
                                  });
                                  // _refreshIndicatorKey.currentState?.show();
                                }
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.only(top: 8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing:10,
                mainAxisSpacing: 10,
                mainAxisExtent: 110,
              ),
              itemBuilder: (context, index) {
                final items = [
                  {
                    "title": "Labour Present",
                    "value": "86 / 94",
                    "subtitle": "Attendance",
                    "status": "91.4%",
                    "icon": Icons.people_alt_outlined,
                    "color": const Color(0xff3478F6),
                  },
                  {
                    "title": "Materials Available",
                    "value": "92%",
                    "subtitle": "As per Plan",
                    "status": "Good",
                    "icon": Icons.inventory_2_outlined,
                    "color": const Color(0xff10B981),
                  },
                  {
                    "title": "MRN Pending",
                    "value": "2",
                    "subtitle": "Need Approval",
                    "status": "Action",
                    "icon": Icons.receipt_long_outlined,
                    "color": const Color(0xffF59E0B),
                  },
                  {
                    "title": "Material Shortage",
                    "value": "5 Items",
                    "subtitle": "Need Attention",
                    "status": "Urgent",
                    "icon": Icons.warning_amber_rounded,
                    "color": const Color(0xffEF4444),
                  },
                  {
                    "title": "Upcoming Inward",
                    "value": "3",
                    "subtitle": "Expected this week",
                    "status": "Transit",
                    "icon": Icons.move_to_inbox_outlined,
                    "color": const Color(0xffA855F7),
                  },
                  {
                    "title": "Engineer Leave",
                    "value": "8 / 12",
                    "subtitle": "Taken: 4",
                    "status": "Pending: 1",
                    "icon": Icons.calendar_month_outlined,
                    "color": const Color(0xffEAAA08),
                  },
                ];

                final item = items[index];

                return _dashboardCard(
                  title: item["title"] as String,
                  value: item["value"] as String,
                  subtitle: item["subtitle"] as String,
                  status: item["status"] as String,
                  icon: item["icon"] as IconData,
                  color: item["color"] as Color,
                );
              },
            ),
            SizedBox(height: 10,),
            const LabourAtSiteCard(),
            SizedBox(height: 10,),
            const SizedBox(
              height: 370,
              child: EmployeeLeaveFlipCard(),
            ),
            SizedBox(height: 10,),
            const MaterialStatusCard(),
            SizedBox(height: 10,),
            UpcomingInwardDetails(),
            SizedBox(height: 10,),
            const WorkWiseLabourCard(),
            SizedBox(height: 10,),
            const UpcomingSiteTasksCard(),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard({
    required String title,
    required String value,
    required String subtitle,
    required String status,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 210,
      // margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.045),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffE0E5EC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff344054),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff101828),
            ),
          ),

          const SizedBox(height: 5),

          Container(
            height: 1,
            color: color.withOpacity(0.20),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xff475467),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LabourAtSiteCard extends StatefulWidget {
  const LabourAtSiteCard({super.key});

  @override
  State<LabourAtSiteCard> createState() => _LabourAtSiteCardState();
}

class _LabourAtSiteCardState extends State<LabourAtSiteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, dynamic>> labourData = [
    {"name": "MC", "nmr": "5", "rate": "15"},
    {"name": "FC", "nmr": "10", "rate": "60"},
    {"name": "Mason", "nmr": "10", "rate": "1"},
    {"name": "Carpenter", "nmr": "9", "rate": "10"},
    {"name": "Electrician", "nmr": "6", "rate": "8"},
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    const green = Color(0xff10B981);
    const blue = Color(0xff615EFF);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffDDE2E9)),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xffEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: Color(0xff3478F6),
                  size: 17,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "Labour at Site",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff101828),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _controller.forward(from: 0);
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 17,
                  color: Color(0xff98A2B3),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 18,
                tooltip: "Refresh Animation",
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffE9EDFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff344EFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const Divider(
            height: 18,
            color: Color(0xffEEF0F3),
          ),

          // Centre label
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff101828),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  size: 7,
                    color: Color(0xff60A5FA),
                ),
                SizedBox(width: 6),
                Text(
                  "Labour at Site",
                  style: TextStyle(
                  color: Colors.white,
                      fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            ),
          ),
          const SizedBox(height: 8),
          // Column headings
          Row(
            children: [
              Expanded(
                child: _heading("NMR", green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _heading("Rate", blue),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Animated rows
          Stack(
            children: [
              // Connector lines start from NMR and Rate headings
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: _animatedConnectorLine(
                        const Color(0xff10B981),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _animatedConnectorLine(
                        const Color(0xff615EFF),
                      ),
                    ),
                  ],
                ),
              ),

              // Labour items
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  children: List.generate(labourData.length, (index) {
                    final item = labourData[index];

                    final start = index * 0.16;
                    final end = (start + 0.43).clamp(0.0, 1.0);

                    final animation = CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        start,
                        end,
                        curve: Curves.linear,
                      ),
                    );

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.25),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: _labourItemWithTooltip(
                          item["name"],
                            item["nmr"],
                            const Color(0xff10B981),
                          )
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _labourItemWithTooltip(
                                  item["name"],
                                  item["nmr"],
                                  const Color(0xff615EFF),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heading(String title, Color color) {
    return Container(
      height: 23,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: color == const Color(0xff10B981)
              ? const Color(0xff047857)
              : const Color(0xff4338CA),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _labourItem(
      String title,
      String value,
      Color color,
      ) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xffD9E0E8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 6,
            color: color,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xff344054),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 1,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: color.withOpacity(0.15),
              ),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color == const Color(0xff10B981)
                    ? const Color(0xff047857)
                    : const Color(0xff4338CA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labourItemWithTooltip(
      String title,
      String value,
      Color color,
      ) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      waitDuration: const Duration(milliseconds: 300),
      showDuration: const Duration(seconds: 4),
      preferBelow: false,
      verticalOffset: 12,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xff182235),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      richMessage: TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
        children: [
          TextSpan(
            text: "$title\n",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const TextSpan(
            text: "\nNMR Count: ",
            style: TextStyle(color: Color(0xff98A2B3)),
          ),
          TextSpan(
            text: "$value\n",
            style: const TextStyle(
              color: Color(0xff10B981),
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: "Rate Headcount: ",
            style: TextStyle(color: Color(0xff98A2B3)),
          ),
          const TextSpan(
            text: "10\n",
            style: TextStyle(color: Colors.white),
          ),
          const TextSpan(
            text: "Unit Daily Wage: ",
            style: TextStyle(color: Color(0xff98A2B3)),
          ),
          const TextSpan(
            text: "₹850\n",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: "Team / Subcontractor: ",
            style: TextStyle(color: Color(0xff98A2B3)),
          ),
          const TextSpan(
            text: "Shuttering Works Co",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      child: _labourItem(title, value, color),
    );
  }

  Widget _animatedConnectorLine(Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ConnectorLinePainter(
            progress: _controller.value,
            color: color,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}
class ConnectorLinePainter extends CustomPainter {
  final double progress;
  final Color color;

  ConnectorLinePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height * progress),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ConnectorLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


class EmployeeLeaveFlipCard extends StatefulWidget {
  const EmployeeLeaveFlipCard({super.key});

  @override
  State<EmployeeLeaveFlipCard> createState() =>
      _EmployeeLeaveFlipCardState();
}

class _EmployeeLeaveFlipCardState extends State<EmployeeLeaveFlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Color blue = const Color(0xFF2463FF);
  final Color green = const Color(0xFF00C389);
  final Color orange = const Color(0xFFFFB000);
  final Color cyan = const Color(0xFF00B8F0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  void flipCard() {
    if (_controller.value >= 0.5) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;
        final showBack = value >= 0.5;

        final angle = value < 0.5
            ? value * pi
            : (value - 1) * pi;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: showBack
              ? _detailsCard()
              : _availabilityCard(),
        );
      },
    );
  }

  // FIRST SCREEN
  Widget _availabilityCard() {
    return _mainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconBox(Icons.calendar_month, blue),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "Employee Leave & Availability",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
              InkWell(
                onTap: flipCard,
                child: const Icon(
                  Icons.swap_horiz,
                  color: Color(0xFF8996AB),
                  size: 21,
                ),
              ),
            ],
          ),

          const Divider(height: 20, color: Color(0xFFEFF1F5)),

          const SizedBox(height: 8),

          Row(
            children: [
              const Text(
                "12",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                "TOTAL DAYS",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF929CAF),
                ),
              ),
              const SizedBox(width: 8),
              _pill("↑ 67% Available", green),
              const Spacer(),
              _employeeTag(),
            ],
          ),

          const SizedBox(height: 32),

          // Availability bar
          Row(
            children: [
              _bar(53, blue),
              const SizedBox(width: 6),
              _bar(27, green),
              const SizedBox(width: 6),
              _bar(7, cyan),
              const SizedBox(width: 6),
              _bar(13, orange),
            ],
          ),

          const SizedBox(height: 35),

          // Legend
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _legend("Available", "53 %", "8d", blue),
                    const SizedBox(height: 9),
                    _legend("Pending Leave", "7 %", "1d", cyan),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    _legend("On Leave", "27 %", "4d", green),
                    const SizedBox(height: 9),
                    _legend("Holiday", "13 %", "2d", orange),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: _dateInfo(
                  Icons.access_time,
                  "UPCOMING LEAVE",
                  "26 Sep 2026",
                  blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _dateInfo(
                  Icons.wb_sunny_outlined,
                  "NEXT HOLIDAY",
                  "02 Oct 2026",
                  orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // SECOND SCREEN
  Widget _detailsCard() {
    return _mainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconBox(Icons.description_outlined, blue),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  "Employee Leave Details",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: flipCard,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E9FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.swap_horiz,
                          size: 15, color: Color(0xFF4263EB)),
                      SizedBox(width: 5),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: Color(0xFF4263EB),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              CircleAvatar(
                radius: 11,
                backgroundColor: const Color(0xFFE3EDFF),
                child: Text(
                  "RK",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: blue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "R. Karthik  ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "(EMP00125)",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF9AA3B3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _pill("66.7% Available", green),
            ],
          ),

          const SizedBox(height: 8),

          // Summary
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              border: Border.all(color: const Color(0xFFE0E5ED)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _summary("TOTAL", "12 Days", Colors.black87),
                _summary("AVAILABLE", "8 Days", blue),
                _summary("TAKEN", "4 Days", green),
                _summary("PENDING", "1 Day", orange),
              ],
            ),
          ),

          const SizedBox(height: 7),

          // Progress line
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Expanded(
                  flex: 67,
                  child: Container(height: 5, color: blue),
                ),
                Expanded(
                  flex: 27,
                  child: Container(height: 5, color: green),
                ),
                Expanded(
                  flex: 6,
                  child: Container(height: 5, color: orange),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "RECENT LEAVE HISTORY",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8490A3),
                ),
              ),
              Text(
                "LAST 3 RECORDS",
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF9AA3B3),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          _leaveHistory(
            "Sick Leave",
            "14 Aug 2026 • 2 Days",
            "Approved",
            green,
          ),
          _leaveHistory(
            "Casual Leave",
            "02 Jul 2026 • 2 Days",
            "Approved",
            green,
          ),
          _leaveHistory(
            "Earned Leave",
            "26 Sep 2026 • 1 Day",
            "Pending",
            orange,
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: _dateInfo(
                  Icons.access_time,
                  "UPCOMING LEAVE",
                  "26 Sep 2026",
                  blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _dateInfo(
                  Icons.wb_sunny_outlined,
                  "NEXT HOLIDAY",
                  "02 Oct 2026",
                  orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // COMMON WIDGETS

  Widget _mainCard({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 360,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFDDE3EC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _iconBox(IconData icon, Color color) {
    return Container(
      height: 27,
      width: 27,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }

  Widget _employeeTag() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFDCE2EB)),
      ),
      child: const Text(
        "R. Karthik  -  EMP00125",
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: Color(0xFF536074),
        ),
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          color: color == green
              ? const Color(0xFF079A6A)
              : color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bar(int flex, Color color) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 33,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CustomPaint(
            painter: _StripePainter(),
          ),
        ),
      ),
    );
  }

  Widget _legend(
      String title,
      String percentage,
      String days,
      Color color,
      ) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF536074),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          "($days)",
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF9AA3B3),
          ),
        ),
      ],
    );
  }

  Widget _dateInfo(
      IconData icon,
      String heading,
      String date,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFDCE2EB)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          _iconBox(icon, color),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9AA3B3),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF273449),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summary(String title, String value, Color color) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Color(0xFFE1E6EF)),
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF929CAF),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leaveHistory(
      String title,
      String date,
      String status,
      Color color,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFD),
        border: Border.all(color: const Color(0xFFE2E7EF)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF9AA3B3),
                  ),
                ),
              ],
            ),
          ),
          _pill(status, color),
        ],
      ),
    );
  }
}

// STRIPED AVAILABILITY BAR
class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 4;

    for (double x = -size.height; x < size.width; x += 12) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


enum MaterialFilter {
  total,
  available,
  lowStock,
  shortage,
}

class MaterialItem {
  final String id;
  final String name;
  final String unit;
  final String code;
  final int available;
  final int required;
  final MaterialFilter status;

  const MaterialItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.code,
    required this.available,
    required this.required,
    required this.status,
  });
}

class MaterialStatusCard extends StatefulWidget {
  const MaterialStatusCard({super.key});

  @override
  State<MaterialStatusCard> createState() =>
      _MaterialStatusCardState();
}

class _MaterialStatusCardState extends State<MaterialStatusCard> {
  MaterialFilter selectedFilter = MaterialFilter.total;
  String? selectedMaterialId;

  final List<MaterialItem> materials = const [
    MaterialItem(
      id: '1',
      name: 'Cement',
      unit: 'Bag',
      code: 'CE',
      available: 420,
      required: 500,
      status: MaterialFilter.available,
    ),
    MaterialItem(
      id: '2',
      name: 'Steel',
      unit: 'Ton',
      code: 'ST',
      available: 280,
      required: 300,
      status: MaterialFilter.available,
    ),
    MaterialItem(
      id: '3',
      name: 'Bricks',
      unit: 'Nos',
      code: 'BR',
      available: 6200,
      required: 6500,
      status: MaterialFilter.available,
    ),
    MaterialItem(
      id: '4',
      name: 'Sand',
      unit: 'Ton',
      code: 'SA',
      available: 45,
      required: 120,
      status: MaterialFilter.lowStock,
    ),
    MaterialItem(
      id: '5',
      name: '20mm Aggregate',
      unit: 'Ton',
      code: '2A',
      available: 25,
      required: 90,
      status: MaterialFilter.lowStock,
    ),
    MaterialItem(
      id: '6',
      name: 'M-Sand',
      unit: 'Ton',
      code: 'M-',
      available: 12,
      required: 80,
      status: MaterialFilter.shortage,
    ),
  ];

  Color getStatusColor(MaterialFilter status) {
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

  String getStatusText(MaterialFilter status) {
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

  List<MaterialItem> get filteredMaterials {
    if (selectedFilter == MaterialFilter.total) {
      return materials;
    }

    return materials
        .where((item) => item.status == selectedFilter)
        .toList();
  }

  int get availableCount => materials
      .where((e) => e.status == MaterialFilter.available)
      .length;

  int get lowStockCount => materials
      .where((e) => e.status == MaterialFilter.lowStock)
      .length;

  int get shortageCount => materials
      .where((e) => e.status == MaterialFilter.shortage)
      .length;

  void changeFilter(MaterialFilter filter) {
    setState(() {
      selectedFilter = filter;
      selectedMaterialId = null;
    });
  }

  void selectMaterial(MaterialItem item) {
    setState(() {
      selectedMaterialId =
      selectedMaterialId == item.id ? null : item.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE3EA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF5FF),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  size: 16,
                  color: Color(0xFF2463FF),
                ),
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Material Status',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaterialStatusDetailsPage(
                        materialsItem: materialItem,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EDFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF315DFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // FOUR FILTER COLUMNS
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: const Color(0xFFDCE3EC),
              ),
            ),
            child: Row(
              children: [
                _filterColumn(
                  'TOTAL ITEMS',
                  materials.length.toString(),
                  MaterialFilter.total,
                  const Color(0xFF172033),
                ),
                _filterColumn(
                  'AVAILABLE',
                  availableCount.toString(),
                  MaterialFilter.available,
                  const Color(0xFF00B982),
                ),
                _filterColumn(
                  'LOW STOCK',
                  lowStockCount.toString(),
                  MaterialFilter.lowStock,
                  const Color(0xFFFF9100),
                ),
                _filterColumn(
                  'SHORTAGE',
                  shortageCount.toString(),
                  MaterialFilter.shortage,
                  const Color(0xFFFF315E),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // FILTERED MATERIAL LIST
          ...filteredMaterials.map((item) {
            final isSelected = selectedMaterialId == item.id;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                _materialRow(item, isSelected),

                if (isSelected)
                  Positioned(
                    bottom: 42,
                    left: 100,
                    child: Material(
                      color: Colors.transparent,
                      child: _materialTooltip(item),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // FILTER COLUMN
  Widget _filterColumn(
      String title,
      String count,
      MaterialFilter filter,
      Color color,
      ) {
    final selected = selectedFilter == filter;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => changeFilter(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              selected ? 0.9 : 0,
            ),
            border: selected
                ? Border.all(color: color, width: 1)
                : null,
          ),
          child: Column(
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF98A2B3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                count,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // MATERIAL ROW
  Widget _materialRow(
      MaterialItem item,
      bool isSelected,
      ) {
    final color = getStatusColor(item.status);
    final percentage = item.available / item.required;

    return GestureDetector(
      onTap: () => selectMaterial(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF5F8FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: isSelected
                ? color
                : const Color(0xFFDCE2E9),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 22,
              width: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withOpacity(0.13),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                item.code,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),

            const SizedBox(width: 7),

            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263244),
                    ),
                  ),
                  Text(
                    item.unit,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EDF2),
                    border: Border.all(
                      color: const Color(0xFFDCE2E9),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: (percentage * 100).round(),
                        child: Container(
                          color: color,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              flex: 2,
              child: Text(
                '${item.available} / ${item.required}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF344054),
                ),
              ),
            ),

            const SizedBox(width: 4),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                getStatusText(item.status),
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CUSTOM TOOLTIP WITH SHARP EDGES
  Widget _materialTooltip(MaterialItem item) {
    final color = getStatusColor(item.status);
    final percentage =
    (item.available / item.required * 100).round();

    return SizedBox(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TOOLTIP BODY
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFF182236),
              borderRadius: BorderRadius.zero,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _tooltipStatus(
                      getStatusText(item.status),
                      color,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _tooltipInfo(
                  'Available Stock:',
                  '${item.available} ${item.unit}',
                ),
                _tooltipInfo(
                  'Required Target:',
                  '${item.required} ${item.unit}',
                ),
                _tooltipInfo(
                  'Reorder Threshold:',
                  '${(item.required * 0.625).round()} ${item.unit}',
                  valueColor: const Color(0xFFFFC928),
                ),
                _tooltipInfo(
                  'Stock Fulfillment:',
                  '$percentage%',
                  valueColor: color,
                ),
              ],
            ),
          ),

          // DOWNWARD POINTER
          CustomPaint(
            size: const Size(18, 9),
            painter: _TooltipDownArrowPainter(),
          ),
        ],
      ),
    );
  }

  Widget _tooltipStatus(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 8,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _tooltipInfo(
      String title,
      String value, {
        Color valueColor = Colors.white,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF9EADC2),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

// TRIANGLE POINTER
class _TooltipDownArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF182236);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class MaterialItems {
  final String id;
  final String name;
  final String unit;
  final String code;
  final int available;
  final int required;
  final int reorderLevel;
  final MaterialFilter status;

  const MaterialItems({
    required this.id,
    required this.name,
    required this.unit,
    required this.code,
    required this.available,
    required this.required,
    required this.reorderLevel,
    required this.status,
  });
}

final List<MaterialItems> materialItem = const [
  MaterialItems(
    id: '1',
    name: 'Cement',
    unit: 'Bag',
    code: 'CE',
    available: 420,
    required: 500,
    reorderLevel: 100,
    status: MaterialFilter.available,
  ),
  MaterialItems(
    id: '2',
    name: 'Steel',
    unit: 'Ton',
    code: 'ST',
    available: 280,
    required: 300,
    reorderLevel: 50,
    status: MaterialFilter.available,
  ),
  MaterialItems(
    id: '3',
    name: 'Bricks',
    unit: 'Nos',
    code: 'BR',
    available: 6200,
    required: 6500,
    reorderLevel: 2000,
    status: MaterialFilter.available,
  ),
  MaterialItems(
    id: '4',
    name: 'Sand',
    unit: 'Ton',
    code: 'SA',
    available: 45,
    required: 120,
    reorderLevel: 80,
    status: MaterialFilter.lowStock,
  ),
  MaterialItems(
    id: '5',
    name: 'M-Sand',
    unit: 'Ton',
    code: 'M-',
    available: 12,
    required: 80,
    reorderLevel: 50,
    status: MaterialFilter.shortage,
  ),
  MaterialItems(
    id: '6',
    name: 'Binding Wire',
    unit: 'Kg',
    code: 'BW',
    available: 450,
    required: 400,
    reorderLevel: 100,
    status: MaterialFilter.available,
  ),
  MaterialItems(
    id: '7',
    name: '20mm Aggregate',
    unit: 'Ton',
    code: '2A',
    available: 25,
    required: 90,
    reorderLevel: 40,
    status: MaterialFilter.lowStock,
  ),
];


class UpcomingInwardDetails extends StatelessWidget {
  UpcomingInwardDetails({super.key});

  final List<Map<String, dynamic>> inwardList = [
    {
      "material": "Cement",
      "date": "04 Oct 2026",
      "supplier": "ABC Supplier",
      "po": "PO-1025",
      "qty": "500 Bag",
      "status": "In Transit",
    },
    {
      "material": "Steel",
      "date": "05 Oct 2026",
      "supplier": "XYZ Supplier",
      "po": "PO-1028",
      "qty": "10 Ton",
      "status": "Expected",
    },
    // {
    //   "material": "Bricks",
    //   "date": "06 Oct 2026",
    //   "supplier": "Local Supplier",
    //   "po": "PO-1030",
    //   "qty": "5,000 Nos",
    //   "status": "Confirmed",
    // },
    // {
    //   "material": "M-Sand",
    //   "date": "07 Oct 2026",
    //   "supplier": "RMC Supplier",
    //   "po": "PO-1032",
    //   "qty": "20 Ton",
    //   "status": "In Transit",
    // },
    // {
    //   "material": "Electrical Items",
    //   "date": "08 Oct 2026",
    //   "supplier": "Electricals Co.",
    //   "po": "PO-1035",
    //   "qty": "50 Nos",
    //   "status": "Expected",
    // },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8EF)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Upcoming Inward Details",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                "${inwardList.length} Upcoming",
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF7C3AED),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const UpcomingInwardViewAllScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EDFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF315DFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...inwardList.map((item) {
            final color = statusColor(item["status"]);

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
                          item["material"],
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
                          item["status"],
                          style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: _info(
                          "Supplier",
                          item["supplier"],
                        ),
                      ),
                      _info("Quantity", item["qty"]),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(height: 1),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PO: ${item["po"]}",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Expected: ${item["date"]}",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
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
          ),
        ),
      ],
    );
  }
}


class WorkWiseLabourCard extends StatefulWidget {
  const WorkWiseLabourCard({super.key});

  @override
  State<WorkWiseLabourCard> createState() =>
      _WorkWiseLabourCardState();
}

class _WorkWiseLabourCardState extends State<WorkWiseLabourCard> {
  bool isExpanded = false;

  final List<Map<String, dynamic>> trades = [
    {"name": "MC", "count": 50, "color": const Color(0xFF397BFF)},
    {"name": "FC", "count": 70, "color": const Color(0xFF6565F5)},
    {"name": "Mason", "count": 20, "color": const Color(0xFFFFA000)},
    {"name": "Carpenter", "count": 15, "color": const Color(0xFF10B981)},
    {"name": "Electrician", "count": 15, "color": const Color(0xFF9657F5)},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E4EB)),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F5FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.groups_outlined,
                  color: Color(0xFF2864F0),
                  size: 18,
                ),
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  "Work-wise Labour Requirement",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const LabourAllocationViewAllScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EDFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF315DFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Main project card
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFFE8EFFF),
                  Color(0xFFD5E2FF),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFE0E5ED)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2864FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Project name and status
                          Row(
                            children: [
                              const Text(
                                "RKCPL PROJECT",
                                style: TextStyle(
                                  color: Color(0xFF245EFF),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(width: 9),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFFFF7),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xFFD1E9DE),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 6, color: Color(0xFF10B981)),
                                    SizedBox(width: 4),
                                    Text(
                                      "Active",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Color(0xFF059669),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Work and required count
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Block A – Slab Work",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF172033),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "170",
                                    style: TextStyle(
                                      fontSize: 36,
                                      height: 1,
                                      color: Color(0xFF2864F0),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    "WORKERS REQUIRED",
                                    style: TextStyle(
                                      fontSize: 9,
                                      letterSpacing: 1,
                                      color: Colors.blueGrey.shade300,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // Requirement details
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xFFDCE1E9)),
                            ),
                            child: Row(
                              children: [
                                _detail("REQUIREMENT DATE", "12 Oct 2026"),
                                _detail("SHIFT", "Day Shift"),
                                _detail("SUPERVISOR", "Er. Suresh Kumar"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 17),

                          // Trade heading and expand button
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "5 TRADES",
                                  style: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 0.7,
                                    color: Color(0xFF9AA4B5),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      isExpanded ? "Show less" : "Show all",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF8994A7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: 15,
                                      color: const Color(0xFF8994A7),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Collapsed trade chips
                          if (!isExpanded)
                            Wrap(
                              spacing: 7,
                              runSpacing: 7,
                              children: [
                                ...trades.take(3).map((trade) {
                                  return _tradeChip(trade);
                                }),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 9),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F2F5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "+2 more",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF697386),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          // Expanded trade table
                          if (isExpanded)
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFDCE1E9),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    Container(
                                      color: const Color(0xFFF7F8FA),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Labour Category",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF778196),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Required",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF778196),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(width: 2),
                                        ],
                                      ),
                                    ),

                                    ...trades.map((trade) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: trade["color"],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                trade["name"],
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF263247),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${trade["count"]}",
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF172033),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),

                                    Container(
                                      color: const Color(0xFFF7F8FA),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 11),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Total",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF172033),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "170",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF172033),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
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

  Widget _detail(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Color(0xFFE5E8EF)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF9AA4B5),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF273348),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tradeChip(Map<String, dynamic> trade) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 5, 5, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E5ED)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: trade["color"],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            trade["name"],
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF687386),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 7),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 7, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF172033),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${trade["count"]}",
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class UpcomingSiteTasksCard extends StatelessWidget {
  const UpcomingSiteTasksCard({super.key});

  static const Color primaryColor = Color(0xFF2864F0);
  static const Color borderColor = Color(0xFFD8DDE6);

  final List<Map<String, dynamic>> tasks = const [
    {
      "day": "04",
      "month": "OCT",
      "title": "Slab Work Concreting",
      "block": "Block B",
      "team": "Civil Team A",
      "status": "Planned",
    },
    {
      "day": "05",
      "month": "OCT",
      "title": "Rebar Inspection & Testing",
      "block": "Block A",
      "team": "Quality Inspector",
      "status": "Planned",
    },
    {
      "day": "06",
      "month": "OCT",
      "title": "Plumbing Shaft Pressure Test",
      "block": "Block C",
      "team": "MEP Subcontractor",
      "status": "In Progress",
    },
    {
      "day": "07",
      "month": "OCT",
      "title": "External Scaffolding Erection",
      "block": "Block B",
      "team": "Scaffold Crew",
      "status": "Planned",
    },
    {
      "day": "08",
      "month": "OCT",
      "title": "Electrical Conduit Inspection",
      "block": "Block A",
      "team": "Electrical Team",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: primaryColor,
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming Site Tasks",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172033),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "5 scheduled activities",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF8994A7),
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  // Navigate to View All screen
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF0FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Divider(
            height: 1,
            color: Color(0xFFEDF0F4),
          ),

          const SizedBox(height: 12),

          // Task List
          ...tasks.take(4).map(
                (task) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _taskCard(task),
            ),
          ),

          // Bottom View All
          GestureDetector(
            onTap: () {
              // Navigate to View All screen
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FD),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: const Color(0xFFE8ECF3)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View all upcoming tasks",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskCard(Map<String, dynamic> task) {
    final String status = task["status"];

    Color statusColor;
    Color statusBg;

    switch (status) {
      case "In Progress":
        statusColor = const Color(0xFFD98716);
        statusBg = const Color(0xFFFFF5E5);
        break;

      case "Completed":
        statusColor = const Color(0xFF0B9B67);
        statusBg = const Color(0xFFE9F9F1);
        break;

      default:
        statusColor = const Color(0xFF3478F6);
        statusBg = const Color(0xFFEFF5FF);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Date Badge
        Container(
          width: 46,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF172033),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 9),

        // Task Details
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFBFD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFDCE1E9)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task["title"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF172033),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Block and Team
                Row(
                  children: [
                    const Icon(
                      Icons.apartment_outlined,
                      size: 13,
                      color: Color(0xFF8994A7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      task["block"],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF536176),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Icon(
                      Icons.groups_outlined,
                      size: 13,
                      color: Color(0xFF8994A7),
                    ),
                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        task["team"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF536176),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}