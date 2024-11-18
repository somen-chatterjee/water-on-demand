import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';
import 'package:water_on_demand/utils/base_variables.dart';

class ProductDetailLoading extends StatelessWidget {
  const ProductDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      leftPadding: 0.0,
      rightPadding: 0.0,
      children: [
        Stack(
          children: [
            const BaseShimmer(
              height: 300,
              width: double.infinity,
              borderRadius: 0.0,
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
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horizontalScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSizeHeight(24),
              const BaseShimmer(
                width: 150,
                height: 25,
              ),
              buildSizeHeight(14),
              const BaseShimmer(
                width: 80,
                height: 25,
              ),
              buildSizeHeight(19),
              const BaseShimmer(
                width: double.maxFinite,
                height: 18,
                borderRadius: 5.0,
              ),
              buildSizeHeight(5),
              const BaseShimmer(
                width: double.maxFinite,
                height: 18,
                borderRadius: 5.0,
              ),
              buildSizeHeight(5),
              const BaseShimmer(
                width: double.maxFinite,
                height: 18,
                borderRadius: 5.0,
              ),
              buildSizeHeight(5),
              const BaseShimmer(
                width: double.maxFinite,
                height: 18,
                borderRadius: 5.0,
              ),
              buildSizeHeight(27),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BaseShimmer(
                          width: double.maxFinite,
                          height: 25,
                          borderRadius: 5.0,
                        ),
                        buildSizeHeight(7.5),
                        BaseShimmer(
                          child: BaseContainer(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0,
                                          color: BaseColors.lightSky),
                                    ),
                                    child: const Center(
                                      child: BaseText(
                                        value: "5L",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                            BaseShimmer(
                              width: 100,
                              height: 25,
                              borderRadius: 5.0,
                            ),
                          ],
                        ),
                        buildSizeHeight(7.5),
                        BaseShimmer(
                          child: BaseContainer(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BaseContainer(
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
                                const Expanded(
                                  child: BaseText(
                                    textAlign: TextAlign.center,
                                    value: "5",
                                  ),
                                ),
                                BaseContainer(
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              buildSizeHeight(34),
              const BaseShimmer(
                child: BaseButton(
                  borderRadius: 0.0,
                  title: '+ Add To Cart',
                ),
              ),
              buildSizeHeight(72),
              const BaseShimmer(
                width: double.maxFinite,
                height: 90,
                borderRadius: 25,
              ),
              buildSizeHeight(22),
            ],
          ),
        ),
      ],
    );
  }
}
