import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/driver_screen/driver_details_screen/accept_screen.dart';
import 'package:water_on_demand/ui/driver_screen/complete_details_screen/complete_details_screen.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/components/items_details_screen.dart';

import '../../../../utils/base_assets.dart';
import '../../../../utils/base_colors.dart';
import '../../../../utils/base_functions.dart';
import '../../../base_components/base_button.dart';
import '../../../base_components/base_text.dart';
import '../../../base_components/base_textfield.dart';
import '../controller/driver_job_list_controller.dart';

class MyJobsListCard extends StatefulWidget {
  final int index;

  const MyJobsListCard({super.key, required this.index});

  @override
  State<MyJobsListCard> createState() => _MyJobsListCardState();
}

class _MyJobsListCardState extends State<MyJobsListCard> {
  DriverJobListController controller = Get.find<DriverJobListController>();

  /*
  * index == 0 -> new
  * index == 1 -> Cancelled
  * index == 2 -> Completed
  * */

  @override
  Widget build(BuildContext context) {
    var orderedData = controller.orderItemDataList?[widget.index].orderedData;
    return GestureDetector(
      onTap: () {
        if (controller.selectedIndex.value == 0) {
          Get.to(() => AcceptScreen(
              orderItemId: controller.orderItemDataList?[widget.index]
                  .orderItemId,
            userOrderLocation: LatLng(
              double.parse(controller.orderItemDataList?[widget.index].orderData?.orderAddress?.latitude ?? "0.0"),
              double.parse(controller.orderItemDataList?[widget.index].orderData?.orderAddress?.longitude ?? "0.0"),
            ),
            destinationLocation: LatLng(
              double.parse(controller.orderItemDataList?[widget.index].orderData?.fromAddress?.adminLatitude ?? "0.0"),
              double.parse(controller.orderItemDataList?[widget.index].orderData?.fromAddress?.adminLongitude ?? "0.0"),
            ),
          ));
        } else {
          if (controller.selectedIndex.value == 2) {
            Get.to( CompleteDetailScreen(orderItemData: controller.orderItemDataList?[widget.index]));
          }
        }
      },
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(12)),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(orderedData != null && orderedData.isNotEmpty)
                              BaseText(
                                value: "# ${controller.orderItemDataList?[widget.index]
                                  .orderData?.orderId ?? ""}",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            if(orderedData != null && orderedData.isNotEmpty)
                            BaseText(
                              value: controller.orderItemDataList?[widget.index]
                                  .orderedData?[0].productData?.title ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Visibility(
                            visible: controller.selectedIndex.value == 0,
                            child: SvgPicture.asset(
                              BaseAssets.locationPin,
                            ),
                          ),
                          buildSizeWidth(10.0),
                          if(orderedData != null && orderedData.isNotEmpty)
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Get.to(() => ItemsDetailsScreen(orderedData: orderedData ?? []));
                            },
                            child: SvgPicture.asset(
                              BaseAssets.info,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildSizeHeight(5),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'R',
                        color: BaseColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          // if(driverList != null && driverList.isNotEmpty)
                            BaseText(
                              value: controller.orderItemDataList?[widget.index]
                                  .totalAmount ?? "",
                              color: BaseColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          // Visibility(
                          //   visible: widget.index != 0,
                          //   child: Row(
                          //     children: [
                          //       const Icon(
                          //         Icons.star,
                          //         color: CupertinoColors.systemYellow,
                          //         size: 20,
                          //       ),
                          //       buildSizeWidth(5),
                          //       const BaseText(
                          //         value: '4.5',
                          //         color: BaseColors.black,
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                if(orderedData != null && orderedData.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: BaseText(
                      value:
                      'Units :${controller.orderItemDataList?[widget.index]
                          .orderedData?[0].unit ?? ""} | ${controller
                          .orderItemDataList?[widget.index].orderedData?[0]
                          .productData?.quantity ?? ""}L | ${controller
                          .orderItemDataList?[widget.index].orderData?.distance ?? ""}',
                      color: BaseColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                const Divider(
                  color: BaseColors.primaryColor,
                  thickness: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      Flexible(
                        child: BaseText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          value:
                          '${controller.orderItemDataList?[widget.index]
                              .orderData?.orderAddress?.houseNumber ??
                              ""}, ${controller.orderItemDataList?[widget.index]
                              .orderData?.orderAddress?.buildingName ??
                              ""}, ${controller.orderItemDataList?[widget.index]
                              .orderData?.orderAddress?.address ?? ""}',
                          color: BaseColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
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
                      const Icon(Icons.calendar_month_outlined),
                      BaseText(
                        value: '${controller.orderItemDataList?[widget.index]
                            .orderData?.startDate ?? ""} to ${controller
                            .orderItemDataList?[widget.index].orderData
                            ?.endDate ?? ""}',
                        color: BaseColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                buildSizeHeight(20),
                  Obx(() {
                    if((controller.orderItemDataList?[widget.index].acceptBtn ??
                        false) ||
                        (controller.orderItemDataList?[widget.index].pickupBtn ??
                            false)) {
                      return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Visibility(
                        visible: controller.selectedIndex.value == 0,
                        child: Row(
                          children: [
                            Visibility(
                              visible: controller.orderItemDataList?[widget
                                  .index].acceptBtn ?? false,
                              child: Expanded(
                                child: BaseButton(
                                  borderRadius: 10,
                                  borderEnable: true,
                                  btnColor: BaseColors.white,
                                  title: 'Accept',
                                  borderColor: BaseColors.primaryColor,
                                  btnTextColor: BaseColors.primaryColor,
                                  onPressed: () {
                                    controller.driverAcceptOrder(
                                        orderItemId: controller.orderItemDataList?[widget
                                            .index].orderItemId,
                                        isAcceptScreen: false,
                                      userOrderLocation: LatLng(
                                        double.parse(controller.orderItemDataList?[widget.index].orderData?.orderAddress?.latitude ?? "0.0"),
                                        double.parse(controller.orderItemDataList?[widget.index].orderData?.orderAddress?.longitude ?? "0.0"),
                                      ),
                                      destinationLocation: LatLng(
                                        double.parse(controller.orderItemDataList?[widget.index].orderData?.fromAddress?.adminLatitude ?? "0.0"),
                                        double.parse(controller.orderItemDataList?[widget.index].orderData?.fromAddress?.adminLongitude ?? "0.0"),
                                      ),
                                    );
                                    // Get.to(const AcceptScreen());
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                                visible: controller.orderItemDataList?[widget
                                    .index].acceptBtn ?? false,
                                child: buildSizeWidth(10)),
                            Visibility(
                              visible: controller.orderItemDataList?[widget
                                  .index].cancelBtn ?? false,
                              child: Expanded(
                                child: BaseButton(
                                  borderRadius: 10,
                                  title: 'Reject',
                                  onPressed: () {
                                    controller.cancelReasonController.clear();
                                    _rejectBottomSheet(context);
                                    // controller.driverRejectOrder(controller.driverList?[widget.index].orderItemId);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    }else {
                      return const SizedBox();
                    }
                  }),
                buildSizeHeight(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rejectBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                child: AnimatedColumn(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(BaseAssets.cancelImage),
                      ),
                    ),
                    buildSizeHeight(20),
                    const Center(
                      child: BaseText(
                        value: 'Reason Of Cancel',
                        color: BaseColors.secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Center(
                      child: BaseText(
                        value:
                        'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting.',
                        color: BaseColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    buildSizeHeight(20),
                    BaseTextField(
                      controller: controller.cancelReasonController,
                      labelText: '',
                      autofocus: true,
                      hintText: 'Write Here...',
                      borderRadius: 10,
                      maxLine: 3,
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: const EdgeInsets.all(12.0),
                    ),
                    buildSizeHeight(20),
                    BaseButton(
                      borderRadius: 10,
                      title: 'Submit',
                      onPressed: () {
                        controller.driverRejectOrder(controller
                            .orderItemDataList?[widget.index].orderItemId);
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
