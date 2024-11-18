import 'dart:developer';
import 'package:water_on_demand/ui/order_success/order_success_screen.dart';
import 'package:water_on_demand/utils/base_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_on_demand/ui/base_components/base_scaffold_background.dart';

class WebViewStack extends StatefulWidget {
  final String url;
  final String orderId;
  final String orderItemId;
  final int purchaseType;
  const WebViewStack({super.key, required this.url, required this.orderId, required this.purchaseType, required this.orderItemId, });

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  @override
  Widget build(BuildContext context) {
    // log("hit url ----> ${widget.url}");
    showBaseLoader();

    return BaseScaffoldBackground(
        child: SafeArea(
          child: WillPopScope(
            // canPop: false,
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: Stack(
                children: [
                  WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(Colors.white)
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onProgress: (int progress) {
                            // Update loading bar.
                            if(progress < 100){
                              showBaseLoader();
                            }else{
                              dismissBaseLoader();
                            }
                          },
                          onPageFinished: (String url) {
                            // https://www.waterondemand.co.za/order/paymentStatus?payment=success&pay_from=app
                            // https://www.waterondemand.co.za/order/paymentStatus?payment=cancel&pay_from=app
                            log("onPageFinished url ----->  $url");


                            if(url.contains("paymentStatus")) {
                              final settingsUri = Uri.parse(url);

                              var type = settingsUri.queryParameters['payment'];
                              // final checkoutValue = settingsUri.queryParameters['checkout'];


                              if (url.contains("paymentStatus") &&
                                  type == 'success') {
                                // _showCongrulationsDialog(context);

                                // showSnackBar(subtitle: "happy success" ?? "", isSuccess: true);
                                Future.delayed(const Duration(seconds: 3), () {
                                  // Get.offAll(
                                  //     const DashboardScreen(bodyIndex: 1));

                                  if(widget.purchaseType == 601) {
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                  } else {
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                  }

                                  Get.to(() =>
                                      OrderSuccessScreen(
                                          orderId: widget.orderId,
                                        orderItemId: widget.orderItemId,
                                      ));
                                });
                              } else if (url.contains("paymentStatus") &&
                                  type == 'cancel') {
                                // _showCongrulationsDialog(context);

                                Future.delayed(const Duration(seconds: 3), () {
                                  if(widget.purchaseType == 601) {
                                    Get.back();
                                    Get.back();
                                    // Get.back();
                                  } else {
                                    Get.back();
                                    Get.back();
                                  }
                                });
                              } else {
                                // showToastError('msg $url');
                                log("in else false $url");
                                // showSnackBar(subtitle: "Oops...... " ?? "");
                              }
                            }

                            // setState(() {
                            //   isLoading = false;
                            // });
                          },

                          /*onWebResourceError: (error){
                            log("onWebResourceErrors $error");
                            if(widget.purchaseType == 601) {
                              Get.back();
                              Get.back();
                              // Get.back();
                            } else {
                              Get.back();
                              Get.back();
                            }
                            showSnackBar(subtitle: "Something went wrong. Please try again.");
                            },

                          onHttpError: (error){
                            log("onHttpError $error");
                            if(widget.purchaseType == 601) {
                              Get.back();
                              Get.back();
                              // Get.back();
                            } else {
                              Get.back();
                              Get.back();
                            }
                            showSnackBar(subtitle: "Something went wrong. Please try again.");
                            },*/
                        ),
                      )
                      ..loadRequest(Uri.parse(widget.url)),
                  ),

                  // if(isLoading)
                  //   const Center( child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        )
    );
  }
}
