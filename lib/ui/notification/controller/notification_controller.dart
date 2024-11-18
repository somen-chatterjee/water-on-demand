import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api_service.dart';
import '../../../utils/base_functions.dart';
import '../model/notificationlist_response.dart';

class NotificationController extends GetxController {
  RxBool isNotificationLoading = false.obs;
  RxList<NotificationData> notificationDataList = <NotificationData>[].obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final now = DateTime.now();
  @override
  void onInit() {
    getNotificationsList();
    super.onInit();
  }

  getNotificationsList() async {
    notificationDataList.value = [];
    isNotificationLoading.value = true;
    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().notificationList, showLoader: true)
          .then((value) {
        refreshController.refreshCompleted();
        if (value?.statusCode == 200) {
          NotificationListResponse response =
              NotificationListResponse.fromJson(value?.data);
          if (response.status ?? false) {
            notificationDataList.value = response.data?.notificationData ?? [];
          } else {
            // showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
        isNotificationLoading.value = false;
      });
    } on Exception {
      isNotificationLoading.value = false;
      refreshController.refreshCompleted();
    }
  }

  deleteNotification(id) async {
    Map<String, dynamic> data = {'notification_id': id};
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().notificationDelete, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        int index = notificationDataList
            .indexWhere((element) => element.notificationId == id);
        notificationDataList.removeAt(index);
      }
    });
    update();
  }

  String getDate(date) {
    final difference = now.difference(date);

    final formatter = DateFormat('yMd');
    final formattedDate = formatter.format(date);

    final timeAgo = _timeAgo(difference);
    if (kDebugMode) {
      print('$formattedDate, $timeAgo');
    }
    return timeAgo;
  }

  String _timeAgo(Duration duration) {
    if (duration.inDays >= 365) {
      final years = (duration.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (duration.inDays >= 30) {
      final months = (duration.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (duration.inDays >= 1) {
      return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }
}
