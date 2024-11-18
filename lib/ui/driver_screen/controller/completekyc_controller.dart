import 'package:another_stepper/dto/stepper_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/utils/base_colors.dart';

class CompleteKycController extends GetxController {
  TextEditingController controller = TextEditingController();

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Personal Info",
          textStyle: const TextStyle(
            color: BaseColors.primaryColor,
          ),
        ),
        iconWidget: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
    StepperData(
        title: StepperText("ID Proof",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
            )),
        iconWidget: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: BaseColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
    StepperData(
        title: StepperText("Bank Details",
            textStyle: const TextStyle(fontWeight: FontWeight.w300)),
        iconWidget: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: BaseColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
  ];
  List<StepperData> identityProofData = [
    StepperData(
        title: StepperText(
          "Personal Info",
          textStyle: const TextStyle(
            color: BaseColors.primaryColor,
          ),
        ),
        iconWidget: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
    StepperData(
        title: StepperText("ID Proof",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              color: BaseColors.primaryColor,
            )),
        iconWidget: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
    StepperData(
        title: StepperText("Bank Details",
            textStyle: const TextStyle(fontWeight: FontWeight.w300)),
        iconWidget: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: BaseColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
  ];
  List<StepperData> bankDetailsData = [
    StepperData(
        title: StepperText(
          "Personal Info",
          textStyle: const TextStyle(
            color: BaseColors.primaryColor,
          ),
        ),
        iconWidget: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
    StepperData(
        title: StepperText("ID Proof",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              color: BaseColors.primaryColor,
            )),
        iconWidget: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
    StepperData(
        title: StepperText("Bank Details",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              color: BaseColors.primaryColor,
            )),
        iconWidget: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ))),
  ];
}
