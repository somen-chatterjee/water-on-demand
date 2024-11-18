import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/driver_screen/complete_details_screen/components/complete_details_screen_loading.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/model/driver_job_response.dart';
import 'package:water_on_demand/ui/driver_screen/complete_details_screen/components/paymentdetail_screen.dart';
import 'package:water_on_demand/utils/base_no_data.dart';

import '../../../utils/base_assets.dart';
import '../../../utils/base_colors.dart';
import '../../../utils/base_functions.dart';
import '../../base_components/animated_column.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import 'controller/payment_details_controller.dart';

class CompleteDetailScreen extends StatefulWidget {
  final OrderItemData? orderItemData;

  const CompleteDetailScreen({
    super.key,
    required this.orderItemData,
  });

  @override
  State<CompleteDetailScreen> createState() => _CompleteDetailScreenState();
}

class _CompleteDetailScreenState extends State<CompleteDetailScreen> {
  PaymentDetailsController paymentDetailsCtrl =
  Get.put(PaymentDetailsController());

  @override
  void initState() {
    paymentDetailsCtrl.paymentDetailsApi(widget.orderItemData?.orderItemId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(() {
              if(paymentDetailsCtrl.isPaymentDetailsLoading.value){
                return const CompleteDetailScreenLoading();
              }
              if(paymentDetailsCtrl.paymentDataDetails == null){
                return const BaseNoData();
              }
              return AnimatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizeHeight(20),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        BaseAssets.backArrow,
                        width: 19,
                        height: 20,
                      ),
                  ),
                  buildSizeHeight(20),
                  BaseText(
                    value:
                    "#${widget.orderItemData?.orderData?.orderId.toString() ??
                        ""}",
                    color: BaseColors.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(10),
                  if((widget.orderItemData?.orderedData ?? []).isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (widget.orderItemData?.orderedData ?? [])
                          .length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseText(
                              value: "${index + 1}. ",
                              color: BaseColors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText(
                                  value: widget.orderItemData
                                      ?.orderedData?[index]
                                      .productData?.title ??
                                      "",
                                  color: BaseColors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                                buildSizeHeight(12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const BaseText(
                                      value: 'R',
                                      color: BaseColors.secondaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    BaseText(
                                      value: widget.orderItemData
                                          ?.orderedData?[index]
                                          .productData?.price ??
                                          "",
                                      color: BaseColors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    // buildSizeWidth(5),
                                    // Row(
                                    //   children: [
                                    //     const Icon(
                                    //       Icons.star,
                                    //       color: CupertinoColors.systemYellow,
                                    //       size: 20,
                                    //     ),
                                    //     buildSizeWidth(5),
                                    //     const BaseText(
                                    //       value: '4.5',
                                    //       color: BaseColors.black,
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w500,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                BaseText(
                                  value:
                                  'Units : ${widget.orderItemData
                                      ?.orderedData?[index].unit ??
                                      ""} | ${widget.orderItemData
                                      ?.orderedData?[index].productData
                                      ?.quantity ?? ""}L | ${widget
                                      .orderItemData?.orderData?.distance ??
                                      ""}',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: BaseColors.grey1,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                            // horizontal: 10.0,
                            vertical: 16.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: BaseColors.lightSky,
                          ),
                        );
                      },
                    ),
                  buildSizeHeight(10),
                  const Divider(
                    color: BaseColors.radioContainerColor,
                    thickness: 1.0,
                  ),
                  const BaseText(
                    value: 'User Info',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: BaseColors.grey1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        value:
                        widget.orderItemData?.orderData?.userData?.fullName ??
                            "",
                        color: BaseColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(BaseAssets.callIcon),
                          buildSizeWidth(10),
                          BaseText(
                            value:
                            '+ 27 ${widget.orderItemData?.orderData?.userData
                                ?.mobileNumber ?? ""}',
                            color: BaseColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildSizeHeight(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: BaseColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(
                          7.0)),
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
                        Expanded(
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                value: widget.orderItemData?.orderData
                                    ?.fromAddress?.adminAddress ??
                                    "",
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                value:
                                '${widget.orderItemData?.orderData?.orderAddress
                                    ?.houseNumber ?? ""} , ${widget
                                    .orderItemData?.orderData?.orderAddress
                                    ?.addressId ?? ""}, ${widget.orderItemData
                                    ?.orderData?.orderAddress?.address ?? ""}',
                                color: BaseColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: const BoxDecoration(
                      color: BaseColors.statusColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: 'Status:',
                          color: BaseColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        BaseText(
                          value: widget.orderItemData!.orderStatus.toString(),
                          color: BaseColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  BaseButton(
                    borderRadius: 10,
                    title: 'Payment Detail',
                    onPressed: () {
                      Get.to(const PaymentDetails());
                    },
                  ),
                  buildSizeHeight(20),
                  Center(
                    child: BaseText(
                      value: 'Download Invoice',
                      color: BaseColors.secondaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      onTap: () {
                        paymentDetailsCtrl.launchLink(
                            paymentDetailsCtrl.invoiceUrl?.value ?? "");
                      },
                    ),
                  ),
                  buildSizeHeight(20),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
