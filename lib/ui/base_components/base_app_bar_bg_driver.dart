import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/notification/notification_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

import '../../common_controller/common_controller.dart';

class BaseAppBarBgDriver extends StatefulWidget {
  const BaseAppBarBgDriver({
    super.key,
  });

  @override
  State<BaseAppBarBgDriver> createState() => _BaseAppBarBgDriverState();
}

class _BaseAppBarBgDriverState extends State<BaseAppBarBgDriver> {
  CommonController statusCtrl = Get.put(CommonController());
  DashboardController dashboardController = Get.find<DashboardController>();
  bool currentValue = true;

  @override
  void initState() {
    dashboardController.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          BaseAssets.appBarBg1,
          width: double.maxFinite,
          height: 128,
          fit: BoxFit.fitWidth,
        ),
        Column(
          children: [
            buildSizeHeight(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GetBuilder<DashboardController>(builder: (controller) {
                    return Expanded(
                      child: controller.isProfileLoading.value
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseShimmer(
                                  width: 120,
                                  height: 20,
                                ),
                                buildSizeHeight(8),
                                Row(
                                  children: [
                                    const Flexible(
                                      child: BaseShimmer(
                                        height: 20,
                                      ),
                                    ),
                                    buildSizeWidth(10),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.profileData != null)
                                  BaseText(
                                    value: controller.profileData!.fullName
                                        .toString(),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                if (controller.profileData != null &&
                                    controller.profileData!.addressData != null)
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      controller.getUserAddressList(
                                          context: context);
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: BaseText(
                                            value:
                                                '${controller.profileData!.addressData!.houseNumber.toString()}, ${controller.profileData!.addressData!.buildingName.toString()}, ${controller.profileData!.addressData!.address.toString()}',
                                            fontSize: 14,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                    );
                  }),
                  GetBuilder<DashboardController>(builder: (controller) {
                    currentValue = controller.profileData?.isOnline ?? false;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            activeColor: BaseColors.switchColor,
                            thumbColor:
                                const WidgetStatePropertyAll(Colors.black),
                            value: currentValue,
                            onChanged: (value) => setState(
                              () {
                                currentValue = value;
                                statusCtrl.saveOnlineStatus(value ? 1 : 0);
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const NotificationScreen());
                          },
                          child: Image.asset(
                            width: 50,
                            height: 50,
                            BaseAssets.notificationWithBg,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
