import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/backend/base_success_response.dart';
import 'package:water_on_demand/ui/driver_screen/congratulation_screen.dart';
import 'package:water_on_demand/ui/onboardings/otp/model/register_otp_response.dart';
import 'package:water_on_demand/utils/check_role_id.dart';

import '../../../../utils/base_functions.dart';
import '../../../../utils/get_storage.dart';
import '../../../../utils/storage_keys.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../model/login_otp_response.dart';

class LoginOtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxBool isResendEnable = false.obs;
  RxBool countdownShow = true.obs;

  callVerifyOtpApi({required bool isDriver, required String isNumber}) async {
    var deviceToken = await BaseStorage.read(StorageKeys.fcmToken) ?? "";
    Map<String, String> data = {
      "mobile_number": isNumber,
      "country_code": "+27",
      "device_token": deviceToken,
      "verification_otp": otpController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().loginOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          LoginOtpResponse response = LoginOtpResponse.fromJson(value?.data);
          if (response.status ?? false) {
            // set token
            BaseStorage.write(
              StorageKeys.apiToken,
              response.data?.accessToken ?? "",
            );
            // set userId
            BaseStorage.write(
              StorageKeys.userId,
              response.data?.profileData?.userId ?? "",
            );
            // set roleId
            BaseStorage.write(
              StorageKeys.roleId,
              response.data?.profileData?.roleId ?? "",
            );
            // set name
            BaseStorage.write(
              StorageKeys.fullName,
              response.data?.profileData?.fullName ?? "",
            );
            // set email
            BaseStorage.write(
              StorageKeys.emailId,
              response.data?.profileData?.emailAddress ?? "",
            );
            // set number
            BaseStorage.write(
              StorageKeys.phoneNumber,
              response.data?.profileData?.mobileNumber ?? "",
            );
            // set address id
            BaseStorage.write(
              StorageKeys.addressId,
              response.data?.profileData?.addressData?.addressId ?? "",
            );

            if ((response.data?.profileData?.roleId ?? "") == CheckRoleId().driver) {
              if(response.data != null) {
                BaseStorage.write(
                  StorageKeys.kycDetails,
                  "",
                );
                checkDriverScreen(profileData: response.data!.profileData!,isLogin: true);
              }
              // var kycDetails = BaseStorage.read(StorageKeys.kycDetails);
              // print("sam $kycDetails");
              //
              // if(kycDetails == null && kycDetails.isBlank){
              //   Get.to(const CompleteKycScreen());
              // } else if(kycDetails == 0){
              //   Get.to(const IdentityProofScreen());
              // } else if(kycDetails == 1){
              //   Get.to(const BankDetails());
              // } else if(kycDetails == 2) {
              //   Get.to(const VehicleInfoScreen());
              // } else {
              //   Get.offAll(() => const DriverDashboardScreen());
              // }
            } else {
              Get.offAll(() => const DashboardScreen());
            }
          } else {
            otpController.clear();
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

  validateAccountOtpApi({required bool isDriver, required String isNumber}) async {
    Map<String, String> data = {
      "mobile_number": isNumber,
      "country_code": "+27",
      "verification_otp": Get.find<LoginOtpController>().otpController.text.trim(),
      "device_token": await BaseStorage.read(StorageKeys.fcmToken) ?? "",
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().validateAccount, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          RegisterOtpResponse response =
          RegisterOtpResponse.fromJson(value?.data);
          if (response.status ?? false) {
            // set token
            BaseStorage.write(
              StorageKeys.apiToken,
              response.data?.accessToken ?? "",
            );
            // set userId
            BaseStorage.write(
              StorageKeys.userId,
              response.data?.profileData?.userId ?? "",
            );
            // set roleId
            BaseStorage.write(
              StorageKeys.roleId,
              response.data?.profileData?.roleId ?? "",
            );
            // set name
            BaseStorage.write(
              StorageKeys.fullName,
              response.data?.profileData?.fullName ?? "",
            );
            // set email
            BaseStorage.write(
              StorageKeys.emailId,
              response.data?.profileData?.emailAddress ?? "",
            );
            // set number
            BaseStorage.write(
              StorageKeys.phoneNumber,
              response.data?.profileData?.mobileNumber ?? "",
            );
            // set address id
            BaseStorage.write(
              StorageKeys.addressId,
              response.data?.profileData?.addressData?.addressId ?? "",
            );

            if ((response.data?.profileData?.roleId ?? "") == CheckRoleId().driver) {

              Get.offAll(() => const CongratulationScreen());
            } else {
              Get.offAll(() => const DashboardScreen());
            }

          } else {
            otpController.clear();
            showSnackBar(subtitle: value?.data['Message'] ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  Future<void> resendOtp({required String isNumber}) async {
    Map<String, String> data = {
      "country_code": "+27",
      "mobile_number": isNumber,
    };
    await BaseApiService().post(apiEndPoint: ApiEndPoints().resendOtp, data: data).then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            countdownShow.value = true;
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
