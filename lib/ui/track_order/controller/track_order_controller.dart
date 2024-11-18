
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/backend/base_api_service.dart';
import 'package:water_on_demand/ui/track_order/model/track_order_data_model.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../utils/base_colors.dart';

class TrackOrderController extends GetxController {
  List<StepperData> trackingData = [
    StepperData(
        title: StepperText(
          "Order Placed",
          textStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          decoration:  BoxDecoration(
              color: BaseColors.secondaryColor,
              border: Border.all(width: 1.5, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 10,
          ),
        )),
    StepperData(
        title: StepperText("Preparing"),
        subtitle: StepperText("Your order is being prepared"),
        iconWidget: Container(
          decoration: BoxDecoration(
              color: BaseColors.secondaryColor,
              border: Border.all(width:1.5, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 10,
          ),
        )),
    StepperData(
        title: StepperText("On the way"),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        iconWidget: Container(
          decoration:  BoxDecoration(
              color: BaseColors.secondaryColor,
              border: Border.all(width:1.5, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 10,
          ),
        )),
  ];

  Rx<AddressData?> addressData = AddressData().obs;
  Rx<OrderData?> orderData = OrderData().obs;

  trackOrder({required String orderId}) {
    Map<String, String> mapData = {
      "order_item_id": orderId,
    };

    BaseApiService()
        .post(
        apiEndPoint: ApiEndPoints().trackOrder,
        data: mapData,
        showLoader: true)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          TrackOrderDataModel response = TrackOrderDataModel.fromJson(value?.data);
          if (response.status ?? false) {
            addressData.value = response.data?.addressData ?? AddressData();
            orderData.value = response.data?.orderData ?? OrderData();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

}
