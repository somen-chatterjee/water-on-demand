import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/common_data_model/product_data.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../../../backend/api_end_points.dart';
import '../../../../../backend/base_api_service.dart';
import '../model/product_list_response.dart';

class ProductListController extends GetxController {
  RxBool isProductListLoading = false.obs;
  RxList<ProductData>? productList = <ProductData>[].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  getProductList() async {
    isProductListLoading.value = true;
    try {
      await BaseApiService()
          .get(apiEndPoint: ApiEndPoints().productList, showLoader: false)
          .then((value) {
        refreshController.refreshCompleted();
        isProductListLoading.value = false;
        if (value?.statusCode == 200) {
          ProductListResponse response =
              ProductListResponse.fromJson(value?.data);
          if (response.status ?? false) {
            productList?.value = response.data?.productData ?? [];
            productList?.refresh();
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
}
