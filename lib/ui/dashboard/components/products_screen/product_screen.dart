import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_app_bar_bg.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/listview_builder_animation.dart';
import 'package:water_on_demand/ui/dashboard/components/products_screen/components/product_list_card.dart';
import 'package:water_on_demand/ui/dashboard/components/products_screen/components/product_screen_loading.dart';
import 'package:water_on_demand/ui/dashboard/components/products_screen/controller/product_list_controller.dart';
import 'package:water_on_demand/ui/product/product_details/product_details_screen.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductListController controller = Get.put(ProductListController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    controller.getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Obx(() {
                return Column(
                  children: [
                    buildSizeHeight(103),
                    Expanded(
                      child: SmartRefresher(
                        controller: _refreshController,
                        header: const WaterDropMaterialHeader(
                          backgroundColor: BaseColors.primaryColor,
                        ),
                        onRefresh: () {
                          controller.getProductList();
                          _refreshController.refreshCompleted();
                        },
                        child: SingleChildScrollView(
                          child: AnimatedColumn(
                            leftPadding: 0.0,
                            rightPadding: 0.0,
                            children: [
                              buildSizeHeight(35),
                              if (controller.isProductListLoading.value || (controller.productList ?? []).isEmpty)
                                const ProductScreenLoading()
                              else
                                GridView.builder(
                                  primary: false,
                                  itemCount:
                                      controller.productList?.length ?? 0,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 22.0,
                                    childAspectRatio: 0.8,
                                    // mainAxisSpacing: 22.0,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListviewBuilderAnimation(
                                      index: index,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetailsScreen(
                                              productData: controller
                                                  .productList![index]));
                                        },
                                        child: ProductListCard(
                                          title: controller
                                              .productList?[index].title,
                                          price: controller
                                              .productList?[index].price,
                                          productImg: controller
                                                  .productList?[index].image ??
                                              "",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const BaseAppBarBg(),
            ],
          ),
        ),
      ),
    );
  }
}
