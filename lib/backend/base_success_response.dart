class BaseSuccessResponse {
  dynamic responseCode;
  dynamic success; // bool
  dynamic message; // String


  BaseSuccessResponse({this.success, this.message, this.responseCode});

  BaseSuccessResponse.fromJson(Map<String, dynamic> json) {
    responseCode=json['ResponseCode'];
    success = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['ResponseCode']=responseCode;
    data['Status'] = success;
    data['Message'] = message;
    return data;
  }
}
