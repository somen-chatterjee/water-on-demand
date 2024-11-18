
import 'package:water_on_demand/common_data_model/profile_data.dart';

class LoginOtpResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  LoginOtpResponse({this.responseCode, this.status, this.message, this.data});

  LoginOtpResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    status = json['Status'];
    message = json['Message'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  ProfileData? profileData;
  String? verificationOtp;

  Data({this.accessToken, this.profileData, this.verificationOtp});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    profileData = json['profileData'] != null
        ? ProfileData.fromJson(json['profileData'])
        : null;
    verificationOtp = json['verificationOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (profileData != null) {
      data['profileData'] = profileData!.toJson();
    }
    data['verificationOtp'] = verificationOtp;
    return data;
  }
}
