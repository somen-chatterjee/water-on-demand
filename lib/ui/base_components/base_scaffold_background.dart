import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:water_on_demand/utils/base_colors.dart';

class BaseScaffoldBackground extends StatelessWidget {
  final Widget child;

  const BaseScaffoldBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 20,
            child: shapes(
              height: 80,
              width: 80,
              shape: BoxShape.circle,
              opacity: 0.8,
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: shapes(
              height: 80,
              width: 80,
              shape: BoxShape.circle,
              opacity: 0.8,
            ),
          ),
          Positioned(
            bottom: 150,
            left: -10,
            child: shapes(
              height: 220,
              width: 100,
              shape: BoxShape.rectangle,
              angle: 0.50,
              opacity: 0.8,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 80,
            child: shapes(
              height: 150,
              width: 100,
              shape: BoxShape.rectangle,
              angle: 0.50,

            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget shapes({
    required double width,
    required double height,
    BoxShape shape = BoxShape.circle,
    double angle = 0.0,
    double opacity = 1.0,
  }) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: BaseColors.scaffoldColor
              .withOpacity(opacity > 1.0 ? 1.0 : opacity),
          shape: shape,
        ),
      ),
    );
  }
}
