import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      leftPadding: 0.0,
      rightPadding: 0.0,
      children: [
        buildSizeHeight(30),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(42.0),
            topRight: Radius.circular(42.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          child: Image.asset(
            image,
            height: 284,
            width: 303,
            fit: BoxFit.fitHeight,
          ),
        ),
        buildSizeHeight(45),
        BaseText(
          value: title,
          textAlign: TextAlign.center,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        buildSizeHeight(16),
        BaseText(
          value: description,
          textAlign: TextAlign.center,
          height: 1.8,
          fontSize: 17,
        )
      ],
    );
  }
}