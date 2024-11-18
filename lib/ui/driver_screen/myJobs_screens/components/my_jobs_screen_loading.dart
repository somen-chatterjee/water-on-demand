import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/driver_screen/driver_details_screen/accept_screen.dart';
import 'package:water_on_demand/ui/driver_screen/complete_details_screen/complete_details_screen.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

import '../../../../utils/base_assets.dart';
import '../../../../utils/base_colors.dart';
import '../../../../utils/base_functions.dart';
import '../../../base_components/base_button.dart';
import '../../../base_components/base_text.dart';
import '../../../base_components/base_textfield.dart';
import '../controller/driver_job_list_controller.dart';

class MyJobsScreenLoading extends StatefulWidget {
  const MyJobsScreenLoading({super.key});

  @override
  State<MyJobsScreenLoading> createState() => _MyJobsScreenLoadingState();
}

class _MyJobsScreenLoadingState extends State<MyJobsScreenLoading> {
  DriverJobListController driverJobListController =
      Get.find<DriverJobListController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: BaseColors.lightSky,
                      blurRadius: 50,
                      spreadRadius: 0.01,
                    ),
                  ],
                ),
                child: AnimatedColumn(
                  leftPadding: 0,
                  rightPadding: 0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BaseShimmer(
                            width: 120,
                            height: 20,
                          ),
                          Row(
                            children: [
                              if(driverJobListController.selectedIndex.value ==
                                  0)
                                const BaseShimmer(
                                  width: 38,
                                  height: 38,
                                  borderRadius: 25,
                                )
                              else
                                buildSizeHeight(38),
                              buildSizeWidth(10),
                              const BaseShimmer(
                                width: 38,
                                height: 38,
                                borderRadius: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: BaseShimmer(
                        width: 150,
                        height: 20,
                      ),
                    ),
                    buildSizeHeight(8.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: BaseShimmer(
                        width: 180,
                        height: 20,
                      ),
                    ),
                    const BaseShimmer(
                      child: Divider(
                        color: BaseColors.primaryColor,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          const BaseShimmer(
                            width: 20,
                            height: 20,
                          ),
                          buildSizeWidth(5.0),
                          const Expanded(
                            child: BaseShimmer(
                              width: 180,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          const BaseShimmer(
                            width: 20,
                            height: 20,
                          ),
                          buildSizeWidth(5.0),
                          const Expanded(
                            child: BaseShimmer(
                              width: 180,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Visibility(
                            visible:
                                driverJobListController.selectedIndex.value ==
                                    0,
                            child: const Expanded(
                              child: BaseShimmer(
                                height: 55,
                              ),
                            ),
                          ),
                          buildSizeWidth(10),
                          Visibility(
                            visible:
                                driverJobListController.selectedIndex.value ==
                                    0,
                            child: const Expanded(
                              child: BaseShimmer(
                                height: 55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(15),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
