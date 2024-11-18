import 'package:flutter/material.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final double? btnHeight, btnWidth;
  final double? borderRadius, fontSize;
  final double? bottomMargin, topMargin, rightMargin, leftMargin;
  final EdgeInsetsGeometry? padding;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  final bool? enableHapticFeedback, hideKeyboard, borderEnable;
  final void Function()? onPressed;

  const BaseButton({
    super.key,
    required this.title,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.onPressed,
    this.bottomMargin,
    this.topMargin,
    this.rightMargin,
    this.leftMargin,
    this.enableHapticFeedback,
    this.hideKeyboard,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.btnTextColor,
    this.borderEnable = false,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: rightMargin ?? 0,
          left: leftMargin ?? 0,
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(btnWidth ?? double.infinity, btnHeight ?? 55),
          backgroundColor: !borderEnable! ? btnColor ?? BaseColors.primaryColor : btnColor,
          foregroundColor: btnColor ?? BaseColors.primaryColor,
          disabledBackgroundColor: btnColor ?? BaseColors.primaryColor,
          disabledForegroundColor: btnColor ?? BaseColors.primaryColor,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            side: borderEnable! ? BorderSide(color: borderColor ?? BaseColors.white,width: 1.0) : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        onPressed: () {
          if (enableHapticFeedback ?? true) {
            triggerHapticFeedback();
          }
          if (hideKeyboard ?? true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: AbsorbPointer(
          child: BaseText(
            value: title,
            color: btnTextColor ?? Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: fontSize ?? 16,
          ),
        ),
      ),
    );
  }
}
