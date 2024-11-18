import 'package:flutter/material.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class ProductList extends StatelessWidget {
  final String productImg;
  final String title;
  final String price;

  const ProductList(
      {super.key,
      required this.productImg,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: cachedNetworkImage(
              image: productImg,
              width: 144,
              height: 152,
              fit: BoxFit.fill,
            ),
          ),
          BaseText(
            value: title,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          Row(
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
                value: price,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
