import 'package:flutter/material.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_shimmer.dart';

class ProductScreenLoading extends StatelessWidget {

  const ProductScreenLoading(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        primary: false,
        itemCount: 10,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 22.0,
          childAspectRatio: 0.8,
          // mainAxisSpacing: 22.0,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
        return Align(
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BaseShimmer(
                width: 144,
                height: 152,
              ),
              buildSizeHeight(5.0),
              const BaseShimmer(
                width: 100,
                height: 15,
              ),
              buildSizeHeight(5.0),
              const BaseShimmer(
                width: 60,
                height: 15,
              ),
            ],
          ),
        );
      }
    );
  }
}
