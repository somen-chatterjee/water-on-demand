import 'package:flutter/material.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

class HomeScreenLoading extends StatelessWidget {
  const HomeScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: BaseShimmer(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        buildSizeHeight(120),
                        const Card(
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 200,
                          ),
                        )
                      ],
                    ),
                    buildSizeHeight(18),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BaseShimmer(
                                width: 144,
                                height: 152,
                                rightMargin: 5,
                              ),
                              buildSizeHeight(5),
                              const BaseShimmer(width: 30, height: 20),
                              buildSizeHeight(5),
                              const BaseShimmer(width: 60, height: 20)
                            ],
                          );
                        },
                      ),
                    ),
                    buildSizeHeight(30),
                  ],
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Image.asset(
                BaseAssets.appBarBg1,
                width: double.maxFinite,
                height: 128,
                fit: BoxFit.fitWidth,
              ),
              BaseShimmer(
                child: Column(
                  children: [
                    buildSizeHeight(20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseShimmer(width: 100, height: 20),
                                buildSizeHeight(5),
                                const BaseShimmer(width: 150, height: 20)
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const BaseShimmer(
                                width: 50,
                                height: 50,
                              ),
                              buildSizeWidth(5),
                              const BaseShimmer(
                                width: 50,
                                height: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
