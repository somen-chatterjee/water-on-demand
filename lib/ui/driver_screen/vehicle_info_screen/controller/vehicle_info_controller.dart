import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_success_response.dart';
import '../../../../utils/base_functions.dart';
import '../../driver_dasboard.dart';
import '../model/vehicle_type_response.dart';

class VehicleInfoController extends GetxController {

  RxBool isHomeDataLoading = false.obs;
  RxList<VehicleTypesData>? vehicleTypes = <VehicleTypesData>[].obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final formKeyVehicleInfo = GlobalKey<FormState>();

  String? dropdownValue;
  List<VehicleTypesData> options = [];

  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController vehicleRegistrationController = TextEditingController();
  TextEditingController insuranceCompanyController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  vehicleInfoApi() {
    Map<String, dynamic> data = {
      "vehicle_type_id": int.parse(dropdownValue ?? "0"),
      "make":makeController.text.trim(),
      "model":modelController.text.trim(),
      "year": yearController.text.trim(),
      "vehicle_number":licenseNumberController.text.trim(),
      "reg_expiry_date":vehicleRegistrationController.text.trim(),
      "ins_company_name": insuranceCompanyController.text.trim(),
      "policy_number": policyNumberController.text.trim(),
      "ins_expiry_date":expiryDateController.text.trim(),
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().vehicleInfo, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            BaseStorage.write(StorageKeys.kycDetails, "3");
            Get.offAll(() => const DriverDashboardScreen());
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



  getVehicleType() async {
    isHomeDataLoading.value = true;
    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().getVehicleList, showLoader: false)
          .then((value) {
        refreshController.refreshCompleted();
        isHomeDataLoading.value = false;
        if (value?.statusCode == 200) {
          VehicleTypesResponse response = VehicleTypesResponse.fromJson(value?.data);
          if (response.status ?? false) {
            vehicleTypes?.value = response.data?.vehicleTypesData??[];
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      isHomeDataLoading.value = false;
      refreshController.refreshCompleted();
      log(e.toString());
    }
  }
}
