import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final double? width, height;
  final double? borderRadius;
  final double? topMargin, bottomMargin, rightMargin, leftMargin;
  final Widget? child;
  const BaseShimmer(
      {super.key,
        this.width,
        this.height,
        this.borderRadius,
        this.topMargin,
        this.bottomMargin,
        this.rightMargin,
        this.leftMargin,
        this.child,
      });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: child ?? Container(
          margin: EdgeInsets.only(
              top: topMargin ?? 0,
              bottom: bottomMargin ?? 0,
              right: rightMargin ?? 0,
              left: leftMargin ?? 0),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;

  const LoadingContainer({super.key, required this.width, required this.height, this.radius,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(radius??10)),
    );
  }
}

