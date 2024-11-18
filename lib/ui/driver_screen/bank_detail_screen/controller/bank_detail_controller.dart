import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/backend/base_api_service.dart';

import '../../../../utils/base_functions.dart';
import '../../sendrequest_screen.dart';
import '../model/bank_details_response.dart';

class BankDetailController extends GetxController {
  final formKeyBankDetail = GlobalKey<FormState>();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController branchCodeController = TextEditingController();

  addBankDetailApi() async {
    Map<String, dynamic> data = {
      "bank_name": bankNameController.text.trim(),
      "holder_name": accountHolderController.text.trim(),
      "account_number": accountNumberController.text.trim(),
      "bank_code": branchCodeController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addBankDetail, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BankDetailResponse response =
              BankDetailResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.to(const SendRequestScreen());
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
