import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_app_bar_bg.dart';
import 'package:water_on_demand/ui/dashboard/components/home_screen/components/home_screen_loading.dart';
import 'package:water_on_demand/ui/dashboard/components/home_screen/components/product_list.dart';
import 'package:water_on_demand/ui/dashboard/controller/dashboard_controller.dart';
import 'package:water_on_demand/ui/product/product_details/product_details_screen.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../../utils/base_colors.dart';
import '../../../../utils/base_no_data.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  DashboardController dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
    controller.getHomeData();
    dashboardController.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isHomeDataLoading.value) {
          return const HomeScreenLoading();
        }
        return SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  buildSizeHeight(103),
                  Expanded(
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      header: const WaterDropMaterialHeader(
                        backgroundColor: BaseColors.primaryColor,
                      ),
                      onRefresh: () {
                        controller.getHomeData();
                        dashboardController.getUserDetails();
                      },
                      child: SingleChildScrollView(
                        child: AnimatedColumn(
                          leftPadding: 0.0,
                          rightPadding: 0.0,
                          children: [
                            Column(
                              children: [
                                buildSizeHeight(35),
                                if ((controller.homeData?.value.bannerData
                                            ?.length ??
                                        0) >
                                    0)
                                  CarouselSlider.builder(
                                      itemCount: controller.homeData?.value
                                              .bannerData?.length ??
                                          0,
                                      options: CarouselOptions(
                                        autoPlay: false,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.9,
                                        aspectRatio: 2.0,
                                        initialPage: 0,
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) {
                                        return cachedNetworkImage(
                                          image: controller
                                                  .homeData
                                                  ?.value
                                                  .bannerData?[itemIndex]
                                                  .image ??
                                              "",
                                          height: 238,
                                          width: double.maxFinite,
                                          fit: BoxFit.fitWidth,
                                        );
                                      },
                                  ),
                              ],
                            ),
                            buildSizeHeight(18),
                            Obx(() {
                              if ((controller.homeData?.value.productData
                                          ?.length ??
                                      0) ==
                                  0) {
                                return Column(
                                  children: [
                                    buildSizeHeight(200.0),
                                    const BaseNoData(),
                                  ],
                                );
                              }
                              return SizedBox(
                                height: 230,
                                child: ListView.builder(
                                  itemCount: controller.homeData?.value
                                          .productData?.length ??
                                      0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProductDetailsScreen(
                                              productData: controller.homeData!
                                                  .value.productData![index],
                                            ));
                                      },
                                      child: ProductList(
                                        title: controller.homeData?.value
                                                .productData?[index].title ??
                                            "",
                                        price: controller.homeData?.value
                                                .productData?[index].price ??
                                            "",
                                        productImg: controller.homeData?.value
                                                .productData?[index].image ??
                                            "",
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                            buildSizeHeight(30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const BaseAppBarBg(),
            ],
          ),
        );
      }),
    );
  }
}
