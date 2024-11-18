import 'dart:io';

import 'package:dio/dio.dart'as dio;
import 'package:get/get.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../utils/base_functions.dart';
import '../../bank_detail_screen/bankdetails_screen.dart';
import '../model/identity_proof_response.dart';

class IdentityProofController extends GetxController {
  int selectedIndex = 0;
  File? selectedImage = File("");

  getDocType() {
    if (selectedIndex == 0) {
      return 401;
    }
    if (selectedIndex == 1) {
      return 402;
    }
    if (selectedIndex == 2) {
      return 403;
    }
  }

  addIdentityProofApi() async{
    dio.FormData formData = dio.FormData.fromMap({
      "doc_type": getDocType(),
      "document_photo": selectedImage?.path
    });
    if (selectedImage != null) {
      formData.files.add(MapEntry(
        "document_photo",
        await dio.MultipartFile.fromFile(
          selectedImage!.path,
        filename: selectedImage!.path.split('/').last,
      ),
      ));
    }
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addIdentityProof, data: formData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          IdentityProofResponse response =
              IdentityProofResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.to(const BankDetails());
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
