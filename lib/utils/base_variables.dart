import 'package:flutter/material.dart';
import 'base_colors.dart';

const double horizontalScreenPadding = 25;
const double baseContainerRadius = 28;
const int apiTimeOut = 30;


LinearGradient gradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomRight,
  colors: [
    BaseColors.gradient2.withOpacity(0.0),
    BaseColors.gradient2.withOpacity(0.3),
    BaseColors.gradient2.withOpacity(0.5),
    BaseColors.gradient2,
  ],
);