import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/onboardings/otp/controller/login_otp_controller.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../utils/base_assets.dart';

class OtpScreen extends StatefulWidget {
  final bool isDriver;
  final String number;
  final bool isLogin;

  const OtpScreen({super.key,
    required this.isDriver,
    required this.number,
    required this.isLogin});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  LoginOtpController controller = Get.put(LoginOtpController());

  @override
  Widget build(BuildContext context) {
    double pinWidth = 70.0;
    double pinHeight = 60.0;
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(26),
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
                buildSizeHeight(48),
                const BaseText(
                  value: 'Verification Code',
                  color: BaseColors.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(19),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'We have sent the code verification \nto ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: BaseColors.black),
                      ),
                      TextSpan(
                        text: 'XX XXXX XX${widget.number.substring(widget.number
                            .length - 2)}.',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BaseColors.black),
                      ),
                    ],
                  ),
                ),
                buildSizeHeight(13),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Change Phone Number?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: BaseColors.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                buildSizeHeight(80),
                Align(
                  alignment: Alignment.center,
                  child: Pinput(
                    controller: controller.otpController,
                    focusedPinTheme: PinTheme(
                      width: pinWidth,
                      height: pinHeight,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BaseColors.lightSky1,
                        boxShadow: [
                          BoxShadow(
                            color: BaseColors.lightSky1.withOpacity(0.4),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                          )
                        ],
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: pinWidth,
                      height: pinHeight,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: BaseColors.lightSky2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: pinWidth,
                      height: pinHeight,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: BaseColors.lightSky1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onCompleted: (pin) {},
                  ),
                ),
                buildSizeHeight(48),
                Obx(() {
                  return Align(
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: controller.countdownShow.value,
                      child: SlideCountdownSeparated(
                        key: UniqueKey(),
                        duration: const Duration(seconds: 59),
                        showZeroValue: true,
                        shouldShowHours: (v) => false,
                        shouldShowDays: (v) => false,
                        suffixIcon: const Text(
                          " s",
                          style: TextStyle(
                            color: BaseColors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        style: const TextStyle(
                          color: BaseColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        onDone: () {
                          controller.countdownShow.value = false;
                        },
                      ),
                    ),
                  );
                }),
                buildSizeHeight(80),
                Obx(() {
                  return Row(
                    children: [
                      Visibility(
                        visible: !controller.countdownShow.value,
                        child: Expanded(
                          child: BaseButton(
                            title: 'Resend',
                            borderEnable: true,
                            btnColor: BaseColors.white,
                            borderColor: BaseColors.primaryColor,
                            btnTextColor: BaseColors.primaryColor,
                            onPressed: () {
                              controller.resendOtp(isNumber: widget.number);
                              // controller.callVerifyOtpApi(isDriver:widget.isDriver,isNumber: widget.number);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !controller.countdownShow.value,
                        child: buildSizeWidth(18),
                      ),
                      Expanded(
                        child: BaseButton(
                          title: 'Confirm',
                          onPressed: () {
                            if(controller.otpController.text.trim().isNotEmpty) {
                              if (widget.isLogin) {
                                controller.callVerifyOtpApi(
                                    isDriver: widget.isDriver,
                                    isNumber: widget.number);
                              } else {
                                controller.validateAccountOtpApi(
                                    isDriver: widget.isDriver,
                                    isNumber: widget.number);
                              }
                            } else {
                              showSnackBar(subtitle: "Please Enter The OTP First.");
                            }
                          },
                        ),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
