import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/common_data_model/product_data.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/cart/controller/card_contoller.dart';
import 'package:water_on_demand/ui/checkout/check_out_screen.dart';
import 'package:water_on_demand/ui/product/product_details/components/product_detail_loading.dart';
import 'package:water_on_demand/ui/product/product_details/controller/product_details_controller.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';


class ProductDetailsScreen extends StatefulWidget {
  final ProductData productData;
  const ProductDetailsScreen( {super.key, required this.productData, });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsController productCtrl = Get.put(ProductDetailsController());

  @override
  void initState() {
    productController.productDetailsApi(widget.productData.productId);
    super.initState();
  }

  ProductDetailsController productController =
      Get.put(ProductDetailsController());
  CardController controller = Get.isRegistered() ? Get.find<CardController>() : Get.put(CardController());

  ValueNotifier<int> initialUnit = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: Obx(() {
            return AnimatedColumn(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              leftPadding: 0.0,
              rightPadding: 0.0,
              children: [
                Stack(
                  children: [
                    cachedNetworkImage(
                      height: 300,
                      image: productController.productDetailsData?.value.productData?.image ?? "",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SafeArea(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: SvgPicture.asset(
                            BaseAssets.backArrow,
                            width: 19,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              BaseColors.white,
                              BlendMode.srcATop,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(24),
                    BaseText(
                      value: productController
                              .productDetailsData?.value.productData?.title ??
                          "",
                      color: BaseColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    buildSizeHeight(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              value: productController.productDetailsData?.value
                                      .productData?.price ??
                                  "",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 4.0, horizontal: 9.0),
                        //   decoration: const BoxDecoration(
                        //     color: BaseColors.lightGrey,
                        //     borderRadius:
                        //         BorderRadius.all(Radius.circular(7.0)),
                        //   ),
                        //   child: const BaseText(
                        //     value: 'Portable water',
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w700,
                        //     color: BaseColors.grey1,
                        //   ),
                        // ),
                      ],
                    ),
                    buildSizeHeight(19),
                    HtmlWidget(
                      productController.productDetailsData?.value.productData
                              ?.description ??
                          "",
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: BaseColors.black),
                    ),
                    buildSizeHeight(27),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Row(
                                children: [
                                  BaseText(
                                    value: 'Quantity ',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  BaseText(
                                    value: '(In Litre)',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              buildSizeHeight(7.5),
                              BaseContainer(
                                bottomMargin: 0.0,
                                borderRadius: 0.0,
                                leftPadding: 0.0,
                                rightPadding: 0.0,
                                topPadding: 0.0,
                                bottomPadding: 0.0,
                                border: Border.all(
                                  color: BaseColors.lightSky,
                                  width: 1.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: BaseColors.lightSky),
                                        ),
                                        child: Center(
                                          child: BaseText(
                                            value:
                                                "${productController.productDetailsData?.value.productData?.quantity ?? ""}L",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        // DropdownButton<String>(
                                        //   value: dropdownValue,
                                        //   hint: const BaseText(
                                        //     value: 'Select Liter',
                                        //     color: BaseColors.black,
                                        //   ),
                                        //   onChanged: (String? value) {
                                        //     setState(() {
                                        //       dropdownValue = value!;
                                        //     });
                                        //   },
                                        //   underline: const SizedBox(),
                                        //   isExpanded: true,
                                        //   style: const TextStyle(
                                        //       color: Colors.black,
                                        //       fontWeight: FontWeight.bold),
                                        //   dropdownColor: Colors.white,
                                        //   icon: BaseContainer(
                                        //     bottomMargin: 0.0,
                                        //     topMargin: 0.0,
                                        //     rightMargin: 0.0,
                                        //     borderRadius: 0.0,
                                        //     leftPadding: 17.0,
                                        //     rightPadding: 17.0,
                                        //     topPadding: 18.0,
                                        //     bottomPadding: 18.0,
                                        //     width: 52,
                                        //     color: BaseColors.secondaryColor,
                                        //     child: SvgPicture.asset(
                                        //       BaseAssets.arrowDown,
                                        //     ),
                                        //   ),
                                        //   selectedItemBuilder:
                                        //       (BuildContext context) {
                                        //     return options.map((String value) {
                                        //       return Align(
                                        //         alignment: Alignment.centerLeft,
                                        //         child: BaseText(
                                        //           value: dropdownValue ?? '',
                                        //         ),
                                        //       );
                                        //     }).toList();
                                        //   },
                                        //   items: options
                                        //       .map<DropdownMenuItem<String>>(
                                        //           (String value) {
                                        //     return DropdownMenuItem<String>(
                                        //       value: value,
                                        //       child: Text(value,
                                        //           style: const TextStyle(
                                        //               fontSize: 15)),
                                        //     );
                                        //   }).toList(),
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildSizeWidth(32),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Row(
                                children: [
                                  BaseText(
                                    value: 'Units',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              buildSizeHeight(7.5),
                              BaseContainer(
                                bottomMargin: 0.0,
                                borderRadius: 0.0,
                                leftPadding: 7.0,
                                rightPadding: 7.0,
                                topPadding: 5.5,
                                bottomPadding: 5.5,
                                border: Border.all(
                                  color: BaseColors.lightSky,
                                  width: 1.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (initialUnit.value != 1) {
                                          initialUnit.value--;
                                        }
                                      },
                                      child: BaseContainer(
                                        bottomMargin: 0.0,
                                        topMargin: 0.0,
                                        rightMargin: 0.0,
                                        borderRadius: 0.0,
                                        leftPadding: 16.0,
                                        rightPadding: 16.0,
                                        topPadding: 11.0,
                                        bottomPadding: 11.0,
                                        width: 46,
                                        height: 36,
                                        color: BaseColors.secondaryColor,
                                        child: SvgPicture.asset(
                                          BaseAssets.minus,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ValueListenableBuilder(
                                          valueListenable: initialUnit,
                                          builder: (context, value, _) {
                                            return BaseText(
                                              textAlign: TextAlign.center,
                                              value: value.toString(),
                                            );
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        initialUnit.value++;
                                      },
                                      child: BaseContainer(
                                        bottomMargin: 0.0,
                                        topMargin: 0.0,
                                        rightMargin: 0.0,
                                        borderRadius: 0.0,
                                        leftPadding: 16.0,
                                        rightPadding: 16.0,
                                        topPadding: 11.0,
                                        bottomPadding: 11.0,
                                        width: 46,
                                        height: 36,
                                        color: BaseColors.secondaryColor,
                                        child: SvgPicture.asset(
                                          BaseAssets.plus,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    buildSizeHeight(34),
                    BaseButton(
                      borderRadius: 0.0,
                      title: '+ Add To Cart',
                      onPressed: () {
                        // controller.addItem(
                        //     item: 1, quantity: initialUnit.value);
                        productCtrl.addToCardApi(productController.productDetailsData?.value.productData?.productId ?? "",initialUnit.value, 601);
                        // Get.to(() => const CartScreen());
                      },
                    ),
                    buildSizeHeight(92),
                    BaseContainer(
                      leftMargin: 0.0,
                      rightMargin: 0.0,
                      bottomMargin: 10.0,
                      topMargin: 0.0,
                      leftPadding: 20.0,
                      rightPadding: 20.0,
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
                                  ValueListenableBuilder(
                                      valueListenable: initialUnit,
                                      builder: (context, value, _) {
                                        return BaseText(
                                          value:'${double.parse(productController.productDetailsData?.value
                                              .productData?.price ?? "0.0") * value}',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                          BaseButton(
                            btnWidth: 150,
                            btnHeight: 47,
                            title: 'Buy Now',
                            borderEnable: true,
                            borderColor: BaseColors.primaryColor,
                            btnTextColor: BaseColors.primaryColor,
                            borderRadius: 30.0,
                            onPressed: () {
                              // purchase_type 601=Cart, 602=Buy Now
                              productCtrl.addToCardApi(productController.productDetailsData?.value.productData?.productId ?? "",initialUnit.value, 602);
                            },
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(22),
                  ],
                ),
              ],
            );
            }),
        ),
      ),
    );
  }
}
