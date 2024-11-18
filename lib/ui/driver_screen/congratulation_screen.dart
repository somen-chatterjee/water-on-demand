import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/driver_screen/personal_info/personal_info_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../utils/base_colors.dart';
import '../base_components/animated_column.dart';
import '../base_components/base_button.dart';
import '../base_components/base_scaffold_background.dart';
import '../base_components/base_text.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
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
             value: 'Congratulations!',
             color: BaseColors.black,
             fontSize: 24,
             fontWeight: FontWeight.w700,
           ),
           buildSizeHeight(10),
           const BaseText(
             textAlign: TextAlign.center,
             value: 'Your account has been created successfully.',
             color: BaseColors.black,
             fontSize: 17,
             fontWeight: FontWeight.w300,
           ),
           buildSizeHeight(40),
           BaseButton(
             borderRadius: double.nan,
             title: 'Complete KYC',
             onPressed: () {
               Get.to(const CompleteKycScreen());
             },
           ),
         ],
       ),

      ),
    );
  }
}
