import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import '../constants/storage_constant.dart';
import '../controller/logincontroller.dart';
import '../controller/punch_in_controller.dart';
import '../controller/site_location_controller.dart';
import '../db_helper/db_manager.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../models/punch_in_model.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../signalr_service.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/print_logger.dart';
import 'internetissue.dart';
import 'package:http/http.dart' as http;

final http.Client _httpClient = http.Client();

/// Send Request.....

Future<http.StreamedResponse> send(http.BaseRequest request) async {
  return _httpClient.send(request);
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController =
  Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());

  ConnectivityResult? connectivityResult;
  bool? isConnectionSuccessful;

  String versionName = "";
  String code = "";
  bool _hasError = false;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    _initializeApp();
  }

  Future<void> _initializeApp({bool isRefresh = false}) async {
    final stopwatch = Stopwatch()..start();

    if (isRefresh) {
      // keep the error screen visible, just disable the button
      setState(() => _isRefreshing = true);
    } else {
      _hasError = false;
    }

    bool failed = false;

    try {
      await ApiConfig.initializeUrl();
      await BaseUtitiles.getDeviceDetails();

      DBManager dbManager = DBManager();
      await dbManager.database;

      final ok = await SessionCheck();
      failed = !ok;
    } catch (e) {
      debugPrint("Splash Initialization Error: $e");
      failed = true;
    }

    if (!failed) return; // navigation already happened

    // On manual refresh, wait until 5 seconds have passed since the tap
    if (isRefresh) {
      final remaining = const Duration(seconds: 5) - stopwatch.elapsed;
      if (remaining > Duration.zero) {
        await Future.delayed(remaining);
      }
    }

    if (!mounted) return;

    setState(() {
      _hasError = true;
      _isRefreshing = false;
    });

  }

  /// returns true if it navigated away, false if validation failed
  Future<bool> SessionCheck() async {
    loginController.seassion_values = SessionStorage.readUser();

    if (loginController.seassion_values == null) {
      if (!mounted) return true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
      return true;
    }

    await loginController.getLoginNew_seassionvalues(context);

    if (!mounted) return true;

    if (loginController.user.value.success == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loginController.user.value.userType == "A"
              ? Dashboard_screen()
              : DashboardScreen_OtherUser(),
        ),
      );
      return true;
    }

    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _hasError
            ? Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/images/loading.gif',
                height: 100,
              ),

              const SizedBox(height: 20),

              const Text(
                "Connection Failed",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Unable to connect. Please try again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: _isRefreshing ? null : () => _initializeApp(isRefresh: true),
                icon: _isRefreshing
                    ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.refresh),
                label: Text(_isRefreshing ? "Please wait..." : "Refresh"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A3AFF),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade400, // disabled look
                  disabledForegroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Image.asset(
                'assets/images/loading.gif',
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Checking connection...",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
