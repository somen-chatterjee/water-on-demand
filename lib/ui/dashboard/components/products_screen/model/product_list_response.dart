import 'package:water_on_demand/common_data_model/product_data.dart';

class ProductListResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  ProductListResponse(
      {this.responseCode, this.status, this.message, this.data});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
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
  List<ProductData>? productData;

  Data({this.productData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['productData'] != null) {
      productData = <ProductData>[];
      json['productData'].forEach((v) {
        productData!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productData != null) {
      data['productData'] = productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
