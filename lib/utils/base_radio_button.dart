import 'package:flutter/material.dart';

import '../ui/base_components/base_text.dart';
import 'base_colors.dart';
import 'base_functions.dart';

class BaseRadioButton extends StatelessWidget {
  final String value, selectedValue;
  final void Function() onTap;
  final Color? btnTextColor;
  const BaseRadioButton({super.key, required this.value, required this.selectedValue, required this.onTap, this.btnTextColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        triggerHapticFeedback();
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 19,
            height: 19,
            child: Radio<String>(
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: value,
              activeColor: BaseColors.secondaryColor,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  return BaseColors.secondaryColor;
                },
              ),
              groupValue: selectedValue,
              onChanged: null
            ),
          ),
          BaseText(
            leftMargin: 12,
            value: value,
            fontSize: 14,
            color: btnTextColor ?? Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
