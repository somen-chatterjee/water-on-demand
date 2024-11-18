import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';
import 'package:water_on_demand/ui/onboardings/boarding/boarding_screen.dart';
import 'package:water_on_demand/ui/onboardings/intro/components/intro_widget.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/ui/onboardings/intro/components/helpers.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const routeName = '/boardingScreen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController pageController = PageController();

  int _activePage = 0;

//Indicator Builder
  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < boardingPages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

// Changes colors based on screen
  Widget _indicatorsTrue() {
    //Active Indicator
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 6,
      width: 23,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: BaseColors.primaryColor,
      ),
    );
  }

//Inactive Indicator
  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 6,
      width: 23,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: BaseColors.lightBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 560,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: boardingPages.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _activePage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return IntroWidget(
                        title: boardingPages[index]['title'],
                        description: boardingPages[index]['description'],
                        image: boardingPages[index]['image'],
                      );
                    }),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
              ),
            ],
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
          child: BaseButton(
            title: _activePage != 2 ? 'Next' : 'Get started',
            onPressed: () {
              if (_activePage != 2) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              } else {
                Get.offAll(() => const BoardingScreen());
              }
            },
          ),
        ),
      ),
    );
  }
}
