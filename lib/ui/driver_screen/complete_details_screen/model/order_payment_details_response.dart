class OrderPaymentDetailsResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  OrderPaymentDetailsResponse(
      {this.responseCode, this.status, this.message, this.data});

  OrderPaymentDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  PaymentData? paymentData;
  dynamic invoiceUrl;

  Data({this.paymentData, this.invoiceUrl});

  Data.fromJson(Map<String, dynamic> json) {
    paymentData = json['paymentData'] != null
        ? PaymentData.fromJson(json['paymentData'])
        : null;
    invoiceUrl = json['invoiceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentData != null) {
      data['paymentData'] = paymentData!.toJson();
    }
    data['invoiceUrl'] = invoiceUrl;
    return data;
  }
}

class PaymentData {
  dynamic subTotalAmt;
  dynamic adminFee;
  dynamic floorCharge;
  dynamic deliveryFee;
  dynamic grandTotalAmt;

  PaymentData(
      {this.subTotalAmt,
        this.adminFee,
        this.floorCharge,
        this.deliveryFee,
        this.grandTotalAmt});

  PaymentData.fromJson(Map<String, dynamic> json) {
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
