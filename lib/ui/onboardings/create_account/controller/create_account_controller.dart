import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_on_demand/ui/onboardings/otp/otp_screen.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../backend/base_success_response.dart';
import '../../../../utils/base_functions.dart';
import '../../add_address/model/add_address_response.dart';

class CreateAccountController extends GetxController {
  Rx<Data>? addAddressData = Data().obs;
  int selectedAddressType = 301;
  List<Map<String, dynamic>> addressTypeList = [
    {'title': 'Home', 'type': 301},
    {'title': 'Work', 'type': 302},
    {'title': 'Friends & Family', 'type': 303},
    {'title': 'Other', 'type': 304},
  ];
  String? dropdownValue;
  List<String> options = ['1', '2', '3', '4'];
  final formKeyCreateAccount = GlobalKey<FormState>();
  final formKeyAddAddress = GlobalKey<FormState>();

  String? addressLatitude;
  String? addressLongitude;

//add address text field
  TextEditingController apartmentController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController deliveryInstructionController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  createAccount({required bool isDriver}) async {
    Map<String, dynamic> data = {
      "role_id": isDriver ? CheckRoleId().driver : CheckRoleId().customer,
      "full_name": nameController.text.trim(),
      "email_address": emailController.text.trim(),
      "country_code": "+27",
      "mobile_number": numberController.text.trim(),
      "house_number": apartmentController.text.trim(),
      "floor_number": int.parse(dropdownValue ?? "0"),
      "building_name": businessController.text.trim(),
      "address": addressController.text.trim(),
      "latitude": addressLatitude ?? "",
      "longitude": addressLongitude ?? "",
      "instructions": deliveryInstructionController.text.trim(),
      "address_type": selectedAddressType,
      "device_token": await BaseStorage.read(StorageKeys.fcmToken) ?? "",
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().createAccount, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            triggerHapticFeedback();
            Get.to(() => OtpScreen(
                  isDriver: isDriver,
                  number: numberController.text.trim(),
                  isLogin: false,
                ));
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

  clearAddAddressData(){
    apartmentController.clear();
    dropdownValue=null;
    businessController.clear();
    streetNumberController.clear();
    addressController.clear();
    deliveryInstructionController.clear();
    selectedAddressType= 301;
  }

  // add address api
  addAddressApi() {
    Map<String, dynamic> data = {
      "house_number": apartmentController.text.trim(),
      "floor_number": int.parse(dropdownValue ?? "0"),
      "building_name": businessController.text.trim(),
      "address": addressController.text.trim(),
      "latitude": addressLatitude ?? "",
      "longitude": addressLongitude ?? "",
      "instructions": deliveryInstructionController.text.trim(),
      "address_type": selectedAddressType,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addAddress, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AddAddressResponse response =
              AddAddressResponse.fromJson(value?.data);
          if (response.status ?? false) {
            addAddressData?.value = response.data ?? Data();
            update();
            Get.back();
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

  /// Url launcher
  Future<void> launchTAndCUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      showSnackBar(subtitle: "Something went wrong, please try again");
    }
  }

}
