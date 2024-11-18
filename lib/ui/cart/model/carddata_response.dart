import 'package:water_on_demand/common_data_model/product_data.dart';

class CardDataResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  CardDataResponse({this.responseCode, this.status, this.message, this.data});

  CardDataResponse.fromJson(Map<String, dynamic> json) {
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
  String? totalAmt;
  List<CartData>? cartData;

  Data({this.totalAmt, this.cartData});

  Data.fromJson(Map<String, dynamic> json) {
    totalAmt = json['totalAmt'];
    if (json['cartData'] != null) {
      cartData = <CartData>[];
      json['cartData'].forEach((v) {
        cartData!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmt'] = totalAmt;
    if (cartData != null) {
      data['cartData'] = cartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  dynamic cartId;
  dynamic unit;
  ProductData? productData;

  CartData({this.cartId, this.unit, this.productData});

  CartData.fromJson(Map<String, dynamic> json) {
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
