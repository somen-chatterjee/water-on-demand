import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/base_components/custom_radio_button.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/driver_screen/common_map_component/map_view_controller.dart';
import 'package:water_on_demand/ui/driver_screen/common_map_component/model/auto_complete_api_response.dart';
import 'package:water_on_demand/ui/driver_screen/personal_info/controller/personal_info_controller.dart';
import 'package:water_on_demand/ui/onboardings/create_account/controller/create_account_controller.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_strings.dart';

class AddAddressScreen extends StatefulWidget {
  final bool isDriver;
  final bool isProfile;
  final bool? isSocial;

  const AddAddressScreen(
      {super.key, required this.isDriver, required this.isProfile, this.isSocial,});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  MapViewController mapCtrl = Get.put(MapViewController());
  CreateAccountController controller = Get.find<CreateAccountController>();
  PersonalInfoController personalInfoController = Get.put(
      PersonalInfoController());
  final ValueNotifier<List<AutoCompleteResult>> _suggestions = ValueNotifier([
  ]);

  @override
  void initState() {
    controller.clearAddAddressData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.isSocial == null,
      child: BaseScaffoldBackground(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKeyAddAddress,
                child: AnimatedColumn(
                  milliseconds: 200,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(26),
                    if(widget.isSocial == null)
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
                      value: 'Add Address',
                      color: BaseColors.secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    buildSizeHeight(13),
                    const BaseText(
                      value: 'Please fill in your details to add address.',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    buildSizeHeight(25),
                    //Apartment / Flat / Block Number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Apartment / Flat / Block Number',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        GooglePlacesAutoCompleteTextFormField(
                          // proxyURL: "https://your-proxy.com/", // only needed if you build for the web
                          // debounceTime: 600, // defaults to 600 ms
                          // countries: ["de"], // optional, by default the list is empty (no restrictions)
                            textEditingController: controller.apartmentController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BaseColors.lightSky,
                                    width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BaseColors.lightSky,
                                    width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BaseColors.lightSky,
                                    width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red, width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BaseColors.lightSky,
                                    width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BaseColors.lightSky,
                                    width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                              ),
                              hintText: "Enter House / Flat / Block Number",
                              hintStyle: TextStyle(
                                color: BaseColors.grey,
                                fontSize: 14,
                              ),
                            ),
                            maxLines: 1,
                            style: const TextStyle(color: Colors.black, fontSize: 15),
                            validator: (val) {
                              if (controller.apartmentController.value.text
                                  .trim()
                                  .isEmpty) {
                                return "Please Enter Your Apartment,Flat,BlockNumber";
                              }
                              return null;
                            },
                            googleAPIKey: googleApiKey,

                            isLatLngRequired: true, // if you require the coordinates from the place details
                            getPlaceDetailWithLatLng: (prediction) {
                              // this method will return latlng with place detail
                              print("Coordinates: (${prediction.lat},${prediction.lng})");

                              controller.addressLatitude = prediction.lat;
                              controller.addressLongitude = prediction.lng;
                            }, // this callback is called when isLatLngRequired is true
                            itmClick: (prediction) {
                              controller.apartmentController.text = prediction.description??"";
                              // controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description.length));
                            },
                          onTapOutside: (s) {
                              controller.addressController.clear();
                          },
                          onFieldSubmitted: (s) {
                            controller.addressController.clear();
                          },
                        )
                        /*Obx(() {
                              log("mapCtrl.searchResultList ${mapCtrl.searchResultList.length}");
                              return TypeAheadField(
                                controller: controller.apartmentController,
                                builder: (context, textEditController,
                                    focusNode) {
                                  return TextFormField(
                                    controller: textEditController,
                                    focusNode: focusNode,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(12.0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: BaseColors.lightSky,
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: BaseColors.lightSky,
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: BaseColors.lightSky,
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: BaseColors.lightSky,
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: BaseColors.lightSky,
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                      ),
                                      hintText: "Enter House / Flat / Block Number",
                                      hintStyle: TextStyle(
                                        color: BaseColors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    validator: (val) {
                                      if (controller.apartmentController.value
                                          .text
                                          .trim()
                                          .isEmpty) {
                                        return "Please Enter Your Apartment, Flat, BlockNumber";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      mapCtrl.getSuggestionsList(value);
                                      mapCtrl.deBouncer.run(() async {
                                        await ;
                                      });
                                    },
                                  );
                                },
                                suggestionsCallback: (pattern) {
                                  if (mapCtrl.searchResultList.isNotEmpty) {
                                    return mapCtrl.searchResultList.map((e)=>e).toList();
                                    // return mapCtrl.searchResultList.where(
                                    //       (item) =>
                                    //       (item.description ?? "")
                                    //           .toLowerCase()
                                    //           .contains(
                                    //           pattern.toLowerCase()),
                                    // ).toList();
                                  }
                                  return null;
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion.description ?? ""),
                                  );
                                },
                                onSelected: (value) {
                                  controller.apartmentController.text = value.description ?? "";
                                },
                              );
                            }),*/
                        // BaseTextField(
                        //   controller: controller.apartmentController,
                        //   labelText: '',
                        //   hintText: 'Enter House / Flat / Block Number',
                        //   hintTextColor: BaseColors.grey,
                        //   borderColor: BaseColors.lightSky,
                        //   contentPadding: const EdgeInsets.all(12.0),
                        //   onChanged: (p0) {
                        //     mapCtrl.getSuggestionsList(p0);
                        //   },
                        //   validator: (val) {
                        //     if (controller.apartmentController.value.text
                        //         .trim()
                        //         .isEmpty) {
                        //       return "Please Enter Your Apartment,Flat,BlockNumber";
                        //     }
                        //     return null;
                        //   },
                        // ),
                      ],
                    ),
                    buildSizeHeight(15),
                    //Floor Number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Floor Number',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: BaseColors.lightSky),
                          ),
                          child: DropdownButtonFormField<String>(
                            hint: const BaseText(
                              value: 'Select Floor',
                              color: BaseColors.black,
                            ),
                            value: controller.dropdownValue,
                            onChanged: (String? value) {
                              setState(() {
                                controller.dropdownValue = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a floor';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                              errorStyle: TextStyle(
                                  color: Colors.red), // Style for error message
                            ),
                            items: controller.options.map<
                                DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(fontSize: 15)),
                              );
                            }).toList(),
                          ),
                        ),
                        buildSizeHeight(6.5),
                        const BaseText(
                          value: 'From the 3rd floor we need to levy Surcharge',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: BaseColors.grey,
                        ),
                      ],
                    ),
                    buildSizeHeight(15),
                    //street number / name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Street Number / Name',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        BaseTextField(
                          controller: controller.streetNumberController,
                          labelText: '',
                          hintText: 'Enter Street Number / Name',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.lightSky,
                          contentPadding: const EdgeInsets.all(12.0),
                          validator: (val) {
                            if (controller.streetNumberController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your StreetNumber,Name";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    buildSizeHeight(15),
                    // business / building name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Business / Building Name',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        BaseTextField(
                          labelText: '',
                          controller: controller.businessController,
                          hintText: 'Enter Business / Building Name',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.lightSky,
                          contentPadding: const EdgeInsets.all(12.0),
                          validator: (val) {
                            if (controller.businessController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Business Building Name ";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    buildSizeHeight(15),
                    //Instruction for delivery person
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Instruction for delivery person',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        BaseTextField(
                          controller: controller.deliveryInstructionController,
                          labelText: '',
                          maxLine: 5,
                          hintText: 'Enter Instruction For Delivery Person',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.lightSky,
                          contentPadding: const EdgeInsets.all(12.0),
                          validator: (val) {
                            if (controller
                                .deliveryInstructionController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Instruction";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    buildSizeHeight(15),
                    //Save As
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Save As',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        buildSizeHeight(6.5),
                        Wrap(
                          direction: Axis.horizontal,
                          children: controller.addressTypeList.map((val) {
                            return CustomRadioButton(
                              title: val['title'],
                              isSelected:
                              controller.selectedAddressType == val['type'],
                              onTap: () {
                                triggerHapticFeedback();
                                controller.selectedAddressType = val['type'];
                                setState(() {});
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    buildSizeHeight(25),
                    BaseButton(
                        borderRadius: 0.0,
                        title: 'Submit',
                        onPressed: () {
                          if (controller.formKeyAddAddress.currentState
                              ?.validate() ??
                              false) {
                            controller.addressController.text = controller
                                .apartmentController.text
                                .trim()
                                .toString();

                            if (!widget.isProfile) {
                              if (widget.isDriver) {
                                controller.addAddressApi();
                              } else {
                                Get.back();
                              }
                            } else {
                              Get.find<DashboardController>().addNewAddress(isSocial: widget.isSocial ?? false);
                            }
                          }
                          // Get.offAll(() => const DashboardScreen());
                        }),
                    buildSizeHeight(25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
