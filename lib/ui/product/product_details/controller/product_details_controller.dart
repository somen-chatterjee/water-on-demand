import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:water_on_demand/backend/base_success_response.dart';
import 'package:water_on_demand/ui/checkout/check_out_screen.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../utils/base_functions.dart';
import '../../../cart/cart_screen.dart';
import '../model/product_detail_response.dart';

class ProductDetailsController extends GetxController {
  Rx<ProductDetailsData>? productDetailsData = ProductDetailsData().obs;
  RxBool isProductDetailsLoading = false.obs;

  productDetailsApi(int productId) {
    isProductDetailsLoading.value = true;
    Map<String, dynamic> data = {
      "product_id": productId,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().productDetails, data: data,showLoader: true)
        .then((value) {
      isProductDetailsLoading.value = false;
      if (value?.statusCode == 200) {
        try {
          ProductDetailResponse response = ProductDetailResponse.fromJson(value?.data);
          if (response.status ?? false) {
            productDetailsData?.value = response.data ?? ProductDetailsData();
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          isProductDetailsLoading.value = false;
          showSnackBar(subtitle: parsingError);
        }
      } else {
        isProductDetailsLoading.value = false;
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  addToCardApi(int productId, int initialUnit, int purchaseType) async {
    // purchase_type
    // 601=Cart, 602=Buy Now
    Map<String, dynamic> data = {
      "product_id": productId,
      "unit": initialUnit,
      "purchase_type": purchaseType,
    };
    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addToCard, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            if(purchaseType == 601) {
              showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            }
            if(purchaseType == 601) {
              Get.to(() => CartScreen(purchaseType: purchaseType));
            } else {
              Get.to(() => CheckOutScreen(purchaseType: purchaseType));
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
}
