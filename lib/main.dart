import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:water_on_demand/helper/firebase_service.dart';
import 'package:water_on_demand/ui/onboardings/splash/splash_screen.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import 'package:water_on_demand/utils/base_localization.dart';
import 'package:water_on_demand/utils/base_main_builder.dart';

void main() async{
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runAppScaled(const MyApp(), scaleFactor: (deviceSize){
    const double widthOfDesign = 375;
    return deviceSize.width / widthOfDesign;
  });

  // WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDuyufzwPkmriya8vNRDV4ESvuYMG2b_gM',
            appId: "1:368667416352:android:7a88085f01436c7fd06945",
            messagingSenderId: "368667416352",
            projectId: "focus-invention-426913-n6")
    );
  } else {
    await Firebase.initializeApp();
  }

  requestNotificationPermissions();
  getFcmToken();
  initMessaging();

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp)async{
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitUp,
      ]);
      await GetStorage.init('MyStorage');
    });
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus!.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Water On Demand',
        debugShowCheckedModeBanner: false,
        translations: BaseLocalization(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        builder: (BuildContext context, Widget? child) {
          return BaseMainBuilder(context: context, child: child);
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.primaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.transparent,
          fontFamily: 'Inter'
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
