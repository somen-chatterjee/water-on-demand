import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_app_bar_bg.dart';
import 'package:water_on_demand/ui/base_components/base_app_bar_bg_driver.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/profile/components/profile_screen_loading.dart';
import 'package:water_on_demand/ui/profile/edit_profile.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_no_data.dart';

import '../../utils/base_colors.dart';
import '../base_components/base_button.dart';
import '../base_components/base_text.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDriver;

  const ProfileScreen({
    super.key,
    required this.isDriver,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DashboardController dashboardController = Get.find<DashboardController>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                buildSizeHeight(103),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    header: const WaterDropMaterialHeader(
                      backgroundColor: BaseColors.secondaryColor,
                    ),
                    onRefresh: () {
                      dashboardController.getUserDetails();
                      _refreshController.refreshCompleted();
                    },
                    child: SingleChildScrollView(
                      child: GetBuilder<DashboardController>(
                        builder: (dController) {
                          if(dController.isProfileLoading.value) {
                            return const ProfileScreenLoading();
                          }

                          if(dController.profileData == null) {
                            return Column(
                              children: [
                                buildSizeHeight(180),
                                const BaseNoData(),
                              ],
                            );
                          }
                          return AnimatedColumn(
                            children: [
                              buildSizeHeight(35),
                              Column(
                                children: [
                                  ClipOval(
                                    // radius: 50,
                                    child: dController.profileData == null &&
                                        dController
                                            .profileData!.userImage ==
                                            null
                                        ? Image.asset(
                                      BaseAssets.profileImage,
                                      height: 110,
                                    )
                                        : CachedNetworkImage(
                                      imageUrl: dController
                                          .profileData!.userImage!,
                                      height: 110,
                                      width: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  buildSizeHeight(10),
                                  if (dController.profileData != null)
                                    BaseText(
                                      value:
                                      dController.profileData!.fullName ??
                                          "",
                                      fontSize: 14,
                                      color: BaseColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                ],
                              ),
                              buildSizeHeight(10),
                              Container(
                                color:
                                BaseColors.secondaryColor.withOpacity(0.2),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 20.5,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(BaseAssets.message),
                                      Flexible(
                                        child: AnimatedColumn(
                                          leftPadding: 12.0,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            const BaseText(
                                              value: 'Email Address',
                                              fontSize: 13,
                                              color: BaseColors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            if (dController.profileData != null)
                                              BaseText(
                                                value: dController.profileData!
                                                    .emailAddress ??
                                                    "",
                                                fontSize: 16,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                color: BaseColors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              buildSizeHeight(20),
                              Container(
                                color:
                                BaseColors.secondaryColor.withOpacity(0.2),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.5),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(BaseAssets.telephone),
                                      AnimatedColumn(
                                        leftPadding: 12.0,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const BaseText(
                                            value: 'Mobile Number',
                                            fontSize: 13,
                                            color: BaseColors.black,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          BaseText(
                                            value:
                                            '+27 ${dController.profileData!.mobileNumber ?? ""}',
                                            fontSize: 16,
                                            color: BaseColors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              buildSizeHeight(20),
                              BaseButton(
                                borderRadius: double.nan,
                                title: 'Edit Profile',
                                onPressed: () {
                                  Get.to(const EditProfile());
                                },
                              ),
                              buildSizeHeight(20),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseButton(
                                      borderRadius: 0.0,
                                      borderColor: BaseColors.primaryColor,
                                      btnColor: BaseColors.white,
                                      borderEnable: true,
                                      title: 'Log Out',
                                      btnTextColor: BaseColors.primaryColor,
                                      onPressed: () {
                                        clearSessionData();
                                      },
                                    ),
                                  ),
                                  buildSizeWidth(20),
                                  Expanded(
                                    child: BaseButton(
                                      btnWidth: 150,
                                      borderRadius: double.nan,
                                      title: 'Address',
                                      onPressed: () {
                                        dController.getUserAddressList(
                                            context: context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              buildSizeHeight(150),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            widget.isDriver ? const BaseAppBarBgDriver() : const BaseAppBarBg(),
          ],
        ),
      ),
    );
  }
}
