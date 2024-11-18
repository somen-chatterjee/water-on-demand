import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/ui/onboardings/login/model/login_response.dart';
import 'package:water_on_demand/ui/onboardings/otp/otp_screen.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../utils/base_functions.dart';

class LoginController extends GetxController {
  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();

  loginResponse({required bool isDriver}) async {
    Map<String, String> data = {
      "country_code": "+27",
      "device_token": await BaseStorage.read(StorageKeys.fcmToken) ?? "",
      "mobile_number": numberController.text.trim(),
      "role_id": isDriver ? CheckRoleId().driver.toString() : CheckRoleId().customer.toString()
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().loginAccount, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          LoginResponse response = LoginResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.to(() => OtpScreen(isDriver: isDriver, number: numberController.text.trim(),isLogin: true,));
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
}
