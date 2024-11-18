import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/ui/dashboard/components/home_screen/model/home_data_response.dart';

import '../../../../../backend/api_end_points.dart';
import '../../../../../utils/base_functions.dart';

class HomeController extends GetxController {
  RxBool isHomeDataLoading = false.obs;
  Rx<HomeData>? homeData = HomeData().obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  getHomeData() async {
    isHomeDataLoading.value = true;
    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().homeData, showLoader: false)
          .then((value) {
        refreshController.refreshCompleted();
        isHomeDataLoading.value = false;
        if (value?.statusCode == 200) {
          HomeDataResponse response = HomeDataResponse.fromJson(value?.data);
          if (response.status ?? false) {
            homeData?.value = response.data ?? HomeData();
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      isHomeDataLoading.value = false;
      refreshController.refreshCompleted();
      log(e.toString());
    }
  }
}
