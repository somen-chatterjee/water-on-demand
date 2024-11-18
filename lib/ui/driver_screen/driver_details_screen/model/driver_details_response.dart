class DriverDetailsResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  DriverDetailsResponse(
      {this.responseCode, this.status, this.message, this.data});

  DriverDetailsResponse.fromJson(Map<String, dynamic> json) {
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

class OrderItemData {
  dynamic orderItemId;
  dynamic subTotal;
  dynamic totalAmount;
  dynamic orderStatus;
  dynamic acceptBtn;
  dynamic pickupBtn;
  dynamic cancelBtn;
  OrderData? orderData;
  List<OrderedData>? orderedData;

  OrderItemData(
      {this.orderItemId,
        this.subTotal,
        this.totalAmount,
        this.orderStatus,
        this.acceptBtn,
        this.pickupBtn,
        this.cancelBtn,
        this.orderData,
        this.orderedData});

  OrderItemData.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    subTotal = json['sub_total'];
    totalAmount = json['total_amount'];
    orderStatus = json['order_status'];
    acceptBtn = json['accept_btn'];
    pickupBtn = json['pickup_btn'];
    cancelBtn = json['cancel_btn'];
    orderData = json['order_data'] != null
        ? OrderData.fromJson(json['order_data'])
        : null;
    if (json['ordered_data'] != null) {
      orderedData = <OrderedData>[];
      json['ordered_data'].forEach((v) {
        orderedData!.add(OrderedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_item_id'] = orderItemId;
    data['sub_total'] = subTotal;
    data['total_amount'] = totalAmount;
    data['order_status'] = orderStatus;
    data['accept_btn'] = acceptBtn;
    data['pickup_btn'] = pickupBtn;
    data['cancel_btn'] = cancelBtn;
    if (orderData != null) {
      data['order_data'] = orderData!.toJson();
    }
    if (orderedData != null) {
      data['ordered_data'] = orderedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  dynamic orderId;
  dynamic startDate;
  dynamic endDate;
  dynamic distance;
  UserData? userData;
  OrderAddress? orderAddress;
  FromAddress? fromAddress;

  OrderData(
      {this.orderId,
        this.startDate,
        this.endDate,
        this.distance,
        this.userData,
        this.fromAddress,
        this.orderAddress});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    distance= json['distance'];
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    orderAddress = json['order_address'] != null
        ? OrderAddress.fromJson(json['order_address'])
        : null;
    fromAddress = json['from_address'] != null
        ? FromAddress.fromJson(json['from_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['distance']= distance;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (orderAddress != null) {
      data['order_address'] = orderAddress!.toJson();
    }
    if (fromAddress != null) {
      data['from_address'] = fromAddress!.toJson();
    }
    return data;
  }
}

class UserData {
  dynamic fullName;
  dynamic userId;
  dynamic countryCode;
  dynamic mobileNumber;
  dynamic userImage;

  UserData(
      {this.userId,
        this.fullName,
        this.countryCode,
        this.mobileNumber,
        this.userImage});

  UserData.fromJson(Map<String, dynamic> json) {
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

class OrderAddress {
  dynamic addressId;
  dynamic houseNumber;
  dynamic floorNumber;
  dynamic buildingName;
  dynamic address;
  dynamic latitude;
  dynamic longitude;
  dynamic instructions;
  dynamic addressType;
  dynamic isDefault;

  OrderAddress(
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

  OrderAddress.fromJson(Map<String, dynamic> json) {
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

class OrderedData {
  int? cartId;
  int? unit;
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

class ProductData {
  int? productId;
  String? title;
  String? image;
  String? description;
  int? quantity;
  String? price;

  ProductData(
      {this.productId,
        this.title,
        this.image,
        this.description,
        this.quantity,
        this.price});

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class FromAddress {
  dynamic adminAddress;
  dynamic adminLatitude;
  dynamic adminLongitude;

  FromAddress({this.adminAddress, this.adminLatitude, this.adminLongitude});

  FromAddress.fromJson(Map<String, dynamic> json) {
    adminAddress = json['admin_address'];
    adminLatitude = json['admin_latitude'];
    adminLongitude = json['admin_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin_address'] = adminAddress;
    data['admin_latitude'] = adminLatitude;
    data['admin_longitude'] = adminLongitude;
    return data;
  }
}
