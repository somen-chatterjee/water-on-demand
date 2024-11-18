class ProfileData {
  dynamic userId;
  dynamic roleId;
  dynamic fullName;
  dynamic emailAddress;
  dynamic countryCode;
  dynamic mobileNumber;
  dynamic dob;
  dynamic userImage;
  dynamic terms;
  dynamic status;
  dynamic isOnline;
  dynamic createdAt;
  AddressData? addressData;
  BankData? bankData;
  DriverData? driverData;
  VehicleData? vehicleData;

  ProfileData(
      {this.userId,
        this.roleId,
        this.fullName,
        this.emailAddress,
        this.countryCode,
        this.mobileNumber,
        this.dob,
        this.userImage,
        this.terms,
        this.status,
        this.createdAt,
        this.addressData,
        this.isOnline,
        this.bankData,
        this.driverData,
        this.vehicleData});

  ProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    fullName = json['full_name'];
    emailAddress = json['email_address'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    userImage = json['user_image'];
    terms = json['terms'];
    status = json['status'];
    createdAt = json['created_at'];
    isOnline= json['is_online'];
    addressData = json['address_data'] != null
        ? AddressData.fromJson(json['address_data'])
        : null;
    bankData = json['bank_data'] != null
        ? BankData.fromJson(json['bank_data'])
        : null;
    driverData = json['driver_data'] != null
        ? DriverData.fromJson(json['driver_data'])
        : null;
    vehicleData = json['vehicle_data'] != null
        ? VehicleData.fromJson(json['vehicle_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['full_name'] = fullName;
    data['email_address'] = emailAddress;
    data['country_code'] = countryCode;
    data['mobile_number'] = mobileNumber;
    data['dob'] = dob;
    data['user_image'] = userImage;
    data['terms'] = terms;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['is_online']=isOnline;
    if (addressData != null) {
      data['address_data'] = addressData!.toJson();
    }
    if (bankData != null) {
      data['bank_data'] = bankData!.toJson();
    }
    if (driverData != null) {
      data['driver_data'] = driverData!.toJson();
    }
    if (vehicleData != null) {
      data['vehicle_data'] = vehicleData!.toJson();
    }
    return data;
  }
}

class AddressData {
  dynamic addressId;
  dynamic houseNumber;
  dynamic floorNumber;
  dynamic buildingName;
  dynamic address;
  dynamic latitude;
  dynamic longitude;
  dynamic instructions;
  dynamic addressType;

  AddressData(
      {this.addressId,
        this.houseNumber,
        this.floorNumber,
        this.buildingName,
        this.address,
        this.latitude,
        this.longitude,
        this.instructions,
        this.addressType});

  AddressData.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    houseNumber = json['house_number'];
    floorNumber = json['floor_number'];
    buildingName = json['building_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    instructions = json['instructions'];
    addressType = json['address_type'];
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
    return data;
  }
}

class BankData {
  dynamic bankDetailId;
  dynamic bankName;
  dynamic holderName;
  dynamic accountNumber;
  dynamic bankCode;

  BankData(
      {this.bankDetailId,
        this.bankName,
        this.holderName,
        this.accountNumber,
        this.bankCode});

  BankData.fromJson(Map<String, dynamic> json) {
    bankDetailId = json['bank_detail_id'];
    bankName = json['bank_name'];
    holderName = json['holder_name'];
    accountNumber = json['account_number'];
    bankCode = json['bank_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_detail_id'] = bankDetailId;
    data['bank_name'] = bankName;
    data['holder_name'] = holderName;
    data['account_number'] = accountNumber;
    data['bank_code'] = bankCode;
    return data;
  }
}

class DriverData {
  dynamic driverDetailId;
  dynamic docType;
  dynamic document;

  DriverData({this.driverDetailId, this.docType, this.document});

  DriverData.fromJson(Map<String, dynamic> json) {
    driverDetailId = json['driver_detail_id'];
    docType = json['doc_type'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver_detail_id'] = driverDetailId;
    data['doc_type'] = docType;
    data['document'] = document;
    return data;
  }
}

class VehicleData {
  int? vehicleDetailId;
  int? vehicleTypeId;
  String? make;
  String? model;
  String? year;
  String? vehicleNumber;
  String? regExpiryDate;
  String? insCompanyName;
  String? policyNumber;
  String? insExpiryDate;
  VehicleTypeData? vehicleTypeData;

  VehicleData(
      {this.vehicleDetailId,
        this.vehicleTypeId,
        this.make,
        this.model,
        this.year,
        this.vehicleNumber,
        this.regExpiryDate,
        this.insCompanyName,
        this.policyNumber,
        this.insExpiryDate,
        this.vehicleTypeData});

  VehicleData.fromJson(Map<String, dynamic> json) {
    vehicleDetailId = json['vehicle_detail_id'];
    vehicleTypeId = json['vehicle_type_id'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    vehicleNumber = json['vehicle_number'];
    regExpiryDate = json['reg_expiry_date'];
    insCompanyName = json['ins_company_name'];
    policyNumber = json['policy_number'];
    insExpiryDate = json['ins_expiry_date'];
    vehicleTypeData = json['vehicle_type_data'] != null
        ? VehicleTypeData.fromJson(json['vehicle_type_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle_detail_id'] = vehicleDetailId;
    data['vehicle_type_id'] = vehicleTypeId;
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['vehicle_number'] = vehicleNumber;
    data['reg_expiry_date'] = regExpiryDate;
    data['ins_company_name'] = insCompanyName;
    data['policy_number'] = policyNumber;
    data['ins_expiry_date'] = insExpiryDate;
    if (vehicleTypeData != null) {
      data['vehicle_type_data'] = vehicleTypeData!.toJson();
    }
    return data;
  }
}

class VehicleTypeData {
  int? vehicleTypeId;
  String? title;

  VehicleTypeData({this.vehicleTypeId, this.title});

  VehicleTypeData.fromJson(Map<String, dynamic> json) {
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