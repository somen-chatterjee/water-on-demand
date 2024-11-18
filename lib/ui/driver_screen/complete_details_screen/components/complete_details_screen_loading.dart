import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

class CompleteDetailScreenLoading extends StatelessWidget {
  const CompleteDetailScreenLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSizeHeight(20),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              BaseAssets.backArrow,
              width: 19,
              height: 20,
            ),
          ),
          buildSizeHeight(20),
          const BaseShimmer(
            width: 80,
            height: 30,
          ),
          buildSizeHeight(10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BaseShimmer(
                    width: 10,
                    height: 22,
                  ),
                  buildSizeWidth(5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseShimmer(
                        width: 100,
                        height: 22,
                        borderRadius: 5,
                      ),
                      buildSizeHeight(12),
                      const BaseShimmer(
                        width: 80,
                        height: 20,
                        borderRadius: 5,
                      ),
                      buildSizeHeight(5),
                      const BaseShimmer(
                        width: 140,
                        height: 15,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(
                  // horizontal: 10.0,
                  vertical: 16.0,
                ),
                child: BaseShimmer(
                  width: double.infinity,
                  height: 1,
                  borderRadius: 0,
                ),
              );
            },
          ),
          buildSizeHeight(10),
          const BaseShimmer(
            width: double.infinity,
            height: 1,
            borderRadius: 0,
          ),
          buildSizeHeight(10),
          const BaseShimmer(
            width: 60,
            height: 15,
            borderRadius: 5,
          ),
          buildSizeHeight(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BaseShimmer(
                width: 80,
                height: 15,
                borderRadius: 5,
              ),
              Row(
                children: [
                  const BaseShimmer(
                    width: 15,
                    height: 15,
                  ),
                  buildSizeWidth(5),
                  const BaseShimmer(
                    width: 120,
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
          buildSizeHeight(20),
          const BaseShimmer(
            width: double.infinity,
            height: 100,
          ),
          buildSizeHeight(20),
          const BaseShimmer(
            width: double.infinity,
            height: 45,
          ),
          buildSizeHeight(20),
          const BaseShimmer(
            child: BaseButton(
              borderRadius: 10,
              title: 'Payment Detail',
            ),
          ),
          buildSizeHeight(20),
          const Center(
            child: BaseShimmer(
              width: 140,
              height: 17,
              borderRadius: 5,
            ),
          ),
          buildSizeHeight(20),
        ],
      ),
    );
  }
}
