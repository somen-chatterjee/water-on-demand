import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/backend/base_success_response.dart';
import 'package:water_on_demand/common_data_model/address_data_model.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/checkout/controller/checkout_controller.dart';
import 'package:water_on_demand/ui/dashboard/model/user_data_response.dart';
import 'package:water_on_demand/ui/onboardings/add_address/add_address_screen.dart';
import 'package:water_on_demand/ui/onboardings/add_address/model/add_address_response.dart';
import 'package:water_on_demand/ui/onboardings/create_account/controller/create_account_controller.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_no_data.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/custum_radiobutton.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';
import 'package:water_on_demand/common_data_model/profile_data.dart';

class DashboardController extends GetxController {
  String? userName;
  ProfileData? profileData;
  RxInt selectedIndex = 0.obs;

  RxBool isProfileLoading = false.obs;

  // @override
  // void onInit(){
  //   super.onInit();
  //   getUserDetails();
  // }

  CreateAccountController controller = Get.isRegistered() ? Get.find<CreateAccountController>() : Get.put(CreateAccountController());

  Future getUserDetails() async {
    isProfileLoading.value = true;

    await BaseApiService()
        .get(apiEndPoint:"${ApiEndPoints().profile}${BaseStorage.read(StorageKeys.userId)}", showLoader: true)
        .then((value) {
          log("somen $value");
          log("somen ${value?.data}");
          log("somen ${value?.data['Status']}");
          isProfileLoading.value = false;
      if (value?.statusCode == 200) {
        try {
          UserDataResponse response = UserDataResponse.fromJson(value?.data);
          if (response.status ?? false) {
            if(response.data != null && response.data!.profileData != null) {
              profileData = response.data?.profileData;
              userName = response.data?.profileData?.fullName;
              if(Get.isRegistered<CheckOutController>()){
                var checkOutController = Get.find<CheckOutController>();
                checkOutController.checkFloor();
                checkOutController.calculateTotalPrice();
              }

              dynamic roleId = BaseStorage.read(StorageKeys.roleId) ?? "";
              if (roleId == CheckRoleId().driver) {
                checkDriverScreen(profileData: profileData!);
              } else {
                if(profileData?.addressData == null) {
                  Get.to(() => AddAddressScreen(
                    isDriver: (BaseStorage.read(StorageKeys.roleId) ?? "") == CheckRoleId().driver.toString(),
                    isProfile: true,
                    isSocial: true,
                  ));
                }
              }

            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  getUserAddressList({required BuildContext context}) async {
    await BaseApiService()
        .get(apiEndPoint: ApiEndPoints().userAddressList, showLoader: true)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AddressDataModel response = AddressDataModel.fromJson(value?.data);
          if (response.status ?? false) {
            _changeAddressSheet(context, response.data?.addressesData ?? []);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  saveDefaultAddress({required BuildContext context, required String addressId}) async {

    Map<String, dynamic> mapData = {
      "address_id" : addressId
    };

    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().saveDefaultAddress, showLoader: true, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "",isSuccess: true);
            getUserDetails();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  addNewAddress({required bool isSocial}) {
    Map<String, dynamic> data = {
      "house_number": controller.apartmentController.text.trim(),
      "floor_number": int.parse(controller.dropdownValue ?? "0"),
      "building_name": controller.businessController.text.trim(),
      "address": controller.addressController.text.trim(),
      "latitude": controller.addressLatitude ?? "",
      "longitude": controller.addressLongitude ?? "",
      "instructions": controller.deliveryInstructionController.text.trim(),
      "address_type": controller.selectedAddressType,
    };
    log("addNewAddress $data");

    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addNewAddress, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AddAddressResponse response =
          AddAddressResponse.fromJson(value?.data);
          if (response.status ?? false) {
            if(isSocial){
              getUserDetails();
            }
            Get.back();
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  // change address bottom sheet
  void _changeAddressSheet(BuildContext bContext, List<AddressesData>? addressesData) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: bContext,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (builder) {
        return IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AnimatedColumn(
                  bottomPadding: 0.0,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: 'Change Address',
                          color: BaseColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(BaseAssets.cancelImage)),
                      ],
                    ),
                    buildSizeHeight(20),
                    SizedBox(
                      height: 300,
                      child: (addressesData?.length ?? 0) > 0
                          ? ListView.builder(
                        // shrinkWrap: true,
                        // physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: addressesData?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          if(profileData?.addressData?.addressId == addressesData?[index].addressId) {
                            selectedIndex.value = index;
                          }
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: BaseColors.docTypeBg,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                      color: BaseColors.secondaryColor),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            BaseText(
                                              value: checkAddressType(type: addressesData?[index].addressType.toString() ?? ""),
                                              color: BaseColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            buildSizeHeight(8),
                                            BaseText(
                                              value:
                                              "${addressesData?[index].houseNumber.toString()}, ${addressesData?[index].buildingName.toString()}, ${addressesData?[index].address.toString()}",
                                              color: BaseColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(() {
                                        return CustomRadio(
                                          value: index,
                                          groupValue: selectedIndex
                                              .value,
                                          onChanged: (value) {
                                            if (profileData?.addressData
                                                ?.addressId !=
                                                addressesData?[index].addressId) {
                                              selectedIndex.value =
                                                  value;
                                              saveDefaultAddress(
                                                  context: bContext,
                                                  addressId: addressesData?[index]
                                                      .addressId.toString() ??
                                                      "");
                                            }
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      : const BaseNoData(),
                    ),
                    buildSizeHeight(10),
                    BaseButton(
                      borderRadius: 10,
                      title: '+ Add More Address',
                      onPressed: () {
                          Get.to(AddAddressScreen(
                            isDriver: (BaseStorage.read(StorageKeys.roleId) ?? "") == CheckRoleId().driver.toString(),
                            isProfile: true,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}