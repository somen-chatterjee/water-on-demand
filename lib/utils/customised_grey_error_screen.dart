import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';

import '../ui/base_components/animated_column.dart';
import '../ui/base_components/base_scaffold_background.dart';

class CustomisedGreyErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const CustomisedGreyErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: Center(
          child: AnimatedColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseText(
                value: kDebugMode
                    ? errorDetails.summary.toString()
                    : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              )
            ],
          ),
        ),
      ),
    );
  }
}
