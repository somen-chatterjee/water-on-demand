class AddressDataModel {
  int? responseCode;
  bool? status;
  String? message;
  Data? data;

  AddressDataModel({this.responseCode, this.status, this.message, this.data});

  AddressDataModel.fromJson(Map<String, dynamic> json) {
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
  List<AddressesData>? addressesData;

  Data({this.addressesData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['addressesData'] != null) {
      addressesData = <AddressesData>[];
      json['addressesData'].forEach((v) {
        addressesData!.add(AddressesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressesData != null) {
      data['addressesData'] =
          addressesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressesData {
  int? addressId;
  String? houseNumber;
  String? floorNumber;
  String? buildingName;
  String? address;
  String? latitude;
  String? longitude;
  String? instructions;
  int? addressType;
  bool? isDefault;

  AddressesData(
      {this.addressId,
        this.houseNumber,
        this.floorNumber,
        this.buildingName,
        this.address,
        this.latitude,
        this.longitude,
        this.instructions,
        this.addressType,
        this.isDefault});

  AddressesData.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    houseNumber = json['house_number'];
    floorNumber = json['floor_number'];
    buildingName = json['building_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    instructions = json['instructions'];
    addressType = json['address_type'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['house_number'] = houseNumber;
    data['floor_number'] = floorNumber;
    data['building_name'] = buildingName;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['instructions'] = instructions;
    data['address_type'] = addressType;
    data['is_default'] = isDefault;
    return data;
  }
}
