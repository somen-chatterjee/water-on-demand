class TrackOrderDataModel {
  int? responseCode;
  bool? status;
  String? message;
  Data? data;

  TrackOrderDataModel(
      {this.responseCode, this.status, this.message, this.data});

  TrackOrderDataModel.fromJson(Map<String, dynamic> json) {
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
  AddressData? addressData;
  OrderData? orderData;

  Data({this.addressData, this.orderData});

  Data.fromJson(Map<String, dynamic> json) {
    addressData = json['addressData'] != null
        ? AddressData.fromJson(json['addressData'])
        : null;
    orderData = json['orderData'] != null
        ? OrderData.fromJson(json['orderData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressData != null) {
      data['addressData'] = addressData!.toJson();
    }
    if (orderData != null) {
      data['orderData'] = orderData!.toJson();
    }
    return data;
  }
}

class AddressData {
  String? fromAddress;
  String? toAddress;

  AddressData({this.fromAddress, this.toAddress});

  AddressData.fromJson(Map<String, dynamic> json) {
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
    return data;
  }
}

class OrderData {
  String? estDeliveryTime;
  int? orderStatus;

  OrderData({this.estDeliveryTime, this.orderStatus});

  OrderData.fromJson(Map<String, dynamic> json) {
    estDeliveryTime = json['est_delivery_time'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['est_delivery_time'] = estDeliveryTime;
    data['order_status'] = orderStatus;
    return data;
  }
}
