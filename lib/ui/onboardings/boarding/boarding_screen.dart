import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/onboardings/check_user/check_user_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_variables.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            BaseAssets.onboardingBg,
            fit: BoxFit.cover,
          ),
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(gradient: gradient),
            child: AnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const BaseText(
                  value: 'Welcome to Water',
                  fontSize: 31,
                  color: BaseColors.white,
                  fontWeight: FontWeight.w600,
                ),
                buildSizeHeight(12),
                const BaseText(
                  value: 'Water on demand app',
                  fontSize: 18,
                  color: BaseColors.white,
                  fontWeight: FontWeight.w400,
                ),
                buildSizeHeight(46),
                BaseButton(
                  title: 'Create an Account',
                  btnColor: BaseColors.white,
                  btnTextColor: BaseColors.primaryColor,
                  onPressed: () {
                    Get.to(() => const CheckUserScreen(isLogin: false));
                  },
                ),
                buildSizeHeight(25),
                BaseButton(
                  title: 'Login',
                  borderEnable: true,
                  borderColor: BaseColors.white,
                  btnColor: Colors.transparent,
                  onPressed: () {
                    Get.to(() => const CheckUserScreen(isLogin: true));
                  },
                ),
                buildSizeHeight(70),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
