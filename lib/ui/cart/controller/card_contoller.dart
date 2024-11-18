import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/product/product_details/controller/product_details_controller.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api_service.dart';
import '../../../backend/base_success_response.dart';
import '../../../utils/base_functions.dart';
import '../model/carddata_response.dart';

class CardController extends GetxController {
  RxBool isProductListLoading = false.obs;

  RxList<CartData>? cardData = <CartData>[].obs;
  RxString totalAmt = "0".obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ProductDetailsController _productDetailsController = Get.isRegistered()
      ? Get.find<ProductDetailsController>()
      : Get.put(ProductDetailsController());

  getCardData() async {
    isProductListLoading.value = true;
    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().getCardData, showLoader: true)
          .then((value) {
        refreshController.refreshCompleted();
        isProductListLoading.value = false;
        if (value?.statusCode == 200) {
          CardDataResponse response = CardDataResponse.fromJson(value?.data);
          if (response.status ?? false) {
            cardData?.value = response.data?.cartData ?? [];
            totalAmt.value = response.data?.totalAmt?.toString() ?? "";
            cardData?.refresh();
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      isProductListLoading.value = false;
      refreshController.refreshCompleted();
      log(e.toString());
    }
  }

  removeToCardApi(int productId) {
    Map<String, dynamic> data = {
      "product_id": productId,
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().removeToCard, data: data)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            await getCardData();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // Get.to(() => const CartScreen());
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

  increaseProduct({required CartData cardData}) async {
    int productId = cardData.productData?.productId;
    int unit = cardData.unit + 1;
    await _productDetailsController.addToCardApi(productId, unit, 601);
    getCardData();
  }

  decreaseProduct({required CartData cardData}) async {
    int productId = cardData.productData?.productId;
    int unit = cardData.unit - 1;
    if(unit > 0) {
      await _productDetailsController.addToCardApi(productId, unit, 601);
    }else{
      removeToCardApi(productId);
    }
    getCardData();
  }
}
