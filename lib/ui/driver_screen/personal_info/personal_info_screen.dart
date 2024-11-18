import 'dart:developer';
import 'dart:io';

import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/driver_screen/personal_info/controller/personal_info_controller.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../utils/base_assets.dart';
import '../../../utils/base_colors.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../../onboardings/add_address/add_address_screen.dart';
import '../../onboardings/create_account/controller/create_account_controller.dart';
import '../controller/completekyc_controller.dart';

class CompleteKycScreen extends StatefulWidget {
  const CompleteKycScreen({super.key});

  @override
  State<CompleteKycScreen> createState() => _CompleteKycScreenState();
}

class _CompleteKycScreenState extends State<CompleteKycScreen> {
  CompleteKycController completeKycCtrl = Get.put(CompleteKycController());
  PersonalInfoController personalInfoCtrl = Get.put(PersonalInfoController());
  CreateAccountController controller = Get.put(CreateAccountController());


  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
        child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: personalInfoCtrl.formKeyPerSonalInfo,
            child: AnimatedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(20),
                const Center(
                  child: BaseText(
                    value: 'Complete KYC',
                    color: BaseColors.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Center(
                  child: BaseText(
                    value: 'Please enter your personal details',
                    color: BaseColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                buildSizeHeight(20),
                AnotherStepper(
                  stepperList: completeKycCtrl.stepperData,
                  stepperDirection: Axis.horizontal,
                  iconWidth: 24,
                  iconHeight: 24,
                  activeBarColor: Colors.blue,
                  inActiveBarColor: Colors.blue,
                  activeIndex: 1,
                  barThickness: 4,
                  inverted: true,
                ),
                buildSizeHeight(20),
                const Center(
                  child: BaseText(
                    value: 'Personal Info',
                    color: BaseColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                buildSizeHeight(20),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                          child: personalInfoCtrl.selectedImage != null && personalInfoCtrl.selectedImage!.path.isNotEmpty
                              ? Image.file(
                                  File(personalInfoCtrl.selectedImage!.path),
                                  fit: BoxFit.cover,
                                  height: 110,
                                  width: 110,
                                )
                              : Image.asset(
                                  BaseAssets.profileImage,
                                  height: 110,
                                ),),
                      Positioned(
                        bottom: 10,
                        right: -15,
                        child: GestureDetector(
                          onTap: () {
                            showMediaPicker().then((value) {
                              if ((value?.path ?? "").isNotEmpty) {
                                personalInfoCtrl.selectedImage =
                                    value ?? File("");
                                setState(() {});
                              }
                            });
                          },
                          child: SvgPicture.asset(BaseAssets.editWithBg),
                        ),
                      )
                    ],
                  ),
                ),
                buildSizeHeight(20),
                const BaseText(
                  value: 'Full Name',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseTextField(
                  controller: personalInfoCtrl.fullNameController,
                  labelText: '',
                  hintText: 'Full Name',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.lightSky,
                  textInputType: TextInputType.name,
                  contentPadding: const EdgeInsets.all(12.0),
                  validator: (val) {
                    if (personalInfoCtrl.fullNameController.value.text
                        .trim()
                        .isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
                buildSizeHeight(20),
                const BaseText(
                  value: 'Email ID',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseTextField(
                  controller: personalInfoCtrl.emailIdController,
                  labelText: '',
                  hintText: 'Email ID',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.lightSky,
                  contentPadding: const EdgeInsets.all(12.0),
                  validator: (val) {
                    if (personalInfoCtrl.emailIdController.value.text
                        .trim()
                        .isEmpty) {
                      return "Please Enter Email";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val!)) {
                      return "Please Enter a Valid Email";
                    }
                    return null;
                  },
                ),
                buildSizeHeight(20),
                const BaseText(
                  value: 'Mobile Number',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseTextField(
                  controller: personalInfoCtrl.mobileNoController,
                  labelText: '',
                  hintText: 'Enter Mobile Number',
                  readOnly: true,
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.lightSky,
                  contentPadding: const EdgeInsets.all(12.0),
                  validator: (val) {
                    if (val == null) return "Empty!!";
                    if (personalInfoCtrl.mobileNoController.value.text
                        .trim()
                        .isEmpty) {
                      return "Please Enter Your Phone Number";
                    }
                    if (personalInfoCtrl.mobileNoController.value.text
                            .trim()
                            .length <
                        10) {
                      return "Please Enter Valid Phone Number";
                    }
                    return null;
                  },
                  prefixIcon: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 110,
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
                          width: 10,
                          color: BaseColors.grey,
                        ),
                        buildSizeWidth(12.0),
                      ],
                    ),
                  ),
                ),
                buildSizeHeight(20),
                const BaseText(
                  value: 'D.O.B.',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                BaseTextField(
                  controller: personalInfoCtrl.dobController,
                  labelText: '',
                  hintText: 'DD MM YYY',
                  readOnly: true,
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.lightSky,
                  contentPadding: const EdgeInsets.all(12.0),
                  validator: (val) {
                    if (personalInfoCtrl.dobController.value.text
                        .trim()
                        .isEmpty) {
                      return "Please Enter Your DOB";
                    }
                    if(DateTime.now().difference(changeToDateTime(dateString: personalInfoCtrl.dobController.value.text)) < const Duration(days: 6570)) {
                      return "You must be above 18 years of age";
                    }
                    return null;
                  },
                  onTap: () {
                    showBaseDatePicker(context, lastDate: DateTime.now()).then((val) {
                      if(val.isNotEmpty) {
                        personalInfoCtrl.dobController.text = val;
                      }
                    });
                  },
                ),
                buildSizeHeight(20),
                BaseTextField(
                  controller: controller.addressController,
                  labelText: '',
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
                        Get.to(() => const AddAddressScreen(
                              isDriver: true, isProfile: false,
                            ));
                      },
                    ),
                  ),
                ),
                buildSizeHeight(20),
                BaseButton(
                  borderRadius: double.nan,
                  title: 'Continue',
                  onPressed: () {
                    if (personalInfoCtrl.formKeyPerSonalInfo.currentState
                            ?.validate() ??
                        false) {

                      personalInfoCtrl.updateUserDetails();
                      // Get.to(const IdentityProofScreen());
                    }
                  },
                ),
                buildSizeHeight(20),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
