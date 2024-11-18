class CheckOutDataModel {
  int? responseCode;
  bool? status;
  String? message;
  Data? data;

  CheckOutDataModel({this.responseCode, this.status, this.message, this.data});

  CheckOutDataModel.fromJson(Map<String, dynamic> json) {
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
  SettingData? settingData;
  List<PaymentCardData>? paymentCardData;
  AmountData? amountData;

  Data({this.settingData, this.paymentCardData, this.amountData});

  Data.fromJson(Map<String, dynamic> json) {
    settingData = json['settingData'] != null
        ? SettingData.fromJson(json['settingData'])
        : null;
    if (json['paymentCardData'] != null) {
      paymentCardData = <PaymentCardData>[];
      json['paymentCardData'].forEach((v) {
        paymentCardData!.add(PaymentCardData.fromJson(v));
      });
    }
    amountData = json['amountData'] != null
        ? AmountData.fromJson(json['amountData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (settingData != null) {
      data['settingData'] = settingData!.toJson();
    }
    if (paymentCardData != null) {
      data['paymentCardData'] =
          paymentCardData!.map((v) => v.toJson()).toList();
    }
    if (amountData != null) {
      data['amountData'] = amountData!.toJson();
    }
    return data;
  }
}

class SettingData {
  String? collectText;
  String? deliveryText;
  String? floorCharge;

  SettingData({this.collectText, this.deliveryText, this.floorCharge});

  SettingData.fromJson(Map<String, dynamic> json) {
    collectText = json['collect_text'];
    deliveryText = json['delivery_text'];
    floorCharge = json['floor_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collect_text'] = collectText;
    data['delivery_text'] = deliveryText;
    data['floor_charge'] = floorCharge;
    return data;
  }
}

class PaymentCardData {
  int? paymentCardId;
  String? cardType;
  String? cardNumber;
  String? cardHolderName;
  String? expires;

  PaymentCardData(
      {this.paymentCardId,
        this.cardType,
        this.cardNumber,
        this.cardHolderName,
        this.expires});

  PaymentCardData.fromJson(Map<String, dynamic> json) {
    paymentCardId = json['payment_card_id'];
    cardType = json['card_type'];
    cardNumber = json['card_number'];
    cardHolderName = json['card_holder_name'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_card_id'] = paymentCardId;
    data['card_type'] = cardType;
    data['card_number'] = cardNumber;
    data['card_holder_name'] = cardHolderName;
    data['expires'] = expires;
    return data;
  }
}

class AmountData {
  String? subTotalAmt;
  String? adminFee;
  String? floorCharge;
  String? deliveryFee;
  String? grandTotalAmt;

  AmountData(
      {this.subTotalAmt,
        this.adminFee,
        this.floorCharge,
        this.deliveryFee,
        this.grandTotalAmt});

  AmountData.fromJson(Map<String, dynamic> json) {
    subTotalAmt = json['subTotalAmt'];
    adminFee = json['adminFee'];
    floorCharge = json['floorCharge'];
    deliveryFee = json['deliveryFee'];
    grandTotalAmt = json['grandTotalAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotalAmt'] = subTotalAmt;
    data['adminFee'] = adminFee;
    data['floorCharge'] = floorCharge;
    data['deliveryFee'] = deliveryFee;
    data['grandTotalAmt'] = grandTotalAmt;
    return data;
  }
}
