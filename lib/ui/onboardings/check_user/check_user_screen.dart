import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/onboardings/create_account/create_account.dart';
import 'package:water_on_demand/ui/onboardings/login/login_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:water_on_demand/utils/base_variables.dart';

class CheckUserScreen extends StatelessWidget {
  final bool isLogin;

  const CheckUserScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildSizeHeight(26),
                Align(
                  alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      BaseAssets.backArrow,
                      width: 19,
                      height: 20,
                    ),
                  ),
                ),
                buildSizeHeight(62),
                BaseText(
                  value: isLogin ? 'Login' : 'Sign Up',
                  color: BaseColors.black,
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(16),
                const Align(
                  alignment: Alignment.center,
                  child: BaseText(
                    value: 'Choose here which type\nof user you are',
                    color: BaseColors.black,
                    textAlign: TextAlign.center,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                buildSizeHeight(19),
                selectUser(
                    backgroundImg: BaseAssets.typeUser,
                    btnText: 'User',
                    onPressed: () {
                      checkUser(type: 1);
                    }),
                buildSizeHeight(20),
                selectUser(
                    backgroundImg: BaseAssets.typeDriver,
                    btnText: 'Driver',
                    onPressed: () {
                      checkUser(type: 2);
                    }),
                buildSizeHeight(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectUser({
    required String btnText,
    required String backgroundImg,
    Function()? onPressed,
  }) {
    return SizedBox(
      height: 233,
      width: 317,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            width: double.maxFinite,
            height: double.maxFinite,
            backgroundImg,
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: gradient,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 19.0,
                horizontal: 20.0,
              ),
              child: BaseButton(
                title: btnText,
                borderEnable: true,
                borderRadius: 0.0,
                borderColor: BaseColors.white,
                btnColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          ),
          // BaseButton(title: 'User')
        ],
      ),
    );
  }

  void checkUser({required int type}) {
    // 1 --> user
    // 2 --> driver

    if (isLogin) {
      Get.to(() => LoginScreen(isDriver: type == 2));
    } else {
      Get.to(() => CreateAccount(isDriver: type == 2));
    }
  }
}
