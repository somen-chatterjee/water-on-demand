import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/profile/controller/edit_profile_controller.dart';
import 'package:water_on_demand/utils/custum_shake_widget.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';
import '../base_components/animated_column.dart';
import '../base_components/base_button.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controller = TextEditingController();
  DashboardController dController = Get.find<DashboardController>();
  EditProfileController editProfileController =
      Get.put(EditProfileController());
  final ImagePicker picker = ImagePicker();
  File? selectedImage = File("");

  @override
  void initState() {
    super.initState();
    editProfileController.phoneController.text =
        dController.profileData?.mobileNumber ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editProfileController.nameController.text =
          dController.profileData?.fullName ?? "";
      editProfileController.emailController.text =
          dController.profileData?.emailAddress ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: editProfileController.formEditKey,
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
                  buildSizeHeight(30),
                  const BaseText(
                    value: 'Edit Profile',
                    color: BaseColors.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(19),
                  const BaseText(
                    value: 'Please fill in your details to edit\nyour account',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  buildSizeHeight(19),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        // radius: 50,
                        child: dController.profileData == null &&
                                dController.profileData!.userImage == null
                            ? Image.asset(
                                BaseAssets.profileImage,
                                height: 110,
                              )
                            : selectedImage != null &&
                                    selectedImage!.path.isNotEmpty
                                ? Image.file(
                                    File(selectedImage!.path),
                                    fit: BoxFit.cover,
                                    height: 110,
                                    width: 110,
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        dController.profileData!.userImage!,
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: -15,
                        child: GestureDetector(
                          onTap: () {
                            showMediaPicker().then((value) {
                              if ((value?.path ?? "").isNotEmpty) {
                                selectedImage = value ?? File("");
                                setState(() {});
                              }
                            });
                          },
                          child: SvgPicture.asset(BaseAssets.editWithBg),
                        ),
                      )
                    ],
                  ),
                  buildSizeHeight(36),
                  const BaseText(
                    value: 'Full Name',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  BaseTextField(
                    controller: editProfileController.nameController,
                    labelText: '',
                    hintText: 'Full Name',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    contentPadding: const EdgeInsets.all(12.0),
                    validator: (value) {
                      var name =
                          editProfileController.nameController.text.trim();
                      if (name.isEmpty) {
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
                    controller: editProfileController.emailController,
                    labelText: '',
                    hintText: 'Email ID',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    contentPadding: const EdgeInsets.all(12.0),
                    validator: (value) {
                      var email =
                          editProfileController.emailController.text.trim();
                      if (email.isEmpty) {
                        return "Please Enter Email";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
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
                  GetBuilder<DashboardController>(builder: (logic) {
                    return BaseTextField(
                      controller: editProfileController.phoneController,
                      labelText: '',
                      hintText: 'Enter Mobile Number',
                      readOnly:
                          editProfileController.phoneController.text.isNotEmpty
                              ? true
                              : false,
                      filled:
                          editProfileController.phoneController.text.isNotEmpty
                              ? true
                              : false,
                      fillColor:
                          editProfileController.phoneController.text.isNotEmpty
                              ? BaseColors.disableColor
                              : null,
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
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
                    );
                  }),
                  buildSizeHeight(25.5),
                  BaseButton(
                    borderRadius: double.nan,
                    title: 'Save',
                    onPressed: () {
                      if (editProfileController.formEditKey.currentState
                              ?.validate() ??
                          false) {
                        editProfileController.updateUserDetails(
                            imagePath: selectedImage?.path);
                      }
                      // Get.back();
                    },
                  ),
                  buildSizeHeight(22.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
