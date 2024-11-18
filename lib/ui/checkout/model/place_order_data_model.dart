class PlaceOrderDataModel {
  int? responseCode;
  bool? status;
  String? message;
  Data? data;

  PlaceOrderDataModel(
      {this.responseCode, this.status, this.message, this.data});

  PlaceOrderDataModel.fromJson(Map<String, dynamic> json) {
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
  int? orderId;
  int? orderItemId;
  String? paymentUrl;

  Data({this.orderId});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderItemId = json['orderItemId'];
    paymentUrl = json['paymentUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderItemId'] = orderItemId;
    data['paymentUrl'] = paymentUrl;
    return data;
  }
}
