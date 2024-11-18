import 'package:water_on_demand/common_data_model/profile_data.dart';

class BankDetailResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  BankDetailResponse({this.responseCode, this.status, this.message, this.data});

  BankDetailResponse.fromJson(Map<String, dynamic> json) {
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
  ProfileData? profileData;

  Data({this.profileData});

  Data.fromJson(Map<String, dynamic> json) {
    profileData = json['profileData'] != null
        ? ProfileData.fromJson(json['profileData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileData != null) {
      data['profileData'] = profileData!.toJson();
    }
    return data;
  }
}

