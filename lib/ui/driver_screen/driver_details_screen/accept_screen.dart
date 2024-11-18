import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:water_on_demand/ui/base_components/base_button.dart';
import 'package:water_on_demand/utils/base_functions.dart';

import '../../../utils/base_assets.dart';
import '../../../utils/base_colors.dart';
import '../../base_components/animated_column.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../common_map_component/map_view_controller.dart';
import '../myJobs_screens/controller/driver_job_list_controller.dart';
import 'controller/driver_details_controller.dart';

class AcceptScreen extends StatefulWidget {
  final int orderItemId;
  final LatLng? userOrderLocation;
  final LatLng? destinationLocation;
  const AcceptScreen({super.key, required this.orderItemId, this.userOrderLocation, this.destinationLocation,});

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  DriverOrderDetailsController driverDetailsCtrl = Get.put(
      DriverOrderDetailsController());
  DriverJobListController driverJobListCtrl = Get.find<
      DriverJobListController>();
  MapViewController mapViewCtrl = Get.find<MapViewController>();
  Completer<GoogleMapController> mapController = Completer();
  bool isPicUp = true;
  double pinWidth = 70.0;
  double pinHeight = 60.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      driverDetailsCtrl.driverOrderDetail(widget.orderItemId);
      // mapViewCtrl.getPolyline();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Obx(() {
              return GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: driverDetailsCtrl.initialCameraPosition,
                markers: Set<Marker>.of(driverDetailsCtrl.orderDetailsMarkers),
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                scrollGesturesEnabled: true,
                compassEnabled: false,
                padding: const EdgeInsets.only(top: 38, bottom: 440),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: driverDetailsCtrl.polylineCoordinates,
                    color: BaseColors.secondaryColor,
                    width: 3,
                  ),
                },
                //   onTap: (LatLng latLang) async{
                //    mapCtrl.addMarker(latitude: latLang.latitude, longitude: latLang.longitude);
                //        var placeMarks = await placemarkFromCoordinates(latLang.latitude, latLang.longitude);
                //       Placemark place = placeMarks[0];
                //      String finalAddress = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
                //     controller.selectedLocation.value = finalAddress;
                //    controller.searchController.text = finalAddress;
                //   controller.animateToLocation(value: latLang);
                //   setState(() {});
                //
                // },
                onMapCreated: (GoogleMapController googleMapController) async {
                  log("GetBuilder<DriverOrderDetailsController>");
                  // if (!mapCtrl.mapController.isCompleted) {
                  //   mapCtrl.mapController.complete(googleMapController);
                  mapController.complete(googleMapController);
                  LatLng source = await mapViewCtrl
                      .locateToCurrentLocation(mapController);
                  log("getPolyline accept $source");
                  // if (driverDetailsCtrl.orderItemData?.value
                  //     .orderData != null) {

                  //user marker
                  driverDetailsCtrl.addMarker(
                    latitude: widget.userOrderLocation?.latitude ?? 0,
                    longitude: widget.userOrderLocation?.longitude ?? 0,
                    markerImage: BaseAssets.userMarker,
                    markerId: "user_marker",
                  );

                  //destination marker
                  driverDetailsCtrl.addMarker(
                    latitude: widget.destinationLocation?.latitude ?? 0,
                    longitude: widget.destinationLocation?.longitude ?? 0,
                    markerImage: BaseAssets.destinationMarker,
                    markerId: "destination_marker",
                  );

                  await driverDetailsCtrl.getPolyline(
                    widget.userOrderLocation ?? const LatLng(0, 0),
                    widget.destinationLocation ?? const LatLng(0, 0),
                    googleMapController,
                  );


                  // }

                  setState(() {});
                  // }
                },
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Column(
                children: [
                  buildSizeHeight(40),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        BaseAssets.backArrow,
                        width: 19,
                        height: 20,
                      )),
                ],
              ),
            ),
            Obx(() {
              return Positioned(
                bottom: 380,
                left: 20,
                right: 20,
                child: Container(
                  decoration: const BoxDecoration(
                      color: BaseColors.switchColor,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(15),
                          topEnd: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          value: driverDetailsCtrl.orderItemData?.value
                              .orderData?.distance ?? "",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        if(driverDetailsCtrl.orderedData != null &&
                            driverDetailsCtrl.orderedData!.isNotEmpty)
                          BaseText(
                            value: 'Units:${driverDetailsCtrl.orderedData?[0]
                                .unit ??
                                ""} | ${driverDetailsCtrl.orderedData?[0]
                                .productData
                                ?.quantity ?? ""} L',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: Container(
                height: 324,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  const BorderRadiusDirectional.all(Radius.circular(13)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 5)
                  ],
                ),
                child: Obx(() {
                  return AnimatedColumn(
                    leftPadding: 0,
                    rightPadding: 0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSizeHeight(10),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BaseText(
                              value: 'Service Info',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Visibility(
                                visible: isPicUp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const BaseText(
                                      value: 'Price',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const BaseText(
                                          value: 'R',
                                          color: BaseColors.secondaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        if(driverDetailsCtrl.orderedData !=
                                            null &&
                                            driverDetailsCtrl.orderedData!
                                                .isNotEmpty)
                                          BaseText(
                                            value: driverDetailsCtrl
                                                .orderItemData?.value.totalAmount  ?? "",
                                            color: BaseColors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: BaseText(
                          value: 'User Info',
                          color: BaseColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseText(
                              value: driverDetailsCtrl.orderData?.value.userData
                                  ?.fullName ?? "",
                              color: BaseColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(BaseAssets.callIcon),
                                buildSizeWidth(10),
                                BaseText(
                                  value: '+ 27 ${driverDetailsCtrl.orderData
                                      ?.value.userData?.mobileNumber ?? ""}',
                                  color: BaseColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      buildSizeHeight(10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                buildSizeHeight(5),
                                const Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: BaseColors.grey,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    10,
                                        (index) =>
                                        Container(
                                          width: 3,
                                          height: 3,
                                          margin: const EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index % 2 == 0
                                                ? Colors.grey
                                                : Colors.transparent,
                                          ),
                                        ),
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: BaseColors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            buildSizeWidth(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'From',
                                    color: BaseColors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  BaseText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    value: driverDetailsCtrl.orderData?.value
                                        .fromAddress?.adminAddress ?? "",
                                    color: BaseColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const Divider(
                                    color: BaseColors.primaryColor,
                                    thickness: 0.8,
                                  ),
                                  const BaseText(
                                    value: 'To',
                                    color: BaseColors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  BaseText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    value: "${driverDetailsCtrl.orderData?.value
                                        .orderAddress?.houseNumber ??
                                        ""}, ${driverDetailsCtrl.orderData
                                        ?.value
                                        .orderAddress?.buildingName ??
                                        ""}, ${driverDetailsCtrl.orderData
                                        ?.value
                                        .orderAddress?.address ?? ""}",
                                    color: BaseColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildSizeHeight(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: (driverDetailsCtrl.orderItemData?.value
                            .acceptBtn ?? false) || (driverDetailsCtrl
                            .orderItemData?.value.pickupBtn ?? false)
                            ? Row(
                          children: [
                            if(driverDetailsCtrl.orderItemData?.value
                                .acceptBtn ?? false)
                              Expanded(
                                child: BaseButton(
                                  borderRadius: 10,
                                  borderEnable: true,
                                  btnColor: BaseColors.white,
                                  title: 'Accept',
                                  borderColor: BaseColors.primaryColor,
                                  btnTextColor: BaseColors.primaryColor,
                                  onPressed: () async {
                                    await driverJobListCtrl.driverAcceptOrder(
                                        orderItemId: driverDetailsCtrl.orderItemData?.value
                                            .orderItemId,
                                        isAcceptScreen: true,
                                    );
                                    driverDetailsCtrl.driverOrderDetail(
                                        driverDetailsCtrl.orderItemData?.value
                                            .orderItemId);
                                  },
                                ),
                              ),
                            if(!(driverDetailsCtrl.orderItemData?.value
                                .acceptBtn ?? false) &&
                                (driverDetailsCtrl.orderItemData?.value
                                    .pickupBtn ?? false))
                              Expanded(
                                child: BaseButton(
                                  borderRadius: 10,
                                  borderEnable: true,
                                  btnColor: BaseColors.white,
                                  title: 'Pickup',
                                  borderColor: BaseColors.primaryColor,
                                  btnTextColor: BaseColors.primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      driverDetailsCtrl.picKupOrderApi(
                                          widget.orderItemId);
                                      isPicUp = false;
                                    });
                                  },
                                ),
                              ),
                            buildSizeWidth(10),
                            Expanded(
                              child: BaseButton(
                                borderRadius: 10,
                                title: 'Reject',
                                onPressed: () {
                                  driverJobListCtrl.cancelReasonController
                                      .clear();
                                  _rejectBottomSheet(context);
                                },
                              ),
                            ),
                          ],
                        )
                            : BaseButton(
                          borderRadius: double.nan,
                          title: 'Drop Off',
                          onPressed: () async {
                            await driverDetailsCtrl.dropOffApi(
                                widget.orderItemId).then((isDone) {
                              if (isDone) {
                                _dropOffBottomSheet(context);
                              }
                            });
                          },
                        ),
                      ),
                      buildSizeHeight(20),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
    );
  }

  void _dropOffBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(BaseAssets.cancelImage),
                            ),
                          ),
                          const Center(
                            child: BaseText(
                              value: 'Verification Code',
                              color: BaseColors.secondaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          buildSizeHeight(19),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'We have sent the code verification \nto ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: BaseColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'XX XXXX XX${(driverDetailsCtrl.orderData
                                      ?.value.userData?.mobileNumber.toString() ?? "").substring((driverDetailsCtrl.orderData
                                      ?.value.userData?.mobileNumber ?? "").length-2)}.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: BaseColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          buildSizeHeight(20),
                          Align(
                            alignment: Alignment.center,
                            child: Pinput(
                              controller: driverDetailsCtrl.verifyOtpController,
                              focusedPinTheme: PinTheme(
                                width: pinWidth,
                                height: pinHeight,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: BaseColors.lightSky1,
                                  boxShadow: [
                                    BoxShadow(
                                      color: BaseColors.lightSky1.withOpacity(
                                          0.4),
                                      spreadRadius: 1.5,
                                      blurRadius: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                              defaultPinTheme: PinTheme(
                                width: pinWidth,
                                height: pinHeight,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: BoxDecoration(
                                  color: BaseColors.lightSky2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                width: pinWidth,
                                height: pinHeight,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: BoxDecoration(
                                  color: BaseColors.lightSky1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onCompleted: (pin) {},
                            ),
                          ),
                          buildSizeHeight(20),
                          Align(
                            alignment: Alignment.center,
                            child: Obx(() {
                              return Visibility(
                                visible: driverDetailsCtrl.countdownShow.value,
                                child: SlideCountdownSeparated(
                                  // key: UniqueKey(),
                                  duration: const Duration(seconds: 59),
                                  showZeroValue: true,
                                  shouldShowHours: (v) => false,
                                  shouldShowDays: (v) => false,
                                  suffixIcon: const Text(
                                    " s",
                                    style: TextStyle(
                                      color: BaseColors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: BaseColors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                  padding: EdgeInsets.zero,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  onDone: () {
                                    driverDetailsCtrl.countdownShow.value =
                                    false;
                                  },
                                ),
                              );
                            }),
                          ),
                          buildSizeHeight(40),
                          Obx(() {
                            return Row(
                              children: [
                                Visibility(
                                  visible: !driverDetailsCtrl.countdownShow
                                      .value,
                                  child: Expanded(
                                    child: BaseButton(
                                      title: 'Resend',
                                      borderEnable: true,
                                      btnColor: BaseColors.white,
                                      borderColor: BaseColors.primaryColor,
                                      btnTextColor: BaseColors.primaryColor,
                                      onPressed: () {
                                        driverDetailsCtrl.dropOffApi(
                                            widget.orderItemId);
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !driverDetailsCtrl.countdownShow
                                      .value,
                                  child: buildSizeWidth(18),
                                ),
                                Expanded(
                                  child: BaseButton(
                                    title: 'Confirm',
                                    onPressed: () {
                                      driverDetailsCtrl.verifyDeliveryApi(
                                          widget.orderItemId);
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _rejectBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                child: AnimatedColumn(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(BaseAssets.cancelImage),
                      ),
                    ),
                    buildSizeHeight(20),
                    const Center(
                      child: BaseText(
                        value: 'Reason Of Cancel',
                        color: BaseColors.secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Center(
                      child: BaseText(
                        value:
                        'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting.',
                        color: BaseColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    buildSizeHeight(20),
                    BaseTextField(
                      controller: driverJobListCtrl.cancelReasonController,
                      labelText: '',
                      autofocus: true,
                      hintText: 'Write Here...',
                      borderRadius: 10,
                      maxLine: 3,
                      hintTextColor: BaseColors.grey,
                      borderColor: BaseColors.lightSky,
                      contentPadding: const EdgeInsets.all(12.0),
                    ),
                    buildSizeHeight(20),
                    BaseButton(
                      borderRadius: 10,
                      title: 'Submit',
                      onPressed: () {
                        driverJobListCtrl.driverRejectOrder(driverDetailsCtrl
                            .orderData
                            ?.value.orderId ?? "");
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
