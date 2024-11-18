import 'package:flutter/material.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';
import 'package:water_on_demand/utils/base_variables.dart';

class ProfileScreenLoading extends StatelessWidget {
  const ProfileScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding),
      child: Column(
        children: [
          buildSizeHeight(35),
          Column(
            children: [
              const ClipOval(
                // radius: 50,
                child: BaseShimmer(
                  height: 110,
                  width: 110,
                  borderRadius: 150,
                ),
              ),
              buildSizeHeight(10),
              const BaseShimmer(
                height: 25,
                width: 110,
              ),
            ],
          ),
          buildSizeHeight(10),
          BaseShimmer(
            child: Container(
              color: BaseColors.secondaryColor.withOpacity(0.5),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseShimmer(
                      height: 25,
                      width: 25,
                    ),
                    AnimatedColumn(
                      leftPadding: 12.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const BaseShimmer(
                          height: 20,
                          width: 120,
                        ),
                        buildSizeHeight(5),
                        const BaseShimmer(
                          height: 25,
                          width: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildSizeHeight(20),
          BaseShimmer(
            child: Container(
              color: BaseColors.secondaryColor.withOpacity(0.5),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseShimmer(
                      height: 25,
                      width: 25,
                    ),
                    AnimatedColumn(
                      leftPadding: 12.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const BaseShimmer(
                          height: 20,
                          width: 120,
                        ),
                        buildSizeHeight(5),
                        const BaseShimmer(
                          height: 25,
                          width: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildSizeHeight(20),
          const BaseShimmer(
            child: BaseButton(
              borderRadius: double.nan,
              title: 'Edit Profile',
            ),
          ),
          buildSizeHeight(20),
          Row(
            children: [
              const Expanded(
                child: BaseShimmer(
                  child: BaseButton(
                    borderRadius: 0.0,
                    borderColor: BaseColors.primaryColor,
                    btnColor: BaseColors.white,
                    borderEnable: true,
                    title: 'Log Out',
                    btnTextColor: BaseColors.primaryColor,
                  ),
                ),
              ),
              buildSizeWidth(20),
              const Expanded(
                child: BaseShimmer(
                  child: BaseButton(
                    btnWidth: 150,
                    borderRadius: double.nan,
                    title: 'Address',
                  ),
                ),
              ),
            ],
          ),
          buildSizeHeight(150),
        ],
      ),
    );
  }
}
