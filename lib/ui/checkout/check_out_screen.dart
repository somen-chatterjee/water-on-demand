import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/checkout/components/order_for_future.dart';
import 'package:water_on_demand/ui/checkout/controller/checkout_controller.dart';
import 'package:water_on_demand/ui/checkout/model/check_out_data_model.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../utils/custum_radiobutton.dart';

class CheckOutScreen extends StatefulWidget {
  final int purchaseType;
  const CheckOutScreen({super.key, required this.purchaseType});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CheckOutController checkOutCtrl = Get.put(CheckOutController());
  DashboardController dashboardCtrl = Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkOutCtrl.getCheckoutData(purchaseType: widget.purchaseType);
      checkOutCtrl.calculateTotalPrice();
      checkOutCtrl.checkFloor();
      // checkOutCtrl.isFloorCharge.value = int.parse(
      //     dashboardCtrl.profileData?.addressData?.floorNumber.toString() ??
      //         "0") > 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
              leftPadding: 0.0,
              rightPadding: 0.0,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: 'Checkout',
                          color: BaseColors.secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            BaseAssets.backArrow,
                            width: 19,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    buildSizeHeight(26),
                    // address section
                    GetBuilder<DashboardController>(builder: (dController) {
                      if (dashboardCtrl.profileData?.addressData != null) {
                        var addressData = dashboardCtrl.profileData
                            ?.addressData;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const BaseText(
                                  value: 'Delivery Address',
                                  color: BaseColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                InkWell(
                                  onTap: () {
                                    dashboardCtrl.getUserAddressList(
                                        context: context);
                                  },
                                  child: const BaseText(
                                    value: 'Change',
                                    color: BaseColors.grey,
                                    underline: true,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            buildSizeHeight(14),
                            BaseText(
                              value: checkAddressType(
                                  type: dashboardCtrl.profileData?.addressData
                                      ?.addressType.toString() ?? ""),
                              color: BaseColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            buildSizeHeight(8),
                            BaseText(
                              value: "${addressData?.houseNumber.toString() ??
                                  ""}, ${addressData?.buildingName
                                  .toString()}, ${addressData?.address
                                  .toString()}",
                              color: BaseColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                    buildSizeHeight(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Select Date & Time',
                          color: BaseColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(15),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  selectIndex(501);
                                },
                                child: BaseContainer(
                                  bottomMargin: 0.0,
                                  borderRadius: 0.0,
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
                                    color: checkOutCtrl.orderFor.value == 501
                                        ? BaseColors.secondaryColor
                                        : BaseColors.lightSky,
                                    width: 1.0,
                                  ),
                                  child: Center(
                                    child: BaseText(
                                      textAlign: TextAlign.center,
                                      value: 'Order Now',
                                      color: checkOutCtrl.orderFor.value ==
                                          501
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
                                  selectIndex(502);
                                },
                                child: BaseContainer(
                                  bottomMargin: 0.0,
                                  borderRadius: 0.0,
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
                                    color: checkOutCtrl.orderFor.value == 502
                                        ? BaseColors.secondaryColor
                                        : BaseColors.lightSky,
                                    width: 1.0,
                                  ),
                                  child: Center(
                                    child: BaseText(
                                      textAlign: TextAlign.center,
                                      value: 'Order for Future',
                                      color: checkOutCtrl.orderFor.value ==
                                          502
                                          ? BaseColors.secondaryColor
                                          : BaseColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    buildSizeHeight(25),
                    ValueListenableBuilder(
                        valueListenable: checkOutCtrl.deliveryTypeValue,
                        builder: (context, nValue, _) {
                          return Row(
                            children: [
                              CustomRadio(
                                value: 511,
                                groupValue: nValue,
                                onChanged: (value) {
                                  checkOutCtrl.deliveryTypeValue.value = value;
                                  checkOutCtrl.calculateTotalPrice();
                                },
                              ),
                              buildSizeWidth(10),
                              const BaseText(
                                  textAlign: TextAlign.center,
                                  value: 'Collect',
                                  color: BaseColors.grey),
                              buildSizeWidth(35),
                              CustomRadio(
                                value: 512,
                                groupValue: nValue,
                                onChanged: (value) {
                                  checkOutCtrl.deliveryTypeValue.value = value;
                                  checkOutCtrl.checkFloor();
                                  checkOutCtrl.calculateTotalPrice();
                                },
                              ),
                              buildSizeWidth(10),
                              const BaseText(
                                  textAlign: TextAlign.center,
                                  value: 'Delivery',
                                  color: BaseColors.grey),
                            ],
                          );
                        }
                    ),
                    Obx(() {
                      return Visibility(
                        visible: checkOutCtrl.orderFor.value == 501,
                        child: Column(
                          children: [
                            buildSizeHeight(18),
                            BaseContainer(
                              leftPadding: 12,
                              rightPadding: 12,
                              topPadding: 15,
                              bottomPadding: 15,
                              bottomMargin: 0.0,
                              color: BaseColors.secondaryColor.withOpacity(0.2),
                              borderRadius: 0.0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(BaseAssets.warning),
                                  buildSizeWidth(12),
                                  ValueListenableBuilder(
                                      valueListenable: checkOutCtrl
                                          .deliveryTypeValue,
                                      builder: (context, nValue, _) {
                                        return Obx(() =>
                                            Visibility(
                                              visible: checkOutCtrl.settingData
                                                  .value.deliveryText != null ||
                                                  checkOutCtrl.settingData.value
                                                      .collectText != null,
                                              child: Flexible(
                                                child: BaseText(
                                                  value: checkOutCtrl
                                                      .deliveryTypeValue
                                                      .value ==
                                                      511
                                                      ? checkOutCtrl.settingData
                                                      .value.collectText ?? ""
                                                      : checkOutCtrl.settingData
                                                      .value.deliveryText ?? "",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ));
                                        // if (checkOutCtrl.settingData?.value !=
                                        //     null) {
                                        //   return Flexible(
                                        //     child: BaseText(
                                        //       value: _selectedValue.value == 1
                                        //           ? checkOutCtrl.settingData?.value!.collectText ?? ""
                                        //           : checkOutCtrl.settingData?.value!.deliveryText ?? "",
                                        //       fontWeight: FontWeight.w600,
                                        //       fontSize: 12,
                                        //     ),
                                        //   );
                                        // } else {
                                        //   return const Flexible(
                                        //     child: BaseText(
                                        //       value: "",
                                        //       fontWeight: FontWeight.w600,
                                        //       fontSize: 12,
                                        //     ),
                                        //   );
                                        // }
                                      }
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    // order for future
                    Obx(() {
                      return Visibility(
                        visible: checkOutCtrl.orderFor.value == 502,
                        child: Column(
                          children: [
                            buildSizeHeight(25),
                            const OrderForFuture(),
                          ],
                        ),
                      );
                    }),
                    buildSizeHeight(23),
                  ],
                ),
                Obx(() {
                  if (checkOutCtrl.paymentCardData != null &&
                      checkOutCtrl.paymentCardData!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 1.0,
                          color: BaseColors.grey2,
                        ),
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 24.0),
                          child: BaseText(
                            value: 'Payment',
                            color: BaseColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CarouselSlider.builder(
                          itemCount: checkOutCtrl.paymentCardData!.length,
                          options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.75,
                            aspectRatio: 2.2,
                            initialPage: 2,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return card(paymentCardData: checkOutCtrl
                                .paymentCardData![itemIndex]);
                          },
                        ),
                        buildSizeHeight(23),
                      ],
                    );
                  } else {
                    return const BaseContainer(
                      bottomMargin: 19,
                      leftMargin: 19,
                      rightMargin: 19,
                      // topMargin: 19,
                      borderRadius: 13.0,
                      height: 120,
                      color: BaseColors.secondaryColor,
                      child: Center(
                        child: BaseText(
                          value: "Cards not available",
                          fontWeight: FontWeight.w600,
                          color: BaseColors.white,
                        ),
                      ),
                    );
                  }
                }),
                const Divider(
                  thickness: 1.0,
                  color: BaseColors.grey2,
                ),

                ///charges
                ValueListenableBuilder(
                    valueListenable: checkOutCtrl.deliveryTypeValue,
                    builder: (context, value, _) {
                      return Obx(() {
                        return Visibility(
                          visible: checkOutCtrl.amountData != null,
                          child: AnimatedColumn(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const BaseText(
                                    value: 'Sub Total',
                                    color: BaseColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      buildSizeHeight(5.0),
                                      const BaseText(
                                        value: 'R',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: BaseColors.secondaryColor,
                                      ),
                                      BaseText(
                                        value: checkOutCtrl.amountData!.value
                                            .subTotalAmt ?? "",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              buildSizeHeight(18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const BaseText(
                                    value: 'Admin Fee',
                                    color: BaseColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      buildSizeHeight(5.0),
                                      const BaseText(
                                        value: 'R',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: BaseColors.secondaryColor,
                                      ),
                                      BaseText(
                                        value: checkOutCtrl.amountData!.value
                                            .adminFee ?? "",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // floor charge
                              // if(checkOutCtrl.deliveryTypeValue.value == 512 &&
                              //     checkOutCtrl.isFloorCharge.value)
                              Obx(() {
                                return Visibility(
                                  visible: checkOutCtrl.deliveryTypeValue
                                      .value == 512 &&
                                      checkOutCtrl.isFloorCharge.value,
                                  child: Column(
                                    children: [
                                      buildSizeHeight(18),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const BaseText(
                                            value: 'Floor Charge',
                                            color: BaseColors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              buildSizeHeight(5.0),
                                              const BaseText(
                                                value: 'R',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: BaseColors
                                                    .secondaryColor,
                                              ),
                                              BaseText(
                                                value: checkOutCtrl.settingData
                                                    .value.floorCharge
                                                    .toString(),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              // delivery charge
                              Visibility(
                                visible: value == 512,
                                child: Column(
                                  children: [
                                    buildSizeHeight(18),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        const BaseText(
                                          value: 'Delivery Charge',
                                          color: BaseColors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            buildSizeHeight(5.0),
                                            const BaseText(
                                              value: 'R',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: BaseColors.secondaryColor,
                                            ),
                                            BaseText(
                                              value: checkOutCtrl.amountData!
                                                  .value.deliveryFee ?? "",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    }
                ),
                buildSizeHeight(43),

                /// total charges
                BaseContainer(
                  leftMargin: 12.0,
                  rightMargin: 12.0,
                  bottomMargin: 10.0,
                  topMargin: 0.0,
                  leftPadding: 20.0,
                  rightPadding: 20.0,
                  boxShadow: const BoxShadow(
                    color: BaseColors.lightSky,
                    blurRadius: 50,
                    spreadRadius: 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Total Price',
                            fontSize: 14,
                          ),
                          Obx(() {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSizeHeight(5.0),
                                const BaseText(
                                  value: 'R',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: BaseColors.secondaryColor,
                                ),
                                BaseText(
                                  value: checkOutCtrl.totalAmount.toString(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                      BaseButton(
                        btnWidth: 150,
                        btnHeight: 47,
                        title: 'Place Order',
                        borderEnable: true,
                        borderColor: BaseColors.primaryColor,
                        btnTextColor: BaseColors.primaryColor,
                        borderRadius: 30.0,
                        onPressed: () {
                          if (checkOutCtrl.startEndDateFormKey.currentState
                              ?.validate() ?? false) {
                            if (checkOutCtrl.dayType.value == 522 &&
                                checkOutCtrl.selectedWeek.isEmpty) {
                              showSnackBar(
                                  subtitle: "Please select the days for the order");
                              return;
                            } else if (checkOutCtrl.dayType.value == 523 &&
                                checkOutCtrl.checkMonthSelected()) {
                              showSnackBar(
                                  subtitle: "Please select the date of the month for the order");
                              return;
                            } else
                            if (checkOutCtrl.selectedTime.value.isEmpty) {
                              showSnackBar(
                                  subtitle: "Please select the time for the order");
                              return;
                            } else {
                              log("onPressed in");
                              // checkOutCtrl.placeOrder(widget.purchaseType);
                              showConfirmDialog(context);
                            }
                          }

                          if (checkOutCtrl.orderFor.value == 501) {
                            log("onPressed out");
                            // checkOutCtrl.placeOrder(widget.purchaseType);
                            showConfirmDialog(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
                buildSizeHeight(23),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> showConfirmDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              // height: 400,
              width: double.maxFinite,
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: BaseColors.lightSky,
                    blurRadius: 2.0,
                    spreadRadius: 0.01,
                  ),
                ],
              ),
              child: AnimatedColumn(
                leftPadding: 0,
                rightPadding: 0,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSizeHeight(10),
                  const BaseText(
                    value: "Order Confirmation",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: BaseColors.primaryColor,
                  ),
                  buildSizeHeight(10),
                  BaseText(
                    value: checkOutCtrl.deliveryTypeValue.value == 511 ? "Are you sure you want to collect?" : "Are you sure you want to place the order?",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  buildSizeHeight(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: BaseButton(
                            borderRadius: 10,
                            borderEnable: true,
                            btnColor: BaseColors.white,
                            title: 'No',
                            borderColor: BaseColors.primaryColor,
                            btnTextColor: BaseColors.primaryColor,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        buildSizeWidth(10),
                        Expanded(
                          child: BaseButton(
                            borderRadius: 10,
                            title: 'Yes',
                            onPressed: () {
                              checkOutCtrl.placeOrder(widget.purchaseType);
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                ],
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  Widget card({required PaymentCardData paymentCardData}) {
    return BaseContainer(
      bottomMargin: 0.0,
      leftPadding: 19,
      rightPadding: 19,
      topPadding: 15,
      bottomPadding: 12,
      borderRadius: 13.0,
      color: BaseColors.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BaseText(
            value: paymentCardData.cardType ?? "",
            fontWeight: FontWeight.w700,
            color: BaseColors.white,
          ),
          buildSizeHeight(18),
          Row(
            children: [
              Row(
                children: List.generate(4, (index) {
                  return Container(
                    width: 9,
                    height: 9,
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      color: BaseColors.white.withOpacity(0.58),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              buildSizeWidth(10),
              Row(
                children: List.generate(4, (index) {
                  return Container(
                    width: 9,
                    height: 9,
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      color: BaseColors.white.withOpacity(0.58),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              buildSizeWidth(10),
              Row(
                children: List.generate(4, (index) {
                  return Container(
                    width: 9,
                    height: 9,
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      color: BaseColors.white.withOpacity(0.58),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              buildSizeWidth(10),
              BaseText(
                value: (paymentCardData.cardNumber ?? "  ")
                    .split(" ")
                    .last,
                color: BaseColors.white,
              ),
            ],
          ),
          buildSizeHeight(13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                value: 'Card Holder',
                color: BaseColors.white.withOpacity(0.58),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              BaseText(
                value: 'Expires',
                color: BaseColors.white.withOpacity(0.58),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                value: paymentCardData.cardHolderName ?? "",
                color: BaseColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              BaseText(
                value: paymentCardData.expires ?? "",
                color: BaseColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void selectIndex(int index) {
    if (index != checkOutCtrl.orderFor.value) {
      setState(() {
        checkOutCtrl.orderFor.value = index;
        checkOutCtrl.dayType.value = 521;
        checkOutCtrl.clearData();
      });
    }
  }

}
