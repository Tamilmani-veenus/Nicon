import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicon/controller/siteuserDashboard_controller.dart';

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
                              fontSize: 14,
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
            SizedBox(height: 12,),
            const LabourAtSiteCard(),
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

    final nmrLineAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.linear),
    );

    final rateLineAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.90, curve: Curves.linear),
    );

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
              children: [
                // Green pointing line
                Expanded(
                  child: Container(
                    height: 1.5,
                    color: const Color(0xff10B981),
                  ),
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
                  child: const Row(
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

                // Blue pointing line
                Expanded(
                  child: Container(
                    height: 1.5,
                    color: const Color(0xff615EFF),
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
      triggerMode: TooltipTriggerMode.longPress,
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

      // Removed textStyle

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

