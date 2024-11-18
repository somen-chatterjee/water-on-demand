import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/dashboard/dashboard_screen.dart';
import 'package:water_on_demand/ui/driver_screen/driver_dasboard.dart';
import 'package:water_on_demand/ui/onboardings/boarding/boarding_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

import '../../driver_screen/controller/completekyc_controller.dart';
import '../intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CompleteKycController controller= Get.put(CompleteKycController());
  DashboardController dashboardController = Get.put(DashboardController());


  void goToNextScreen() async {
    String accessToken = await BaseStorage.read(StorageKeys.apiToken) ?? "";
    dynamic roleId = await BaseStorage.read(StorageKeys.roleId) ?? "";
    dynamic kycDetails = await BaseStorage.read(StorageKeys.kycDetails) ?? "";

    log("accessToken $accessToken");
    log("accessToken $roleId");
    log("accessToken $kycDetails");

    if(accessToken.isNotEmpty){
      if (roleId == CheckRoleId().driver) {
        // await dashboardController.getUserDetails();

        // if(dashboardController.profileData != null && kycDetails == "3") {
        if(kycDetails == "3") {
          Get.offAll(() => const DriverDashboardScreen());
          // checkDriverScreen(profileData: dashboardController.profileData!);
        } else {
          Get.to(()=> const BoardingScreen());
        }
        // Get.offAll(() => const DriverDashboardScreen());
      } else {
        Get.offAll(() => const DashboardScreen());
      }
    } else {
      Get.offAll(() => const IntroScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      Future.delayed(const Duration(milliseconds: 2700), () async {
        goToNextScreen();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Image.asset(
              height: double.maxFinite,
              BaseAssets.splashBg,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(BaseAssets.appLogo),
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
