import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/driver_screen/vehicle_info_screen/vehicle_info_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../utils/base_colors.dart';
import '../base_components/base_button.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:false,
      child: BaseScaffoldBackground(
        child: Scaffold(
          body: AnimatedColumn(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  BaseAssets.checkImage,
                ),
              ),
               buildSizeHeight(20),
               const BaseText(
                value: 'Request Sent To Admin',
                color: BaseColors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              buildSizeHeight(20),
              const BaseText(
                value: 'Your admin has been notified of your\nrequest to access this app. Once your\nadmin reviews the request you will be\nnotified via email.',
                color: BaseColors.black,
                textAlign: TextAlign.center,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              buildSizeHeight(30),
              BaseButton(
                borderRadius: double.nan,
                title: 'OK',
                onPressed: () {
                  Get.to(const VehicleInfoScreen());
                },
              ),
            ],

          ),
        ),
      ),
    );
  }
}
