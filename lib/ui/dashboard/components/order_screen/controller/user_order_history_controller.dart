import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/model/order_details_response.dart';

import '../../../../../backend/api_end_points.dart';
import '../../../../../backend/base_api_service.dart';
import '../../../../../backend/base_success_response.dart';
import '../../../../../utils/base_functions.dart';
import '../components/order_details/order_details_screen.dart';
import '../model/user_order_history_response.dart';

class UserOrderHistoryController extends GetxController{
  final cancelReasonController = TextEditingController();
  RxBool isUserOrderLoading = false.obs;
  RxList<OrderItemData>? userOrderHistory = <OrderItemData>[].obs;
  Rx<OrderItemData>? orderDetails = OrderItemData().obs;

  int selectedIndex = 0;

  @override
  onInit(){
    super.onInit();
    getUserOrderHistory();
  }

  // 701=Pending, 703=Delivered, 704=Cancelled
  getOrderType() {
    if (selectedIndex == 0) {
      return 701;
    }
    if (selectedIndex == 1) {
      return 704;
    }
    if (selectedIndex == 2) {
      return 703;
    }
  }

  getUserOrderHistory() async {
    isUserOrderLoading.value = true;

    Map<String, dynamic> data = {
      "order_status": getOrderType(),
    };

    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().userOrderHistory, data: data, showLoader: false)
        .then((value) {
      isUserOrderLoading.value = false;
      if (value?.statusCode == 200) {
        try {
          UserOrderResponse response = UserOrderResponse.fromJson(value?.data);
          if (response.status ?? false) {
            userOrderHistory?.value = response.data?.orderItemData ?? [];
          } else {
            // showSnackBar(subtitle: response.message ?? "");
            userOrderHistory?.value = [];
          }
          userOrderHistory?.refresh();
          update();

        } catch (e) {
          isUserOrderLoading.value = false;
          showSnackBar(subtitle: parsingError);
        }
      } else {
        isUserOrderLoading.value = false;
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  cancelOrderApi(int index, dynamic orderItemId, bool isDetailScreen) {
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
      "cancel_reason": cancelReasonController.text.trim(),
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().cancelOrder, data: data)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            if(isDetailScreen){
              Get.back();
            }
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            userOrderHistory!.removeAt(index);
            cancelReasonController.clear();
            // Get.to(() => const CartScreen());
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
          update();
        } catch (e) {
          log("sam error $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }



  getOrderDetails(int? index, dynamic orderItemId) {
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().getOrderDetails, data: data,showLoader: true)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          OrderDetailsResponse response = OrderDetailsResponse.fromJson(value?.data);
          if (response.status ?? false) {
            orderDetails?.value = response.data?.orderItemData??OrderItemData();
            log("message ${orderDetails?.value.orderItemId}");
            if(index != null) {
              Get.to(() => OrderDetailsScreen(index: index, orderItemData: orderDetails?.value,));
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
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
}