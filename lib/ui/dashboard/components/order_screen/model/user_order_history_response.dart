import 'package:water_on_demand/common_data_model/product_data.dart';

class UserOrderResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  UserOrderResponse({this.responseCode, this.status, this.message, this.data});

  UserOrderResponse.fromJson(Map<String, dynamic> json) {
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
  List<OrderItemData>? orderItemData;

  Data({this.orderItemData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orderItemData'] != null) {
      orderItemData = <OrderItemData>[];
      json['orderItemData'].forEach((v) {
        orderItemData!.add(OrderItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderItemData != null) {
      data['orderItemData'] =
          orderItemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemData {
  dynamic orderItemId;
  dynamic orderId;
  dynamic totalAmount;
  dynamic subTotal;
  dynamic orderStatus;
  dynamic cancelBtn;
  DriverData? driverData;
  List<OrderedData>? orderedData;

  OrderItemData(
      {this.orderItemId,
        this.orderId,
        this.totalAmount,
        this.subTotal,
        this.orderStatus,
        this.cancelBtn,
        this.orderedData,
        this.driverData,
      });

  OrderItemData.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    subTotal = json['sub_total'];
    orderStatus = json['order_status'];
    cancelBtn = json['cancel_btn'];
    if (json['ordered_data'] != null) {
      orderedData = <OrderedData>[];
      json['ordered_data'].forEach((v) {
        orderedData!.add(OrderedData.fromJson(v));
      });
    }
    driverData = json['driver_data'] != null
        ? DriverData.fromJson(json['driver_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_item_id'] = orderItemId;
    data['order_id'] = orderId;
    data['total_amount'] = totalAmount;
    data['sub_total'] = subTotal;
    data['order_status'] = orderStatus;
    data['cancel_btn'] = cancelBtn;
    if (orderedData != null) {
      data['ordered_data'] = orderedData!.map((v) => v.toJson()).toList();
    }
    if (driverData != null) {
      data['driver_data'] = driverData!.toJson();
    }
    return data;
  }
}

class OrderedData {
  dynamic cartId;
  dynamic unit;
  ProductData? productData;

  OrderedData({this.cartId, this.unit, this.productData});

  OrderedData.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    unit = json['unit'];
    productData = json['product_data'] != null
        ? ProductData.fromJson(json['product_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['unit'] = unit;
    if (productData != null) {
      data['product_data'] = productData!.toJson();
    }
    return data;
  }
}

class DriverData {
  dynamic userId;
  dynamic fullName;
  dynamic countryCode;
  dynamic mobileNumber;
  dynamic userImage;

  DriverData(
      {this.userId,
        this.fullName,
        this.countryCode,
        this.mobileNumber,
        this.userImage});

  DriverData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['country_code'] = countryCode;
    data['mobile_number'] = mobileNumber;
    data['user_image'] = userImage;
    return data;
  }
}

