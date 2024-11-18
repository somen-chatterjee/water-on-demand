import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/model/user_order_history_response.dart';
import 'package:water_on_demand/ui/track_order/track_order_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_no_data.dart';

import '../../controller/user_order_history_controller.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int index;
  final OrderItemData? orderItemData;

  const OrderDetailsScreen({super.key, required this.index, required this.orderItemData});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
   UserOrderHistoryController controller = Get.isRegistered<UserOrderHistoryController>()?  Get.find<UserOrderHistoryController>():Get.put(UserOrderHistoryController()); // = Get.find<UserOrderHistoryController>();

  @override
  void initState() {

    // if (UserOrderHistoryController().initialized) {
    //   controller = Get.find();
    //   // controller.getUserOrderHistory();
    // } else {
    //   controller = Get.put(UserOrderHistoryController());
    //   // controller.getUserOrderHistory();
    // }
    // controller.getOrderDetails(
    //     widget.index, widget.orderItemData?.orderItemId);

    log("order data in details ---> ${controller.userOrderHistory?.length}");
    WidgetsBinding.instance.addPostFrameCallback((_){});
    super.initState();
  }

  /*
  * index == 0 -> Ongoing
  * index == 1 -> Cancelled
  * index == 2 -> Completed
  * */
  String showStatus({required int index}) {
    if (index == 0) {
      return 'Ongoing';
    }
    if (index == 1) {
      return 'Cancelled';
    }
    if (index == 2) {
      return 'Completed';
    }
    return 'Ongoing';
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: Stack(
          children: [
            if((widget.orderItemData?.orderedData ?? []).isNotEmpty)
              SingleChildScrollView(
                child: AnimatedColumn(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  leftPadding: 0.0,
                  rightPadding: 0.0,
                  children: [
                    buildSizeHeight(60),
                    ListView.separated(
                      itemCount: widget.orderItemData?.orderedData?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 16.0,
                        ),
                        child: Divider(
                          height: 1.0,
                          color: BaseColors.lightSky,
                        ),
                      );
                    },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if((widget.orderItemData?.orderedData ?? []).isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: cachedNetworkImage(
                                    image: widget.orderItemData?.orderedData?[index]
                                        .productData?.image ?? "",
                                    width: double.infinity,
                                    height: 230,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              buildSizeHeight(24),
                              BaseText(
                                value: widget.orderItemData?.orderedData?[index]
                                    .productData?.title ?? "",
                                color: BaseColors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                              buildSizeHeight(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const BaseText(
                                        value: 'R',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: BaseColors.secondaryColor,
                                      ),
                                      BaseText(
                                        value: widget.orderItemData?.orderedData?[index].productData?.price ?? "",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       vertical: 4.0, horizontal: 9.0),
                                  //   decoration: const BoxDecoration(
                                  //     color: BaseColors.lightGrey,
                                  //     borderRadius: BorderRadius.all(
                                  //         Radius.circular(7.0)),
                                  //   ),
                                  //   child: BaseText(
                                  //     value: widget.orderItemData?.orderStatus ?? "",
                                  //     fontSize: 13,
                                  //     fontWeight: FontWeight.w700,
                                  //     color: BaseColors.grey1,
                                  //   ),
                                  // ),
                                ],
                              ),
                              buildSizeHeight(8),
                              BaseText(
                                value: 'Units : ${widget.orderItemData?.orderedData?[index].unit ?? ""} | ${widget.orderItemData?.orderedData?[index].productData
                                    ?.quantity ?? ""}L',
                                fontSize: 14,
                                color: BaseColors.grey,
                              ),
                              buildSizeHeight(12),
                              HtmlWidget(
                                widget.orderItemData?.orderedData?[index]
                                    .productData?.description ?? "",
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: BaseColors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    //driver details info
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 16.0,
                      ),
                      child: Divider(
                        height: 1.0,
                        color: BaseColors.lightSky,
                      ),
                    ),
                    if(widget.orderItemData?.driverData != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BaseText(
                              value: 'Assigned Driver Info:',
                              fontSize: 14,
                              color: BaseColors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BaseText(
                                  value: widget.orderItemData?.driverData?.fullName ?? "",
                                  color: BaseColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(BaseAssets.callIcon),
                                    buildSizeWidth(10),
                                    BaseText(
                                      value: '+ 27 ${widget.orderItemData?.driverData?.mobileNumber.toString() ?? ""}',
                                      color: BaseColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            buildSizeHeight(18),
                          ],
                        ),
                      ),
                    BaseContainer(
                      borderRadius: 0.0,
                      topPadding: 14.0,
                      bottomPadding: 14.0,
                      leftMargin: 20.0,
                      rightMargin: 20.0,
                      bottomMargin: 0.0,
                      color: BaseColors.statusContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BaseText(
                            value: 'Status:',
                            color: BaseColors.white,
                            fontSize: 16,
                          ),
                          BaseText(
                            value: widget.orderItemData?.orderStatus
                                .toString() ?? "",
                            color: BaseColors.white,
                            fontSize: 16.0,
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(30),
                    if(controller.selectedIndex != 1)
                      BaseButton(
                        leftMargin: 28.0,
                        rightMargin: 28.0,
                        borderRadius: 0.0,
                        title: 'Track Order',
                        onPressed: () {
                          Get.to(() => TrackOrderScreen(
                            orderItemId: widget.orderItemData?.orderItemId.toString() ?? "",));
                        },
                      ),
                    buildSizeHeight(29),
                    Visibility(
                      visible: widget.orderItemData?.cancelBtn ??
                          false,
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: GestureDetector(
                          onTap: () {
                            _rejectBottomSheet(context);
                          },
                          child: const BaseText(
                            value: 'Cancel Order',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                    buildSizeHeight(30),
                  ],
                ),
              )
            else
              const BaseNoData(),
            SafeArea(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SvgPicture.asset(
                    BaseAssets.backArrow,
                    width: 19,
                    height: 20,
                    // colorFilter: const ColorFilter.mode(
                      // BaseColors.primaryColor,
                      // BlendMode.srcATop,
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _rejectBottomSheet(BuildContext context) {
     showModalBottomSheet(
       backgroundColor: Colors.transparent,
       context: context,
       isDismissible: false,
       isScrollControlled: true,
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
                         controller.cancelOrderApi(
                           widget.index,
                           widget.orderItemData?.orderItemId,
                           true,
                         );
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
