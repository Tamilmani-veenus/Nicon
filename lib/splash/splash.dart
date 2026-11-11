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



  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      await BaseUtitiles.getDeviceDetails();

      DBManager dbManager = DBManager();
      await dbManager.database;

      if (!mounted) return;

      await SessionCheck();
    });
  }

  Future<void> SessionCheck() async {
    try {
      loginController.seassion_values = SessionStorage.readUser();

      if (loginController.seassion_values == null) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
        return;
      }

      await loginController.getLoginNew_seassionvalues(context);

      if (!mounted) return;

      if (loginController.user.value.success == true) {
        if (loginController.user.value.userType == "A") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard_screen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen_OtherUser(),
            ),
          );
        }
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      }
    } catch (e) {
      debugPrint("SessionCheck Error: $e");

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Image.asset('assets/images/loading.gif'),
          ),
        ],
      ),
    );
  }
}
