import 'dart:math';
import 'package:flutter/material.dart';

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final int shakeCount;
  final double shakeOffset;
  final Duration shakeDuration;

  const ShakeWidget({
    super.key,
    required this.child,
    this.shakeCount = 3,
    this.shakeOffset = 10.0,
    this.shakeDuration = const Duration(milliseconds: 400),
  });

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
     _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animationController.addStatusListener(_updateAnimationStatus);
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_updateAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }

  void _updateAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.reset();
    }
  }

  void shake() {
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        final double sineValue = sin(widget.shakeCount * 2 * pi * _animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}
