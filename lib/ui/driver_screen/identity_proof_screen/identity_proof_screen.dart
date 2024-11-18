import 'dart:io';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/driver_screen/identity_proof_screen/controller/identity_proof_controller.dart';

import '../../../utils/base_colors.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/custum_radiobutton.dart';
import '../../base_components/animated_column.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../controller/completekyc_controller.dart';

class IdentityProofScreen extends StatefulWidget {
  const IdentityProofScreen({super.key});

  @override
  State<IdentityProofScreen> createState() => _IdentityProofScreenState();
}

class _IdentityProofScreenState extends State<IdentityProofScreen> {
  CompleteKycController controller = Get.find<CompleteKycController>();
  IdentityProofController identityProofCtrl = Get.put(IdentityProofController());

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
                stepperList: controller.identityProofData,
                stepperDirection: Axis.horizontal,
                iconWidth: 24,
                iconHeight: 24,
                activeBarColor: BaseColors.primaryColor,
                inActiveBarColor: BaseColors.secondaryColor,
                activeIndex: 1,
                barThickness: 4,
                inverted: true,
              ),
              buildSizeHeight(20),
              const Center(
                child: BaseText(
                  value: 'Identity Proof',
                  color: BaseColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              buildSizeHeight(36),
              const BaseText(
                value: 'Document Type',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              buildSizeHeight(10),
              GestureDetector(
                onTap: () {
                  onChange(0);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: identityProofCtrl.selectedIndex == 0
                        ? BaseColors.docTypeBg
                        : BaseColors.white,
                    border: Border.all(
                      color: identityProofCtrl.selectedIndex == 0
                          ? BaseColors.secondaryColor
                          : BaseColors.radioContainerColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          value: 'National ID Card',
                          fontSize: 14,
                          color: identityProofCtrl.selectedIndex == 0
                              ? BaseColors.secondaryColor
                              : BaseColors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                        CustomRadio(
                          value: identityProofCtrl.selectedIndex,
                          groupValue: 0,
                          // ignore: avoid_types_as_parameter_names
                          onChanged: (int) {
                            setState(() {
                              identityProofCtrl.selectedIndex == 0;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              buildSizeHeight(20),
              GestureDetector(
                onTap: () {
                  onChange(1);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: identityProofCtrl.selectedIndex == 1
                        ? BaseColors.docTypeBg
                        : BaseColors.white,
                    border: Border.all(
                      color: identityProofCtrl.selectedIndex == 1
                          ? BaseColors.secondaryColor
                          : BaseColors.radioContainerColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          value: 'Driver\'s License',
                          fontSize: 14,
                          color: identityProofCtrl.selectedIndex == 1
                              ? BaseColors.secondaryColor
                              : BaseColors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                        CustomRadio(
                          value: identityProofCtrl.selectedIndex,
                          groupValue: 1,
                          // ignore: avoid_types_as_parameter_names
                          onChanged: (int) {
                            setState(() {
                              identityProofCtrl.selectedIndex == 1;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              buildSizeHeight(20),
              GestureDetector(
                onTap: () {
                  onChange(2);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: identityProofCtrl.selectedIndex == 2
                        ? BaseColors.docTypeBg
                        : BaseColors.white,
                    border: Border.all(
                        color: identityProofCtrl.selectedIndex == 2
                            ? BaseColors.secondaryColor
                            : BaseColors.radioContainerColor),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          value: 'International Passport',
                          fontSize: 14,
                          color: identityProofCtrl.selectedIndex == 2
                              ? BaseColors.secondaryColor
                              : BaseColors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                        CustomRadio(
                          value: identityProofCtrl.selectedIndex,
                          groupValue: 2,
                          // ignore: avoid_types_as_parameter_names
                          onChanged: (int) {
                            setState(() {
                              identityProofCtrl.selectedIndex == 2;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              buildSizeHeight(20),
              const BaseText(
                value: 'Upload Photo',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              buildSizeHeight(20),
              GestureDetector(
                onTap: () {
                  showMediaPicker().then((value) {
                    if ((value?.path ?? "").isNotEmpty) {
                      identityProofCtrl.selectedImage = value ?? File("");
                      setState(() {});
                    }
                  });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [3, 2],
                  color: const Color(0xffC2C2C2),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: BaseColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Icons.cloud_upload_outlined),
                          buildSizeWidth(10),
                          const BaseText(
                            value: "Upload",
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              buildSizeHeight(20),
              Visibility(
                visible: identityProofCtrl.selectedImage != null && identityProofCtrl.selectedImage!.path.isNotEmpty,
                child: Row(
                  children: [
                    Image.file(
                      File(identityProofCtrl.selectedImage!.path),
                      height: 62,
                      width: 71,
                      fit: BoxFit.cover,
                    ),
                    buildSizeWidth(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            value: "${identityProofCtrl.selectedImage?.path.split("/").last}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          buildSizeHeight(20),
                          SizedBox(
                            width: 232,
                            child: LinearProgressIndicator(
                              value: 100, // 70% progress
                              backgroundColor: Colors.grey[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  BaseColors.secondaryColor),
                              minHeight: 10.0, // Minimum height of the line
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildSizeHeight(20),
              BaseButton(
                borderRadius: double.nan,
                title: 'Continue',
                onPressed: () {
                  // Get.to(const SendRequestScreen());
                  if (identityProofCtrl.selectedImage?.path.isEmpty ?? true) {
                    showSnackBar(subtitle: "Please Upload The Document Photo");
                  } else {
                    identityProofCtrl.addIdentityProofApi();
                    // Get.to(const BankDetails());
                  }
                },
              ),
              buildSizeHeight(20),
            ],
          ),
        ),
      ),
    ));
  }

  void onChange(int index) {
    setState(() {
      identityProofCtrl.selectedIndex = index;
    });
  }
}
