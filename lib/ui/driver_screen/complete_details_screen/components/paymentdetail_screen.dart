import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/utils/base_assets.dart';

import '../../../../utils/base_colors.dart';
import '../../../../utils/base_functions.dart';
import '../../../base_components/animated_column.dart';
import '../../../base_components/base_button.dart';
import '../../../base_components/base_scaffold_background.dart';
import '../../../base_components/base_text.dart';
import '../controller/payment_details_controller.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  PaymentDetailsController paymentDetailsCtrl = Get.find<PaymentDetailsController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
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
                    )),
                buildSizeHeight(20),
                const BaseText(
                  value: 'Payment Detail',
                  color: BaseColors.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      value: 'Sub Total',
                      color: BaseColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'R',
                          color: BaseColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                         BaseText(
                          value: paymentDetailsCtrl.paymentDataDetails?.value.subTotalAmt.toString()??"",
                          color: BaseColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        buildSizeHeight(20),
                      ],
                    ),
                  ],
                ),
                buildSizeHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      value: 'Admin fee',
                      color: BaseColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'R',
                          color: BaseColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                         BaseText(
                          value: paymentDetailsCtrl.paymentDataDetails?.value.adminFee.toString()??"",
                          color: BaseColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        buildSizeHeight(20),
                      ],
                    ),
                  ],
                ),
                buildSizeHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      value: 'Floor Charge',
                      color: BaseColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'R',
                          color: BaseColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                         BaseText(
                          value: paymentDetailsCtrl.paymentDataDetails?.value.floorCharge.toString()??"",
                          color: BaseColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        buildSizeHeight(20),
                      ],
                    ),
                  ],
                ),
                buildSizeHeight(20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      value: 'Delivery Fee',
                      color: BaseColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'R',
                          color: BaseColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        BaseText(
                          value: paymentDetailsCtrl.paymentDataDetails?.value.deliveryFee.toString()??"",
                          color: BaseColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                buildSizeHeight(20),
                const Divider(
                  color: BaseColors.radioContainerColor,
                  thickness: 0.8,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      value: 'Total Payment',
                      color: BaseColors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'R',
                          color: BaseColors.secondaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                        BaseText(
                          value: paymentDetailsCtrl.paymentDataDetails?.value.grandTotalAmt.toString()??"",
                          color: BaseColors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                buildSizeHeight(30),
                BaseButton(
                  borderRadius: 10,
                  title: 'Download Invoice',
                  onPressed: () {
                    paymentDetailsCtrl.launchLink(paymentDetailsCtrl.invoiceUrl?.value ?? "");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
