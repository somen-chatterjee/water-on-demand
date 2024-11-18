import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../utils/base_colors.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../controller/completekyc_controller.dart';
import 'controller/bank_detail_controller.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  CompleteKycController controller = Get.find<CompleteKycController>();
  BankDetailController bankDetailCtrl = Get.put(BankDetailController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key:bankDetailCtrl.formKeyBankDetail,
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
                    stepperList: controller.bankDetailsData,
                    stepperDirection: Axis.horizontal,
                    iconWidth: 24,
                    iconHeight: 24,
                    activeBarColor: Colors.indigo,
                    inActiveBarColor: Colors.indigo,
                    activeIndex: 1,
                    barThickness: 4,
                    inverted: true,
                  ),
                  buildSizeHeight(20),
                  const Center(
                    child: BaseText(
                      value: 'Bank Details',
                      color: BaseColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  buildSizeHeight(36),
                  const BaseText(
                    value: 'Bank Name',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                   BaseTextField(
                    labelText: '',
                    controller:bankDetailCtrl.bankNameController,
                    hintText: 'Enter Bank Name',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    contentPadding: const EdgeInsets.all(12.0),
                     validator: (val) {
                       if (bankDetailCtrl.bankNameController.value.text
                           .trim()
                           .isEmpty) {
                         return "Please Enter Bank Name";
                       }
                       return null;
                     },
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Account Holder Name',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                   BaseTextField(
                    labelText: '',
                    controller: bankDetailCtrl.accountHolderController,
                    hintText: 'Enter Account Holder Name',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    contentPadding: const EdgeInsets.all(12.0),
                     validator: (val) {
                       if (bankDetailCtrl.accountHolderController.value.text
                           .trim()
                           .isEmpty) {
                         return "Please Enter Account Holder Name";
                       }
                       return null;
                     },
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Account Number',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                   BaseTextField(
                    labelText: '',
                    controller: bankDetailCtrl.accountNumberController,
                    hintText: 'Enter Account Number',
                    hintTextColor: BaseColors.grey,
                    textInputType: TextInputType.number,
                    borderColor: BaseColors.lightSky,
                    contentPadding: const EdgeInsets.all(12.0),
                     validator: (val) {
                       if (bankDetailCtrl.accountNumberController.value.text
                           .trim()
                           .isEmpty) {
                         return "Please Enter Account Number";
                       }
                       return null;
                     },
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Branch Code',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                   BaseTextField(
                    labelText: '',
                    controller: bankDetailCtrl.branchCodeController,
                    hintText: 'Enter Branch Code',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    contentPadding: const EdgeInsets.all(12.0),
                     validator: (val) {
                       if (bankDetailCtrl.branchCodeController.value.text.trim()
                           .isEmpty) {
                         return "Please Enter Branch Code";
                       }
                       return null;
                     },
                  ),
                  buildSizeHeight(20),
                  BaseButton(
                    borderRadius: double.nan,
                    title: 'Continue',
                    onPressed: () {
                      if (bankDetailCtrl.formKeyBankDetail.currentState?.validate() ??
                          false ) {
                        bankDetailCtrl.addBankDetailApi();
                      }
                    },
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
