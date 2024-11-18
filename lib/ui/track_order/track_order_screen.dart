import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/controller/user_order_history_controller.dart';
import 'package:water_on_demand/ui/track_order/components/order_status.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import 'controller/track_order_controller.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderItemId;

  const TrackOrderScreen({super.key, required this.orderItemId});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  TrackOrderController trackOrderCtrl = Get.put(TrackOrderController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    trackOrderCtrl.trackOrder(orderId: widget.orderItemId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              if((trackOrderCtrl.orderData.value?.orderStatus ?? 0) < 4){
              trackOrderCtrl.trackOrder(orderId: widget.orderItemId);
              Get.find<UserOrderHistoryController>().getOrderDetails(null, widget.orderItemId);
              Get.find<UserOrderHistoryController>().getUserOrderHistory();
              }
              _refreshController.refreshCompleted();
            },
            child: SingleChildScrollView(
              child: AnimatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizeHeight(26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BaseText(
                        value: 'Track Order',
                        color: BaseColors.secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          BaseAssets.cancelImage,
                          width: 19,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(46),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: BaseColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 5)
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            buildSizeHeight(5),
                            const Icon(
                              Icons.circle,
                              size: 10,
                              color: BaseColors.grey,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                10,
                                    (index) =>
                                    Container(
                                      width: 3,
                                      height: 3,
                                      margin: const EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index % 2 == 0
                                            ? Colors.grey
                                            : Colors.transparent,
                                      ),
                                    ),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: BaseColors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        buildSizeWidth(10),
                        Obx(() {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseText(
                                  value: 'From',
                                  color: BaseColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                BaseText(
                                  value: trackOrderCtrl.addressData.value
                                      ?.fromAddress ?? "",
                                  color: BaseColors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                const Divider(
                                  color: BaseColors.radioContainerColor,
                                  thickness: 0.8,
                                ),
                                const BaseText(
                                  value: 'To',
                                  color: BaseColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                BaseText(
                                  value: trackOrderCtrl.addressData.value
                                      ?.toAddress ?? "",
                                  color: BaseColors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      decoration: const BoxDecoration(
                        color: BaseColors.statusColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BaseText(
                            value: 'Estimated Time Of Delivery',
                            color: BaseColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          BaseText(
                            value: trackOrderCtrl.orderData.value
                                ?.estDeliveryTime ?? "",
                            color: BaseColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    );
                  }),
                  buildSizeHeight(50),
                  Obx(() {
                    return OrderStatus(
                      statusIndex: trackOrderCtrl.orderData.value?.orderStatus ??
                          0,);
                  }),
                  buildSizeHeight(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
