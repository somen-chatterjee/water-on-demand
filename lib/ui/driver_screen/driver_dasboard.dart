
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/driver_screen/driver_home_screen/controller/driver_home_data_controller.dart';
import 'package:water_on_demand/ui/driver_screen/driver_home_screen/driver_home_screen.dart';
import 'package:water_on_demand/ui/profile/profile_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';

import 'myJobs_screens/my_jobs_screen.dart';

class DriverDashboardScreen extends StatefulWidget {
  final int? bodyIndex;
  const DriverDashboardScreen({super.key, this.bodyIndex});

  @override
  State<DriverDashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DriverDashboardScreen> {
  DashboardController dashboardController = Get.find<DashboardController>();
  DriverHomeDataController driverHomeDataCtrl = Get.put(DriverHomeDataController());

  List<Widget> bodyList = [
    const DriverHomeScreen(),
    const MyJobsScreen(),
    const ProfileScreen(isDriver: true),
  ];

  int tabIndex = 0;
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        tabIndex=widget.bodyIndex ?? 0;
      });
      dashboardController.getUserDetails();
    });
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            height: 90,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: BaseColors.shadowColor,
                  blurRadius: 100,
                  spreadRadius: 0.01,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(
                  BaseAssets.bottomBar,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      onTabChange(tab: 0);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          tabIndex == 0
                              ? BaseAssets.homeFill
                              : BaseAssets.home,
                          width: 20,
                          height: 20,
                        ),
                        BaseText(
                          value: "Home",
                          fontSize: 12,
                          color: tabIndex == 0
                              ? BaseColors.primaryColor
                              : BaseColors.grey,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ),
                  const BaseText(
                    value: "My Jobs",
                    leftMargin: 10,
                    fontSize: 12,
                    color: BaseColors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  InkWell(
                    onTap: () {
                      onTabChange(tab: 2);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          tabIndex == 2
                              ? BaseAssets.profileFill
                              : BaseAssets.profile,
                          width: 20,
                          height: 20,
                        ),
                        BaseText(
                          value: "Profile",
                          fontSize: 12,
                          color: tabIndex == 2
                              ? BaseColors.primaryColor
                              : BaseColors.grey,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            bodyList[tabIndex],
            //my jobs
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 80,
            //   child: InkWell(
            //     onTap: () {
            //       onTabChange(tab: 1);
            //     },
            //     child: SvgPicture.asset(BaseAssets.myJobIcon,width: 50,height: 50,),
            //   ),
            //my jobs
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  shape: const CircleBorder(
                      side: BorderSide.none
                  ),
                  backgroundColor:BaseColors.secondaryColor,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    onTabChange(tab: 1);

                  },
                  child: SvgPicture.asset(BaseAssets.myJobIcon,width: 50,height: 50,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTabChange({required int tab}) {
    if (tab == 0) {
      tabIndex = 0;
    }
    if (tab == 1) {
      tabIndex = 1;
    }
    if (tab == 2) {
      tabIndex = 2;
    }
    if (tab == 3) {
      tabIndex = 3;
    }
    setState(() {});
  }
}
