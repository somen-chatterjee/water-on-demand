import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/components/my_jobs_screen_loading.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/components/myjobs_list_card.dart';

import '../../../utils/base_colors.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/base_no_data.dart';
import '../../base_components/base_app_bar_bg_driver.dart';
import '../../base_components/base_container.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/listview_builder_animation.dart';
import 'controller/driver_job_list_controller.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  DriverJobListController controller = Get.find<DriverJobListController>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void selectIndex(int index) {
    setState(() {
      if (index != controller.selectedIndex.value) {
        controller.selectedIndex.value = index;
        controller.driverJobList();
      }
    });
  }

  @override
  void initState() {
    controller.driverJobList();
    super.initState();
  }

  @override
  void dispose() {
    controller.selectedIndex.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  buildSizeHeight(103),
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      header: const WaterDropMaterialHeader(
                        backgroundColor: BaseColors.secondaryColor,
                      ),
                      onRefresh: () {
                        controller.driverJobList();
                        refreshController.refreshCompleted();
                      },
                      child: SingleChildScrollView(
                        child: Obx(() {
                          return AnimatedColumn(
                            leftPadding: 0.0,
                            rightPadding: 0.0,
                            children: [
                              buildSizeHeight(35),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          selectIndex(0);
                                        },
                                        child: BaseContainer(
                                          bottomMargin: 0.0,
                                          borderRadius: 8,
                                          leftPadding: 0.0,
                                          rightPadding: 0.0,
                                          topPadding: 0.0,
                                          bottomPadding: 0.0,
                                          height: 46,
                                          boxShadow: const BoxShadow(
                                            color: BaseColors.lightSky,
                                            spreadRadius: 1.0,
                                            blurRadius: 2.0,
                                          ),
                                          border: Border.all(
                                            color: controller
                                                        .selectedIndex.value ==
                                                    0
                                                ? BaseColors.secondaryColor
                                                : BaseColors.lightSky,
                                            width: 1.0,
                                          ),
                                          child: Center(
                                            child: BaseText(
                                              textAlign: TextAlign.center,
                                              value: 'New',
                                              color: controller.selectedIndex
                                                          .value ==
                                                      0
                                                  ? BaseColors.secondaryColor
                                                  : BaseColors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    buildSizeWidth(20),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          selectIndex(1);
                                        },
                                        child: BaseContainer(
                                          bottomMargin: 0.0,
                                          borderRadius: 8,
                                          leftPadding: 0.0,
                                          rightPadding: 0.0,
                                          topPadding: 0.0,
                                          bottomPadding: 0.0,
                                          height: 46,
                                          boxShadow: const BoxShadow(
                                            color: BaseColors.lightSky,
                                            spreadRadius: 1.0,
                                            blurRadius: 2.0,
                                          ),
                                          border: Border.all(
                                            color: controller
                                                        .selectedIndex.value ==
                                                    1
                                                ? BaseColors.secondaryColor
                                                : BaseColors.lightSky,
                                            width: 1.0,
                                          ),
                                          child: Center(
                                            child: BaseText(
                                              textAlign: TextAlign.center,
                                              value: 'Cancelled',
                                              color: controller.selectedIndex
                                                          .value ==
                                                      1
                                                  ? BaseColors.secondaryColor
                                                  : BaseColors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    buildSizeWidth(20),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          selectIndex(2);
                                        },
                                        child: BaseContainer(
                                          bottomMargin: 0.0,
                                          borderRadius: 8,
                                          leftPadding: 0.0,
                                          rightPadding: 0.0,
                                          topPadding: 0.0,
                                          bottomPadding: 0.0,
                                          height: 46,
                                          boxShadow: const BoxShadow(
                                            color: BaseColors.lightSky,
                                            spreadRadius: 1.0,
                                            blurRadius: 2.0,
                                          ),
                                          border: Border.all(
                                            color: controller
                                                        .selectedIndex.value ==
                                                    2
                                                ? BaseColors.secondaryColor
                                                : BaseColors.lightSky,
                                            width: 1.0,
                                          ),
                                          child: Center(
                                            child: BaseText(
                                              textAlign: TextAlign.center,
                                              value: 'Completed',
                                              color: controller.selectedIndex
                                                          .value ==
                                                      2
                                                  ? BaseColors.secondaryColor
                                                  : BaseColors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildSizeHeight(18),
                              Obx(() {
                                if(controller.isDriverJobLoading.value) {
                                  return const MyJobsScreenLoading();
                                }

                                if ((controller.orderItemDataList?.length ??
                                        0) ==
                                    0) {
                                  return Column(
                                    children: [
                                      buildSizeHeight(150.0),
                                      const BaseNoData(),
                                    ],
                                  );
                                }

                                return ListView.builder(
                                  itemCount:
                                      controller.orderItemDataList?.length ?? 0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return ListviewBuilderAnimation(
                                      index: index,
                                      child: SingleChildScrollView(
                                          child: MyJobsListCard(index: index),
                                      ),
                                    );
                                  },
                                );
                              }),
                              buildSizeHeight(30),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              const BaseAppBarBgDriver(),
            ],
          ),
        ),
      ),
    );
  }
}
