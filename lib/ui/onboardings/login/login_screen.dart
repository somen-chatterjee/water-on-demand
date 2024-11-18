import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:water_on_demand/common_controller/common_controller.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/onboardings/check_user/check_user_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

import '../../base_components/base_button.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  final bool isDriver;

  const LoginScreen({super.key, required this.isDriver});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  CommonController commonController = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKeyLogin,
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
                    value: 'Welcome Back!',
                    color: BaseColors.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(19),
                  const BaseText(
                    value:
                        'Please enter your mobile number to\nlogin your account.',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  buildSizeHeight(36),
                  const BaseText(
                    value: 'Mobile Number',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  BaseTextField(
                    controller: controller.numberController,
                    labelText: '',
                    hintText: 'Enter Mobile Number',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    textInputType: TextInputType.number,
                    textInputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    borderRadius: 10.0,
                    contentPadding: const EdgeInsets.all(12.0),
                    validator: (val) {
                      if (val == null) return "Empty!!";

                      if (controller.numberController.text.isEmpty) {
                        return "Please Enter Your Phone Number";
                      }
                      if (controller.numberController.value.text.trim().length <
                          10) {
                        return "Please Enter A Valid Number";
                      }
                      return null;
                    },
                    prefixIcon: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 108,
                            color: Colors.transparent,
                            child: CountryCodePicker(
                              enabled: false,
                              padding: const EdgeInsets.all(0),
                              flagWidth: 30,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              onChanged: (val) {
                                // controller.countryCode.value = val.code!;
                                log(val.code.toString());
                              },
                              showDropDownButton: false,
                              initialSelection: 'ZA',
                              favorite: const ['+27', 'ZA'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: true,
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 14,
                            color: BaseColors.grey,
                          ),
                          buildSizeWidth(12.0),
                        ],
                      ),
                    ),
                  ),
                  buildSizeHeight(25.5),
                  BaseButton(
                    title: 'Login',
                    onPressed: () {
                      if (controller.formKeyLogin.currentState?.validate() ??
                          false) {
                        controller.loginResponse(isDriver: widget.isDriver);
                        // Get.to(() => OtpScreen(isDriver: widget.isDriver));
                      }
                    },
                  ),
                  buildSizeHeight(22.0),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.back();
                      Get.to(() => const CheckUserScreen(isLogin: false));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don’t Have An Account? ',
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationColor: BaseColors.grey,
                                color: BaseColors.grey,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign UP',
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationColor: BaseColors.secondaryColor,
                                color: BaseColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildSizeHeight(272),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          commonController.facebookLogin().then((value) async{
                            var fcmToken =
                                await BaseStorage.read(StorageKeys.fcmToken) ??
                                "";
                            log("message $value");
                            if (value != null) {
                              var socialId = value['id'];
                              var email = value['email'];
                              var name = value['name'];

                              Map<String, String> data = {
                                "role_id": widget.isDriver
                                    ? CheckRoleId().driver.toString()
                                    : CheckRoleId().customer.toString(),
                                "full_name": name ?? "",
                                "email_address": email ?? "",
                                "mobile_number": "",
                                "social_id": socialId ?? "",
                                "login_type": "203", // 203 => facebook
                                "country_code": "+27",
                                "device_token": fcmToken,
                              };

                              await commonController.socialLogin(
                                isDriver: widget.isDriver,
                                data: data,
                              );
                            }
                          });
                        },
                        child: SvgPicture.asset(
                          BaseAssets.facebookIcon,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      buildSizeWidth(25),
                      GestureDetector(
                        onTap: () {
                          commonController
                              .signInWithGoogle(context: context)
                              .then((User? user) async {
                            var fcmToken =
                                await BaseStorage.read(StorageKeys.fcmToken) ??
                                    "";

                            if (user != null) {
                              Map<String, String> data = {
                                "role_id": widget.isDriver
                                    ? CheckRoleId().driver.toString()
                                    : CheckRoleId().customer.toString(),
                                "full_name": user.displayName ?? "",
                                "email_address": user.email ?? "",
                                "mobile_number": user.phoneNumber ?? "",
                                "social_id": user.uid,
                                "login_type": "202", // 202 => google
                                "country_code": "+27",
                                "device_token": fcmToken,
                              };
                              await commonController.socialLogin(
                                isDriver: widget.isDriver,
                                data: data,
                              );
                            }
                          });
                        },
                        child: SvgPicture.asset(
                          BaseAssets.googleIcon,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      if (Platform.isIOS) buildSizeWidth(25),
                      if (Platform.isIOS)
                        GestureDetector(
                          onTap: () async {
                            try {
                              final apple =
                                  await SignInWithApple.getAppleIDCredential(
                                      scopes: [
                                    AppleIDAuthorizationScopes.email,
                                    AppleIDAuthorizationScopes.fullName
                                  ]);
                              var fcmToken = await BaseStorage.read(
                                      StorageKeys.fcmToken) ??
                                  "";
                              if (apple.userIdentifier != null) {
                                // print(apple);
                                // print(apple.userIdentifier);
                                // print(apple.givenName);
                                // print(apple.familyName);

                                Map<String, String> data = {
                                  "role_id": widget.isDriver
                                      ? CheckRoleId().driver.toString()
                                      : CheckRoleId().customer.toString(),
                                  "full_name": apple.givenName ?? "",
                                  "email_address": apple.email ?? "",
                                  "mobile_number": "",
                                  "social_id": apple.userIdentifier ?? "",
                                  "login_type": "204", // 204 => apple
                                  "country_code": "+27",
                                  "device_token": fcmToken,
                                };

                                await commonController.socialLogin(
                                  isDriver: widget.isDriver,
                                  data: data,
                                );
                              }
                            } catch (e) {
                              log("error apple sign in -> $e");
                            }
                          },
                          child: SvgPicture.asset(
                            BaseAssets.appleIcon,
                            width: 50,
                            height: 50,
                          ),
                        ),
                    ],
                  ),
                  buildSizeHeight(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
