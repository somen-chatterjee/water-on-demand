import 'package:water_on_demand/common_data_model/product_data.dart';

class ProductDetailResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  ProductDetailsData? data;

  ProductDetailResponse(
      {this.responseCode, this.status, this.message, this.data});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    status = json['Status'];
    message = json['Message'];
    data =
        json['Data'] != null ? ProductDetailsData.fromJson(json['Data']) : null;
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

class ProductDetailsData {
  bool? cartAdded;
  ProductData? productData;

  ProductDetailsData({this.cartAdded, this.productData});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    cartAdded = json['cartAdded'];
    productData = json['productData'] != null
        ? ProductData.fromJson(json['productData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartAdded'] = cartAdded;
    if (productData != null) {
      data['productData'] = productData!.toJson();
    }
    return data;
  }
}
