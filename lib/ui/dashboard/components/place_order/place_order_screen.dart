import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_container.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/base_components/base_text.dart';
import 'package:water_on_demand/ui/base_components/base_textfield.dart';
import 'package:water_on_demand/ui/checkout/check_out_screen.dart';
import 'package:water_on_demand/utils/base_assets.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_functions.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        bottomNavigationBar: BaseContainer(
          leftMargin: 10.0,
          rightMargin: 10.0,
          bottomMargin: 10.0,
          topMargin: 0.0,
          leftPadding: 20.0,
          rightPadding: 20.0,
          height: 90,
          boxShadow: const BoxShadow(
            color: BaseColors.lightSky,
            blurRadius: 50,
            spreadRadius: 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BaseText(
                    value: 'Total Price',
                    fontSize: 14,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSizeHeight(5.0),
                      const BaseText(
                        value: 'R',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: BaseColors.secondaryColor,
                      ),
                      const BaseText(
                        value: '200.00',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              BaseButton(
                btnWidth: 150,
                btnHeight: 47,
                title: 'Continue',
                borderEnable: true,
                borderColor: BaseColors.primaryColor,
                btnTextColor: BaseColors.primaryColor,
                borderRadius: 30.0,
                onPressed: () {
                  Get.to(() => const CheckOutScreen(purchaseType: 602,));
                },
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedColumn(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(26),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    BaseAssets.backArrow,
                    width: 19,
                    height: 20,
                  ),
                ),
                buildSizeHeight(48),
                const BaseText(
                  value: 'Place Order',
                  color: BaseColors.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(19),
                const BaseText(
                  value:
                  'Please fill in your details to place\nyour order.',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                buildSizeHeight(33),
                const BaseText(
                  value: 'Select Type of Water',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                buildSizeHeight(7.5),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectIndex(0);
                        },
                        child: BaseContainer(
                          bottomMargin: 0.0,
                          borderRadius: 0.0,
                          leftPadding: 0.0,
                          rightPadding: 0.0,
                          topPadding: 0.0,
                          bottomPadding: 0.0,
                          height: 46,
                          boxShadow: const BoxShadow(
                            color: BaseColors.lightSky,
                            spreadRadius: 1.0,
                            blurRadius: 2.0,
                          ),
                          border: Border.all(
                            color: selectedIndex == 0
                                ? BaseColors.secondaryColor
                                : BaseColors.lightSky,
                            width: 1.0,
                          ),
                          child: Center(
                            child: BaseText(
                              textAlign: TextAlign.center,
                              value: 'Portable Water',
                              color: selectedIndex == 0
                                  ? BaseColors.secondaryColor
                                  : BaseColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildSizeWidth(20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectIndex(1);
                        },
                        child: BaseContainer(
                          bottomMargin: 0.0,
                          borderRadius: 0.0,
                          leftPadding: 0.0,
                          rightPadding: 0.0,
                          topPadding: 0.0,
                          bottomPadding: 0.0,
                          height: 46,
                          boxShadow: const BoxShadow(
                            color: BaseColors.lightSky,
                            spreadRadius: 1.0,
                            blurRadius: 2.0,
                          ),
                          border: Border.all(
                            color: selectedIndex == 1
                                ? BaseColors.secondaryColor
                                : BaseColors.lightSky,
                            width: 1.0,
                          ),
                          child: Center(
                            child: BaseText(
                              textAlign: TextAlign.center,
                              value: 'Drinking Water',
                              color: selectedIndex == 1
                                  ? BaseColors.secondaryColor
                                  : BaseColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                buildSizeHeight(30.5),
                const Row(
                  children: [
                    BaseText(
                      value: 'Quantity ',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    BaseText(
                      value: '(In Litre)',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                buildSizeHeight(7.5),
                BaseTextField(
                  controller: TextEditingController(text: '50'),
                  labelText: '',
                  hintText: 'Enter Quantity',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.lightSky,
                  textInputType: TextInputType.number,
                  borderRadius: 0.0,
                  contentPadding: const EdgeInsets.all(12.0),
                ),
                buildSizeHeight(25.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
