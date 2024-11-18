import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/driver_screen/driver_dasboard.dart';
import 'package:water_on_demand/utils/base_colors.dart';

import '../../utils/base_assets.dart';
import '../../utils/base_functions.dart';
import '../base_components/animated_column.dart';
import '../base_components/base_button.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: AnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Padding(
              padding: const EdgeInsets.only(left: 70,bottom: 30),
              child: Image.asset(BaseAssets.congratulationImg,height: 149,width: 182,),
            )),
            const BaseText(
              value: 'Completed',
              color: BaseColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            buildSizeHeight(10),
            const BaseText(
              textAlign: TextAlign.center,
              value: 'Your water delivery has been successfully delivered.',
              color: BaseColors.black,
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
            buildSizeHeight(40),
            BaseButton(
              borderRadius: double.nan,
              title: 'My Jobs',
              onPressed: () {
                Get.offAll(const DriverDashboardScreen(bodyIndex: 1,));
              },
            ),
          ],
        ),

      ),
    );
  }
}
