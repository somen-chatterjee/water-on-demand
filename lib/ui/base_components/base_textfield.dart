import 'package:water_on_demand/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final double? topMargin, bottomMargin, rightMargin, leftMargin;
  final String hintText, labelText;
  final bool? filled;
  final Color? fillColor;
  final Color? txtColor;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final String? errorText, initialValue;
  final int? maxLine;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? underLine;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final double? borderRadius;
  final Color? borderColor;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final bool? readOnly;
  final double? hintTxtSize;
  final String? Function(String?)? validator;
  final Color? hintTextColor;
  final bool? autofocus;

  const BaseTextField({
    super.key,
    this.controller,
    this.obscureText,
    required this.labelText,
    required this.hintText,
    this.textInputAction,
    this.textInputType,
    this.textInputFormatter,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.borderRadius,
    this.filled,
    this.fillColor,
    this.txtColor,
    this.borderColor,
    this.maxLine,
    this.contentPadding,
    this.hintTxtSize,
    this.onTap,
    this.readOnly,
    this.hintTextColor,
    this.autofocus,
    this.textCapitalization,
    this.validator,
    this.maxLength,
    this.underLine = false,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    this.topMargin,
    this.bottomMargin,
    this.rightMargin,
    this.leftMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topMargin ?? 0,
        bottom: bottomMargin ?? 0,
        right: rightMargin ?? 0,
        left: leftMargin ?? 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: labelText.isNotEmpty,
            child: BaseText(
              value: labelText,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          Visibility(
            visible: labelText.isNotEmpty,
            child: const SizedBox(height: 3),
          ),
          TextFormField(
            controller: controller ?? TextEditingController(),
            obscureText: obscureText ?? false,
            obscuringCharacter: "*",
            maxLines: maxLine ?? 1,
            onTap: onTap,
            focusNode: focusNode,
            readOnly: readOnly ?? false,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: textInputType,
            inputFormatters: textInputFormatter,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            autofocus: autofocus??false ,
            validator: validator,
            onChanged: onChanged,
            cursorColor: BaseColors.secondaryColor,
            maxLength: maxLength ?? 200,
            style: TextStyle(color: txtColor ?? Colors.black, fontSize: 15),
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  EdgeInsets.only(
                    top: 6,
                    bottom: 6,
                    left: prefixIcon != null ? 10 : 0,
                    right: 10.0,
                  ),
              isDense: true,
              hintMaxLines: 1,
              hintText: hintText.tr,
              errorText: errorText,
              counter: const SizedBox.shrink(),
              counterStyle:
                  const TextStyle(fontSize: 0, color: Colors.transparent),
              counterText: "",
              semanticCounterText: "",
              suffixIconConstraints: const BoxConstraints(maxHeight: 45),
              prefixIconConstraints: const BoxConstraints(maxHeight: 45),
              hintStyle: TextStyle(
                color: hintTextColor ?? Colors.black,
                fontSize: hintTxtSize ?? 14,
              ),
              filled: filled ?? false,
              fillColor: fillColor ?? Colors.transparent,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffC2C2C2), width: 1.0),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffC2C2C2), width: 1.0),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffC2C2C2), width: 1.0),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffC2C2C2), width: 1.0),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.0),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffC2C2C2), width: 1.0),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
