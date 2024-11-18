import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:water_on_demand/utils/base_assets.dart';

import '../ui/base_components/base_text.dart';


class BaseNoData extends StatelessWidget {
  final String? message;
  final Color? textColor;
  const BaseNoData({super.key, this.message, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
            height: 100,
              child: OverflowBox(
                minHeight: 300,
                maxHeight: 300,
                minWidth: 300,
                maxWidth: 300,
                  child: Lottie.asset(
                      BaseAssets.noDataLottieJson,
                    height: 200,
                    width: 200
                  ),
              ),
          ),
          BaseText(
            value: message??"No Data Found!",
            fontSize: 16,
            color: textColor??Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
