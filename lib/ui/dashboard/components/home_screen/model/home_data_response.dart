import 'package:water_on_demand/common_data_model/product_data.dart';

class HomeDataResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  HomeData? data;

  HomeDataResponse({this.responseCode, this.status, this.message, this.data});

  HomeDataResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    status = json['Status'];
    message = json['Message'];
    data = json['Data'] != null ? HomeData.fromJson(json['Data']) : null;
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

class HomeData {
  int? newNotification;
  List<BannerData>? bannerData;
  List<ProductData>? productData;

  HomeData({this.newNotification, this.bannerData, this.productData});

  HomeData.fromJson(Map<String, dynamic> json) {
    newNotification = json['newNotification'];
    if (json['bannerData'] != null) {
      bannerData = <BannerData>[];
      json['bannerData'].forEach((v) {
        bannerData!.add(BannerData.fromJson(v));
      });
    }
    if (json['productData'] != null) {
      productData = <ProductData>[];
      json['productData'].forEach((v) {
        productData!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newNotification'] = newNotification;
    if (bannerData != null) {
      data['bannerData'] = bannerData!.map((v) => v.toJson()).toList();
    }
    if (productData != null) {
      data['productData'] = productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  dynamic bannerId;
  dynamic image;

  BannerData({this.bannerId, this.image});

  BannerData.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['image'] = image;
    return data;
  }
}

