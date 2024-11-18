import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:water_on_demand/common_controller/common_controller.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/onboardings/add_address/add_address_screen.dart';
import 'package:water_on_demand/ui/onboardings/check_user/check_user_screen.dart';
import 'package:water_on_demand/ui/onboardings/create_account/controller/create_account_controller.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

class CreateAccount extends StatefulWidget {
  final bool isDriver;

  const CreateAccount({super.key, required this.isDriver});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  CreateAccountController controller = Get.put(CreateAccountController());
  CommonController commonController = Get.put(CommonController());
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKeyCreateAccount,
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
                  buildSizeHeight(24),
                  const BaseText(
                    value: 'Create Your Account',
                    color: BaseColors.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(13),
                  const BaseText(
                    value:
                        'Please fill in your details to create\nyour account',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  buildSizeHeight(26),
                  //Full Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Full Name',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      buildSizeHeight(6.5),
                      BaseTextField(
                        controller: controller.nameController,
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: '',
                        hintText: 'Enter Name',
                        hintTextColor: BaseColors.grey,
                        borderColor: BaseColors.lightSky,
                        contentPadding: const EdgeInsets.all(12.0),
                        validator: (val) {
                          if (controller.nameController.value.text
                              .trim()
                              .isEmpty) {
                            return "Please Enter Name";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  buildSizeHeight(18),
                  //Email ID
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Email ID',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      buildSizeHeight(6.5),
                      BaseTextField(
                        labelText: '',
                        controller: controller.emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Email ID',
                        hintTextColor: BaseColors.grey,
                        borderColor: BaseColors.lightSky,
                        contentPadding: const EdgeInsets.all(12.0),
                        validator: (val) {
                          if (controller.emailController.value.text
                              .trim()
                              .isEmpty) {
                            return "Please Enter Email";
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val!)) {
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  buildSizeHeight(18),
                  //mobile number
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Mobile Number',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      buildSizeHeight(6.5),
                      BaseTextField(
                        labelText: '',
                        controller: controller.numberController,
                        textInputType: TextInputType.number,
                        hintText: 'Enter Mobile Number',
                        hintTextColor: BaseColors.grey,
                        borderColor: BaseColors.lightSky,
                        validator: (val) {
                          if (val == null) return "Empty!!";
                          if (controller.numberController.value.text
                              .trim()
                              .isEmpty) {
                            return "Please Enter Your Phone Number";
                          }
                          if (controller.numberController.value.text
                                  .trim()
                                  .length <
                              10) {
                            return "Please Enter Valid Phone Number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.all(12.0),
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
                    ],
                  ),
                  //Delivery Address
                  Visibility(
                    visible: !widget.isDriver,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(18),
                        const BaseText(
                          value: 'Delivery Address',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        BaseTextField(
                          labelText: '',
                          controller: controller.addressController,
                          hintText: 'Enter Address',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.lightSky,
                          readOnly: true,
                          contentPadding: const EdgeInsets.all(12.0),
                          validator: (val) {
                            if (controller.addressController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Address";
                            }
                            return null;
                          },
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: BaseButton(
                              btnWidth: 56,
                              fontSize: 14,
                              borderRadius: 0.0,
                              btnColor: BaseColors.secondaryColor,
                              title: 'ADD',
                              onPressed: () {
                                Get.to(() => AddAddressScreen(
                                      isDriver: widget.isDriver,
                                      isProfile: false,
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.isDriver,
                    child: Column(
                      children: [
                        buildSizeHeight(15),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                side:
                                    WidgetStateBorderSide.resolveWith((states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return const BorderSide(
                                        color: BaseColors.black);
                                  } else {
                                    return const BorderSide(
                                        color: BaseColors.lightSky);
                                  }
                                }),
                                activeColor: BaseColors.lightSky,
                                checkColor: BaseColors.lightSky,
                                focusColor: BaseColors.lightSky,
                                fillColor: const WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                isError: true,
                                tristate: true,
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = !rememberMe;
                                  });
                                },
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'I Accept ',
                                    style: TextStyle(
                                      color: BaseColors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms & Conditions?',
                                    style: const TextStyle(
                                      color: BaseColors.secondaryColor,
                                      fontSize: 14,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => controller.launchTAndCUrl(
                                          'https://www.waterondemand.co.za/app/terms-and-conditions'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(25),
                  BaseButton(
                    borderRadius: 0.0,
                    title: 'Create an account',
                    onPressed: () {
                      if (controller.formKeyCreateAccount.currentState
                              ?.validate() ??
                          false) {
                        if (widget.isDriver && !rememberMe) {
                          showSnackBar(
                              subtitle: "Please Accept Term & Condition");
                          return;
                        }

                        controller.createAccount(isDriver: widget.isDriver);
                      }
                    },
                  ),
                  buildSizeHeight(22),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.back();
                      Get.to(() => const CheckUserScreen(isLogin: true));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already Have An Account? ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: BaseColors.grey,
                                color: BaseColors.grey,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: BaseColors.secondaryColor,
                                color: BaseColors.secondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildSizeHeight(34),
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
                            var fcmToken = await BaseStorage.read(
                                    StorageKeys.fcmToken) ??
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
