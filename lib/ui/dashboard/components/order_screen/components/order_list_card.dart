import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/model/user_order_history_response.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../controller/user_order_history_controller.dart';

class OrderListCard extends StatefulWidget {
  final int index;
  final OrderItemData? orderedItemData;

  const OrderListCard({super.key, required this.index, this.orderedItemData});

  @override
  State<OrderListCard> createState() => _OrderListCardState();
}

class _OrderListCardState extends State<OrderListCard> {
  UserOrderHistoryController controller =Get.find<UserOrderHistoryController>() ;

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
    return GestureDetector(
      onTap: () {
        controller.getOrderDetails(widget.index, widget.orderedItemData?.orderItemId??"");
        // Get.to(() => const OrderDetailsScreen());
      },
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 19.0,
            horizontal: 20.0,
          ),
          margin: const EdgeInsets.only(bottom: 20.0),
          decoration: const BoxDecoration(color: BaseColors.white, boxShadow: [
            BoxShadow(
              color: BaseColors.lightGrey,
              blurRadius: 6.0,
              spreadRadius: 3.0,
              offset: Offset(0, 6),
            )
          ],),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if((widget.orderedItemData?.orderedData ?? []).isNotEmpty)
              cachedNetworkImage(
                image:  widget.orderedItemData?.orderedData?[0].productData?.image ??"",
                width: 92,
                height: 92,
                fit: BoxFit.fill,
              ),
              buildSizeWidth(12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     BaseText(
                      value: "#${widget.orderedItemData?.orderId ?? ""}",
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    if((widget.orderedItemData?.orderedData ?? []).isNotEmpty)
                     BaseText(
                      value: widget.orderedItemData?.orderedData?[0].productData?.title ??"",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(5.0),
                        const BaseText(
                          value: 'R',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: BaseColors.secondaryColor,
                        ),
                        // if((widget.orderedItemData?.orderedData ?? []).isNotEmpty)
                         BaseText(
                          value: widget.orderedItemData?.totalAmount ?? "",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    if((widget.orderedItemData?.orderedData ?? []).isNotEmpty)
                     BaseText(
                      value: 'Units: ${widget.orderedItemData?.orderedData?[0].unit ??""} | ${widget.orderedItemData?.orderedData?[0].productData?.quantity ??""}L',
                      fontSize: 14,
                      color: BaseColors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              buildSizeWidth(12.0),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    decoration: const BoxDecoration(
                      color: BaseColors.lightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    child:  BaseText(
                      value: widget.orderedItemData?.orderStatus ?? "",
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: BaseColors.grey1,
                    ),
                  ),
                  Visibility(
                    visible: widget.orderedItemData?.cancelBtn,
                    child:  BaseButton(
                      btnHeight: 36,
                      btnWidth: 67,
                      title: 'Cancel',
                      btnColor: BaseColors.secondaryColor,
                      btnTextColor: BaseColors.white,
                      borderRadius: 0.0,
                      onPressed: () {
                        _rejectBottomSheet(context);
                      },
                    ),
                  )
                ],
              )
            ],
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
                        controller.cancelOrderApi(widget.index, widget.orderedItemData?.orderItemId,false);
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
