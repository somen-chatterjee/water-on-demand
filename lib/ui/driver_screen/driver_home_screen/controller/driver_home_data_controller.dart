import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../utils/base_functions.dart';
import '../../myJobs_screens/model/driver_job_response.dart';
import '../model/driver_home_Response.dart';

class DriverHomeDataController extends GetxController{
  RxBool isHomeDataListLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  RxList<OrderItemData>? orderItemData = <OrderItemData>[].obs;
  RxInt selectedIndex = 0.obs;

  driverHomeDataApi() async {
    isHomeDataListLoading.value = true;
    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().driverHomeData, showLoader: true)
          .then((value) {
        refreshController.refreshCompleted();
        isHomeDataListLoading.value = false;
        if (value?.statusCode == 200) {
          DriverHomeDataResponse response = DriverHomeDataResponse.fromJson(value?.data);
          if (response.status ?? false) {
            orderItemData?.value = response.data?.orderItemData ?? [];
          } else {
            orderItemData?.value = [];
            // showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
        update();
      });
    } on Exception catch (e) {
      isHomeDataListLoading.value = false;
      refreshController.refreshCompleted();
      log(e.toString());
    }
  }
}