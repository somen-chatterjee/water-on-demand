import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/cart/components/cart_order_list.dart';
import 'package:water_on_demand/ui/checkout/check_out_screen.dart';
import 'package:water_on_demand/ui/dashboard/dashboard_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_no_data.dart';

import 'controller/card_contoller.dart';

class CartScreen extends StatefulWidget {
  final int purchaseType;
  const CartScreen({super.key, required this.purchaseType});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CardController controller = Get.find<CardController>();

  final ScrollController _scrollController = ScrollController();

  List<int> cartList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  int selectedIndex = 0;

  ValueNotifier<bool> isExtended = ValueNotifier<bool>(true);

  @override
  void initState() {
    controller.getCardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Obx(() {
        return Scaffold(
          bottomNavigationBar: Visibility(
            visible: (controller.cardData?.length ?? 0) != 0,
            child: BaseContainer(
              leftMargin: 10.0,
              rightMargin: 10.0,
              bottomMargin: 10.0,
              topMargin: 0.0,
              leftPadding: 20.0,
              rightPadding: 20.0,
              height: 90,
              boxShadow: const BoxShadow(
                color: BaseColors.lightSky,
                blurRadius: 50,
                spreadRadius: 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Total Price',
                        fontSize: 14,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSizeHeight(5.0),
                          const BaseText(
                            value: 'R',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: BaseColors.secondaryColor,
                          ),
                          BaseText(
                            value: controller.totalAmt.value,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                  BaseButton(
                    btnWidth: 150,
                    btnHeight: 47,
                    title: 'Check Out',
                    borderEnable: true,
                    borderColor: BaseColors.primaryColor,
                    btnTextColor: BaseColors.primaryColor,
                    borderRadius: 30.0,
                    onPressed: () {
                      Get.to(() => const CheckOutScreen(purchaseType: 601,));
                    },
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: ValueListenableBuilder(
              valueListenable: isExtended,
              builder: (context, value, _) {
                return FloatingActionButton.extended(
                  shape: value ? null : const CircleBorder(
                      side: BorderSide.none),
                  backgroundColor: BaseColors.secondaryColor,
                  // foregroundColor: Colors.black,
                  onPressed: () {
                    Get.offAll(() => const DashboardScreen(bodyIndex: 2,));
                  },
                  label: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: child,
                        ),
                      );
                    },
                    child: value
                        ? const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.add,
                            color: BaseColors.white,
                          ),
                        ),
                        BaseText(
                          value: "Add more items",
                          fontWeight: FontWeight.w500,
                          color: BaseColors.white,
                        ),
                      ],
                    )
                        : const Icon(
                      Icons.add,
                      color: BaseColors.white,
                    ),
                  ),
                );
              }),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(26),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 25.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BaseText(
                        value: 'Cart',
                        color: BaseColors.secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          BaseAssets.backArrow,
                          width: 19,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                buildSizeHeight(28),
                Obx(() {
                  if((controller.cardData?.length ??0 ) ==0){
                    return Column(
                      children: [
                        buildSizeHeight(200.0),
                        const BaseNoData(),
                      ],
                    );
                  }
                  return Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification t) {
                        // if (t is ScrollEndNotification) {
                        //   print('end $_scrollController.position.pixels');
                        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        //   isExtended.value = true;
                        // });
                        // }

                        // if(t is ScrollUpdateNotification){
                        //   print('update $_scrollController.position.pixels');
                        //   isExtended.value = false;
                        // }
                        //
                        // if(t.metrics.pixels == 0){
                        //   print('start $_scrollController.position.pixels');
                        //   isExtended.value = true;
                        // }

                        if (t.metrics.atEdge) {
                          isExtended.value = true;
                        } else {
                          isExtended.value = false;
                        }

                        //How many pixels scrolled from pervious frame
                        // print(t.metrics.scrollDelta);

                        //List scroll position
                        // print(t.metrics.pixels);
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 72.0),
                        itemCount: controller.cardData?.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        // physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (controller.cardData != null &&
                              controller.cardData!.isNotEmpty) {
                            return CartOrderList(
                              index: index,
                              onIncrement: () {
                                controller.increaseProduct(
                                    cardData: controller.cardData![index]);
                              },
                              onDecrement: () {
                                controller.decreaseProduct(
                                    cardData: controller.cardData![index]);
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                          // return Text("data");
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

}
