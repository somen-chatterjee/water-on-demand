import 'package:water_on_demand/utils/base_colors.dart';
import 'package:flutter/material.dart';

import 'package:water_on_demand/ui/base_components/base_text.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final bool? isSelected;
  final Function() onTap;

  const CustomRadioButton(
      {super.key, required this.title, this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        margin: const EdgeInsets.only(right: 15, bottom: 15),
        decoration: BoxDecoration(
          color:
              (isSelected ?? false) ? BaseColors.white : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(
            width: 1.0,
            color:
                (isSelected ?? false) ? BaseColors.secondaryColor : BaseColors.lightSky,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ?? false)
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: BaseText(
          value: title,
          fontSize: 14,
          color: (isSelected ?? false) ? BaseColors.secondaryColor : BaseColors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
