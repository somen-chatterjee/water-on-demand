
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_app_bar_bg.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/listview_builder_animation.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/components/user_order_loading.dart';
import 'package:water_on_demand/ui/dashboard/components/order_screen/controller/user_order_history_controller.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../../utils/base_no_data.dart';
import 'components/order_list_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  UserOrderHistoryController controller = Get.put(UserOrderHistoryController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    controller.getUserOrderHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  buildSizeHeight(103),
                  Expanded(
                    child: SmartRefresher(
                      controller: _refreshController,
                      header: const WaterDropMaterialHeader(
                        backgroundColor: BaseColors.primaryColor,
                      ),
                      onRefresh: () {
                        controller.getUserOrderHistory();
                        _refreshController.refreshCompleted();
                      },
                      child: SingleChildScrollView(
                        child: AnimatedColumn(
                          leftPadding: 0.0,
                          rightPadding: 0.0,
                          children: [
                            buildSizeHeight(35),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        selectIndex(0);
                                      },
                                      child: BaseContainer(
                                        bottomMargin: 0.0,
                                        borderRadius: 0.0,
                                        leftPadding: 0.0,
                                        rightPadding: 0.0,
                                        topPadding: 0.0,
                                        bottomPadding: 0.0,
                                        height: 46,
                                        boxShadow: const BoxShadow(
                                          color: BaseColors.lightSky,
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0,
                                        ),
                                        border: Border.all(
                                          color: controller.selectedIndex == 0
                                              ? BaseColors.secondaryColor
                                              : BaseColors.lightSky,
                                          width: 1.0,
                                        ),
                                        child: Center(
                                          child: BaseText(
                                            textAlign: TextAlign.center,
                                            value: 'Ongoing',
                                            color: controller.selectedIndex == 0
                                                ? BaseColors.secondaryColor
                                                : BaseColors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildSizeWidth(20),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        selectIndex(1);
                                      },
                                      child: BaseContainer(
                                        bottomMargin: 0.0,
                                        borderRadius: 0.0,
                                        leftPadding: 0.0,
                                        rightPadding: 0.0,
                                        topPadding: 0.0,
                                        bottomPadding: 0.0,
                                        height: 46,
                                        boxShadow: const BoxShadow(
                                          color: BaseColors.lightSky,
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0,
                                        ),
                                        border: Border.all(
                                          color: controller.selectedIndex == 1
                                              ? BaseColors.secondaryColor
                                              : BaseColors.lightSky,
                                          width: 1.0,
                                        ),
                                        child: Center(
                                          child: BaseText(
                                            textAlign: TextAlign.center,
                                            value: 'Cancelled',
                                            color: controller.selectedIndex == 1
                                                ? BaseColors.secondaryColor
                                                : BaseColors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildSizeWidth(20),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        selectIndex(2);
                                      },
                                      child: BaseContainer(
                                        bottomMargin: 0.0,
                                        borderRadius: 0.0,
                                        leftPadding: 0.0,
                                        rightPadding: 0.0,
                                        topPadding: 0.0,
                                        bottomPadding: 0.0,
                                        height: 46,
                                        boxShadow: const BoxShadow(
                                          color: BaseColors.lightSky,
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0,
                                        ),
                                        border: Border.all(
                                          color: controller.selectedIndex == 2
                                              ? BaseColors.secondaryColor
                                              : BaseColors.lightSky,
                                          width: 1.0,
                                        ),
                                        child: Center(
                                          child: BaseText(
                                            textAlign: TextAlign.center,
                                            value: 'Completed',
                                            color: controller.selectedIndex == 2
                                                ? BaseColors.secondaryColor
                                                : BaseColors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buildSizeHeight(18),
                            Obx(() {
                              if(controller.isUserOrderLoading.value) {
                                return const UserOrderLoading();
                              }

                              if ((controller.userOrderHistory?.length ?? 0) ==
                                  0) {
                                return Column(
                                  children: [
                                    buildSizeHeight(150.0),
                                    const BaseNoData(),
                                  ],
                                );
                              }
                              return ListView.builder(
                                itemCount:
                                controller.userOrderHistory?.length ?? 0,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return ListviewBuilderAnimation(
                                    index: index,
                                    child: OrderListCard(
                                        index: index,
                                        orderedItemData: controller
                                            .userOrderHistory?[index],
                                    ),
                                  );
                                },
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.selectedIndex = 0;
  }

  void selectIndex(int index) {
    if (controller.selectedIndex != index) {
      setState(() {
        controller.selectedIndex = index;
        controller.getUserOrderHistory();
      });
    }
  }
}
