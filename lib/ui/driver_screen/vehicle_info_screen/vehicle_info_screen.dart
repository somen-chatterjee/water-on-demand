import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../utils/base_assets.dart';
import '../../../utils/base_colors.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import 'controller/vehicle_info_controller.dart';
import 'model/vehicle_type_response.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  VehicleInfoController controller = Get.put(VehicleInfoController());

  @override
  void initState() {
    controller.getVehicleType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKeyVehicleInfo,
              child: AnimatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizeHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BaseText(
                        value: 'Vehicle Info',
                        color: BaseColors.secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            BaseAssets.backArrow,
                            width: 19,
                            height: 20,
                          )),
                    ],
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Vehicle Type',
                    color: BaseColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(10),
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border:
                        Border.all(width: 1.0, color: BaseColors.lightSky),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            border: InputBorder.none
                        ),
                        hint: const BaseText(
                          value: 'Select Vehicle Type',
                          color: BaseColors.black,
                        ),
                        value: controller.dropdownValue,
                        onChanged: (String? value) {
                            controller.dropdownValue = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select Vehicle Type';
                          }
                          return null;
                        },
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.black),
                        selectedItemBuilder: (BuildContext context) {
                          return controller.vehicleTypes!.map((
                              VehicleTypesData value) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                value.title ?? '',
                              ),
                            );
                          }).toList();
                        },
                        items: controller.vehicleTypes?.map<
                            DropdownMenuItem<String>>((VehicleTypesData value) {
                          return DropdownMenuItem<String>(
                            value: value.vehicleTypeId.toString(),
                            child:
                            Text(value.title,
                                style: const TextStyle(fontSize: 15)),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  buildSizeHeight(20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Make',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            width: 150,
                            child: BaseTextField(
                              controller: controller.makeController,
                              labelText: '',
                              hintText: 'Enter Make',
                              hintTextColor: BaseColors.grey,
                              borderColor: BaseColors.lightSky,
                              textInputType: TextInputType.number,
                              contentPadding: const EdgeInsets.all(12.0),
                              validator: (val) {
                                if (controller.makeController.value.text
                                    .trim()
                                    .isEmpty) {
                                  return "Please Enter Make";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      buildSizeWidth(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Model',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            width: 150,
                            child: BaseTextField(
                              controller: controller.modelController,
                              labelText: '',
                              hintText: 'Enter Model',
                              hintTextColor: BaseColors.grey,
                              borderColor: BaseColors.lightSky,
                              contentPadding: const EdgeInsets.all(12.0),
                              validator: (val) {
                                if (controller.modelController.value.text
                                    .trim()
                                    .isEmpty) {
                                  return "Please Enter Model";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Year',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                    controller: controller.yearController,
                    labelText: '',
                    hintText: 'Enter Year',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    textInputType: TextInputType.number,
                    contentPadding: const EdgeInsets.all(12.0),
                    validator: (val) {
                      if (controller.yearController.value.text
                          .trim()
                          .isEmpty) {
                        return "Please Enter Your Year";
                      }
                      return null;
                    },
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'License Plate Number',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                    controller: controller.licenseNumberController,
                    labelText: '',
                    hintText: 'Enter License Plate Number',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    textInputType: TextInputType.number,
                    contentPadding: const EdgeInsets.all(12.0),
                    validator: (val) {
                      if (controller.licenseNumberController.value.text
                          .trim()
                          .isEmpty) {
                        return "Please Enter License Plate Number";
                      }
                      return null;
                    },
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Vehicle Registration Expiry Date',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                      controller: controller.vehicleRegistrationController,
                      labelText: '',
                      hintText: 'Enter Expiry Date',
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      readOnly: true,
                      contentPadding: const EdgeInsets.all(12.0),
                      validator: (val) {
                        if (controller.vehicleRegistrationController.value.text
                            .trim()
                            .isEmpty) {
                          return "Please Enter Vehicle Registration Expiry Date";
                        }
                        return null;
                      },
                      onTap: () {
                        showBaseDatePicker(context,firstDate: DateTime.now()).then((
                            val) {
                          if (val.isNotEmpty) {
                            controller.vehicleRegistrationController.text = val;
                          }
                        });
                      }
                  ),
                  const BaseText(
                    value: 'Insurance Information',
                    color: BaseColors.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(20),
                  const BaseText(
                    value: 'Insurance Company Name',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                    controller: controller.insuranceCompanyController,
                    labelText: '',
                    hintText: 'Enter Insurance Company Name',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    contentPadding: const EdgeInsets.all(12.0),
                    // validator: (val) {
                    //   if (controller.insuranceCompanyController.value.text
                    //       .trim()
                    //       .isEmpty) {
                    //     return "Please Enter Insurance Company Name";
                    //   }
                    //   return null;
                    // },
                  ),
                  const BaseText(
                    value: 'Policy Number',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                    controller: controller.policyNumberController,
                    labelText: '',
                    hintText: 'Enter Policy Number',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.lightSky,
                    textInputType: TextInputType.number,
                    contentPadding: const EdgeInsets.all(12.0),
                    // validator: (val) {
                    //   if (controller.policyNumberController.value.text
                    //       .trim()
                    //       .isEmpty) {
                    //     return "Please Enter Policy Number";
                    //   }
                    //   return null;
                    // },
                  ),
                  const BaseText(
                    value: 'Expiry Date',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                      controller: controller.expiryDateController,
                      labelText: '',
                      hintText: 'Enter Expiry Date',
                      hintTextColor: BaseColors.grey,
                      readOnly: true,
                      borderColor: BaseColors.lightSky,
                      contentPadding: const EdgeInsets.all(12.0),
                      // validator: (val) {
                      //   if (controller.expiryDateController.value.text
                      //       .trim()
                      //       .isEmpty) {
                      //     return "Please Enter Expiry Date";
                      //   }
                      //   return null;
                      // },
                      onTap: () {
                        showBaseDatePicker(context,firstDate: DateTime.now()).then((
                            val) {
                          if (val.isNotEmpty) {
                            controller.expiryDateController.text = val;
                          }
                        });
                      }
                  ),
                  buildSizeHeight(20),
                  BaseButton(
                      borderRadius: double.nan,
                      title: 'Submit',
                      onPressed: () {
                        if (controller.formKeyVehicleInfo.currentState
                            ?.validate() ??
                            false) {
                          controller.vehicleInfoApi();
                        }
                      }),
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
