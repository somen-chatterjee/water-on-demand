import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_on_demand/backend/api_end_points.dart';
import 'package:water_on_demand/common_data_model/social_response_model.dart';
import 'package:water_on_demand/ui/dashboard/dashboard_screen.dart';
import 'package:water_on_demand/ui/driver_screen/driver_dasboard.dart';
import 'package:water_on_demand/utils/check_role_id.dart';
import 'package:water_on_demand/utils/get_storage.dart';
import 'package:water_on_demand/utils/storage_keys.dart';

import '../backend/base_api_service.dart';
import '../backend/base_success_response.dart';
import '../ui/dashboard/controller/dashboard_controller.dart';
import '../utils/base_functions.dart';

class CommonController extends GetxController{

  saveOnlineStatus(int status) {
    Map<String, dynamic> data = {
      "is_online":status,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().saveOnlineStatus, data: data)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.find<DashboardController>().getUserDetails();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
          update();
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    showBaseLoader(showLoader: true);

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      log("samprint $gUser");
      if (gUser == null) {
        // if(context.mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text("Something Went Wrong!!")));
        // }
        // return null;

        dismissBaseLoader();
      }
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      var result = await FirebaseAuth.instance.signInWithCredential(credential);

      log("samprint ${result}");

      if (context.mounted) {
        dismissBaseLoader();
      }
      return result.user;

      // socialLogin(
      //   type: "google",
      //   name: result.user?.displayName ?? "",
      //   email: result.user?.email ?? "",
      //   socialId: result.credential?.accessToken,
      // );
    } catch (e) {
      //BaseOverlays().showSnackBar(message: "${e}");
      // if(context.mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text("Something Went Wrong!!")));
      // }
      if (context.mounted) {
        dismissBaseLoader();
      }
      return null;
    }
  }

  socialLogin({required bool isDriver, required Map<String,dynamic> data}) async {
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().socialLoginAccount, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          SocialResponseModel response = SocialResponseModel.fromJson(value?.data);
          if (response.status ?? false) {

            // set token
            BaseStorage.write(
              StorageKeys.apiToken,
              response.data?.accessToken ?? "",
            );
            // set userId
            BaseStorage.write(
              StorageKeys.userId,
              response.data?.profileData?.userId ?? "",
            );
            // set roleId
            BaseStorage.write(
              StorageKeys.roleId,
              response.data?.profileData?.roleId ?? "",
            );
            // set name
            BaseStorage.write(
              StorageKeys.fullName,
              response.data?.profileData?.fullName ?? "",
            );
            // set email
            BaseStorage.write(
              StorageKeys.emailId,
              response.data?.profileData?.emailAddress ?? "",
            );
            // set number
            BaseStorage.write(
              StorageKeys.phoneNumber,
              response.data?.profileData?.mobileNumber ?? "",
            );

            if(response.data?.profileData?.roleId == CheckRoleId().customer) {
              Get.offAll(() => const DashboardScreen());
            } else {
              Get.offAll(() => const DriverDashboardScreen());
            }
            showSnackBar(isSuccess: true, subtitle: response.message ?? "");

          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  Future<Map<String, dynamic>?> facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      // _accessToken = result.accessToken;
      // _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      // _userData = userData;
      return userData;
    } else {
      print(result.status);
      print(result.message);
    }

    // setState(() {
    //   _checking = false;
    // });
    return null;
  }

}

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class FacebookLoginCheck extends StatefulWidget {
  const FacebookLoginCheck({super.key});

  @override
  State<FacebookLoginCheck> createState() => _FacebookLoginCheckState();
}

class _FacebookLoginCheckState extends State<FacebookLoginCheck> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
  }

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }


  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Facebook Auth Example'),
        ),
        body: _checking
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _userData != null ? prettyPrint(_userData!) : "NO LOGGED",
                ),
                const SizedBox(height: 20),
                _accessToken != null
                    ? Text(
                  prettyPrint(_accessToken!.toJson()),
                )
                    : Container(),
                const SizedBox(height: 20),
                ElevatedButton(
                  // color: Colors.blue,
                  child: Text(
                    _userData != null ? "LOGOUT" : "LOGIN",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: _userData != null ? _logOut : _login,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}