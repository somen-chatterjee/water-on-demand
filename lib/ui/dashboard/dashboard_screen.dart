
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/cart/controller/card_contoller.dart';
import 'package:water_on_demand/ui/dashboard/components/home_screen/home_screen.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/order_screen.dart';
import 'package:water_on_demand/ui/dashboard/components/products_screen/product_screen.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/profile/profile_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';

class DashboardScreen extends StatefulWidget {
  final int? bodyIndex;
  const DashboardScreen({super.key, this.bodyIndex});

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  CardController controller = Get.isRegistered() ? Get.find<CardController>() : Get.put(CardController());
  DashboardController dashboardController = Get.find<DashboardController>();

  List<Widget> bodyList = [
    const HomeScreen(),
    const OrderScreen(),
    const ProductScreen(),
    const ProfileScreen(isDriver: false),
  ];

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    dashboardController.getUserDetails();
    tabIndex = widget.bodyIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        extendBody: true,
        // resizeToAvoidBottomInset: true,
        body: bodyList[tabIndex], //destination screen
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            height: 90,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: const [
                BoxShadow(
                  color: BaseColors.lightSky,
                  blurRadius: 50,
                  spreadRadius: 0.01,
                ),
              ],
              // image: DecorationImage(
              //   image: AssetImage(
              //     BaseAssets.bottomBar,
              //   ),
              // ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    onTabChange(tab: 0);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                InkWell(
                  onTap: () {
                    onTabChange(tab: 1);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        tabIndex == 1
                            ? BaseAssets.orderFill
                            : BaseAssets.order,
                        width: 20,
                        height: 20,
                      ),
                      BaseText(
                        value: "Orders",
                        fontSize: 12,
                        color: tabIndex == 1
                            ? BaseColors.primaryColor
                            : BaseColors.grey,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ),
                // const BaseText(
                //   value: "Place Order",
                //   leftMargin: 10,
                //   fontSize: 12,
                //   color: BaseColors.grey,
                //   fontWeight: FontWeight.w400,
                // ),
                InkWell(
                  onTap: () {
                    onTabChange(tab: 2);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        tabIndex == 2
                            ? BaseAssets.productFill
                            : BaseAssets.product,
                        width: 20,
                        height: 20,
                      ),
                      BaseText(
                        value: "Products",
                        fontSize: 12,
                        color: tabIndex == 2
                            ? BaseColors.primaryColor
                            : BaseColors.grey,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    onTabChange(tab: 3);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        tabIndex == 3
                            ? BaseAssets.profileFill
                            : BaseAssets.profile,
                        width: 20,
                        height: 20,
                      ),
                      BaseText(
                        value: "Profile",
                        fontSize: 12,
                        color: tabIndex == 3
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
