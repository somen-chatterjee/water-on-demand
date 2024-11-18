import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../utils/base_functions.dart';
import '../../../../utils/get_storage.dart';
import '../../../../utils/storage_keys.dart';
import '../../../dashboard/controller/dashboard_controller.dart';
import '../../../dashboard/model/user_data_response.dart';
import '../../identity_proof_screen/identity_proof_screen.dart';

class PersonalInfoController extends GetxController {
  final ImagePicker picker = ImagePicker();
  File? selectedImage = File("");
  final formKeyPerSonalInfo = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = BaseStorage.read(StorageKeys.fullName) ?? "";
    emailIdController.text = BaseStorage.read(StorageKeys.emailId) ?? "";
    mobileNoController.text = BaseStorage.read(StorageKeys.phoneNumber) ?? "";
  }

  // update user profile
  updateUserDetails({String? imagePath}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "_method": "PUT",
      "full_name": fullNameController.text.trim().toString(),
      "email_address": emailIdController.text.trim().toString(),
      "country_code": "+27",
      "mobile_number": mobileNoController.text.trim().toString(),
      "dob": dobController.text.trim(),
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
      apiEndPoint:
          "${ApiEndPoints().profile}${BaseStorage.read(StorageKeys.userId)}",
      data: formData,
    )
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          UserDataResponse response = UserDataResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.put(DashboardController());
            Get.to(const IdentityProofScreen());
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
      update();
    });
  }
}
