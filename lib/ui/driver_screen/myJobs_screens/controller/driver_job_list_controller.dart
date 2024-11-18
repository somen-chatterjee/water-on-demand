
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../backend/base_success_response.dart';
import '../../../../utils/base_functions.dart';
import '../../driver_details_screen/accept_screen.dart';
import '../../driver_home_screen/controller/driver_home_data_controller.dart';
import '../model/driver_job_response.dart';

class DriverJobListController extends GetxController{
  RxBool isDriverJobLoading = false.obs;
  RxList<OrderItemData>? orderItemDataList = <OrderItemData>[].obs;
  TextEditingController cancelReasonController = TextEditingController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
 var driverHomeCtrl = Get.find<DriverHomeDataController>();
  RxInt selectedIndex = 0.obs;

  getJobType() {
    if (selectedIndex.value == 0) {
      return 701;
    }
    if (selectedIndex.value == 1) {
      return 704;
    }
    if (selectedIndex.value == 2) {
      return 703;
    }
  }
  driverJobList() {
    isDriverJobLoading.value = true;
    Map<String, dynamic> data = {
      "order_status": getJobType(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().driverJobList, data: data,showLoader: true)
        .then((value) {
      // refreshController.refreshCompleted();
      isDriverJobLoading.value = false;
      if (value?.statusCode == 200) {
        try {
          DriverJobListResponse response = DriverJobListResponse.fromJson(value?.data);
          if (response.status ?? false) {
            orderItemDataList?.value = response.data?.orderItemData ?? [];
          } else {
            // showSnackBar(subtitle: response.message ?? "");
            orderItemDataList?.value = [] ;
          }
          update();
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  driverAcceptOrder({
    required int orderItemId,
    required bool isAcceptScreen,
    LatLng? userOrderLocation,
    LatLng? destinationLocation,
  }) async {
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
    };
    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().acceptOrder, data: data,)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            driverJobList();
            if(!isAcceptScreen) {
              Get.to(() =>  AcceptScreen(
                orderItemId: orderItemId,
                userOrderLocation: userOrderLocation,
                destinationLocation: destinationLocation,
              ));
              driverHomeCtrl.driverHomeDataApi();
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  driverRejectOrder(int orderItemId) async {
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
      "cancel_reason": cancelReasonController.text.trim(),
    };
    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().rejectOrder, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            driverJobList();
            driverHomeCtrl.driverHomeDataApi();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

}