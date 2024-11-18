import 'package:water_on_demand/ui/dashboard/components/order_screen/model/user_order_history_response.dart';

class OrderDetailsResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  OrderDetailsResponse(
      {this.responseCode, this.status, this.message, this.data});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  OrderItemData? orderItemData;

  Data({this.orderItemData});

  Data.fromJson(Map<String, dynamic> json) {
    orderItemData = json['orderItemData'] != null
        ? OrderItemData.fromJson(json['orderItemData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderItemData != null) {
      data['orderItemData'] = orderItemData!.toJson();
    }
    return data;
  }
}

