import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/controller/driver_job_list_controller.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

import '../../../../utils/base_colors.dart';
import '../../../../utils/base_functions.dart';

class DriverHomeScreenLoading extends StatefulWidget {
  const DriverHomeScreenLoading({super.key});

  @override
  State<DriverHomeScreenLoading> createState() => _DriverHomeScreenLoadingState();
}

class _DriverHomeScreenLoadingState extends State<DriverHomeScreenLoading> {
  DriverJobListController driverJobListController =
      Get.find<DriverJobListController>();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
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
                      color: BaseColors.shadowColor,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
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
                          const BaseShimmer(
                            width: 38,
                            height: 38,
                            borderRadius: 25,
                          )
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
                          const Expanded(
                            child: BaseShimmer(
                              height: 55,
                            ),
                          ),
                          buildSizeWidth(10),
                          const Expanded(
                            child: BaseShimmer(
                              height: 55,
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
