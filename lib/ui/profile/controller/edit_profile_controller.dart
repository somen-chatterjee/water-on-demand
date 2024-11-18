
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/dashboard/model/user_data_response.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

class EditProfileController extends GetxController {
  final formEditKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // update user profile
  updateUserDetails({String? imagePath}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "_method":"PUT",
      "full_name": nameController.text.trim().toString(),
      "email_address": emailController.text.trim().toString(),
      "country_code":"+27",
      // "mobile_number": phoneController.text.trim().toString(),
      // "dob": 10-12-1995
    });

    if (imagePath != null && imagePath.isNotEmpty) {
      formData.files.add(MapEntry(
        "user_photo",
        await dio.MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      ),
      ));
    }

    BaseApiService()
        .post(
        apiEndPoint: "${ApiEndPoints().profile}${BaseStorage.read(StorageKeys.userId)}",
        data: formData,
    )
        .then((value) {

      if (value?.statusCode == 200) {
        try {
          UserDataResponse response = UserDataResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.put(DashboardController()).getUserDetails();
            Get.back();
            showSnackBar(subtitle: response.message ?? "",isSuccess: true);
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
}