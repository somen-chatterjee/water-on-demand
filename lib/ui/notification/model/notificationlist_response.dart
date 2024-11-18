class NotificationListResponse {
  dynamic responseCode;
  dynamic status;
  dynamic message;
  Data? data;

  NotificationListResponse(
      {this.responseCode, this.status, this.message, this.data});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
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
  List<NotificationData>? notificationData;

  Data({this.notificationData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notificationData'] != null) {
      notificationData = <NotificationData>[];
      json['notificationData'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationData != null) {
      data['notificationData'] =
          notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  dynamic notificationId;
  dynamic clickAction;
  dynamic message;
  dynamic isRead;
  dynamic createdAt;
  UserData? userData;

  NotificationData(
      {this.notificationId,
        this.clickAction,
        this.message,
        this.isRead,
        this.createdAt,
        this.userData});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    clickAction = json['click_action'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_id'] = notificationId;
    data['click_action'] = clickAction;
    data['message'] = message;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
  dynamic userId;
  dynamic fullName;
  dynamic userImage;

  UserData({this.userId, this.fullName, this.userImage});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['user_image'] = userImage;
    return data;
  }
}
