class VehicleTypesResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  VehicleTypesResponse(
      {this.responseCode, this.status, this.message, this.data});

  VehicleTypesResponse.fromJson(Map<String, dynamic> json) {
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
  List<VehicleTypesData>? vehicleTypesData;

  Data({this.vehicleTypesData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vehicleTypesData'] != null) {
      vehicleTypesData = <VehicleTypesData>[];
      json['vehicleTypesData'].forEach((v) {
        vehicleTypesData!.add(VehicleTypesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (vehicleTypesData != null) {
      data['vehicleTypesData'] =
          vehicleTypesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleTypesData {
  dynamic vehicleTypeId;
  dynamic title;

  VehicleTypesData({this.vehicleTypeId, this.title});

  VehicleTypesData.fromJson(Map<String, dynamic> json) {
    vehicleTypeId = json['vehicle_type_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle_type_id'] = vehicleTypeId;
    data['title'] = title;
    return data;
  }
}
