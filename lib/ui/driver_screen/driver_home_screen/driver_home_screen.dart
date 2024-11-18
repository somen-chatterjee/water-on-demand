import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water_on_demand/ui/base_components/animated_column.dart';
import 'package:water_on_demand/ui/base_components/base_app_bar_bg_driver.dart';
import 'package:water_on_demand/ui/driver_screen/driver_home_screen/components/driver_home_screen_loading.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/components/items_details_screen.dart';
import 'package:water_on_demand/utils/base_colors.dart';
import '../../../utils/base_assets.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/base_no_data.dart';
import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../driver_details_screen/accept_screen.dart';
import '../common_map_component/map_view_controller.dart';
import '../myJobs_screens/controller/driver_job_list_controller.dart';
import 'controller/driver_home_data_controller.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({
    super.key,
  });

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  DriverHomeDataController driverHomeDataCtrl =
  Get.put(DriverHomeDataController());
  DriverJobListController controller = Get.put(DriverJobListController());
  MapViewController mapCtrl = Get.put(MapViewController());
  bool currentValue = true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Completer<GoogleMapController> mapController = Completer();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      driverHomeDataCtrl.driverHomeDataApi();
      // await mapCtrl.locateToCurrentLocation(mapController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: mapCtrl.initialCameraPosition,
                markers: Set<Marker>.of(mapCtrl.markers),
                zoomControlsEnabled: false,
                scrollGesturesEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                padding: const EdgeInsets.only(top: 120, bottom: 440),
                onTap: (LatLng latLang) async {
                  // mapCtrl.addMarker(latitude: latLang.latitude, longitude: latLang.longitude);
                  // var placeMarks = await placemarkFromCoordinates(latLang.latitude, latLang.longitude);
                  // Placemark place = placeMarks[0];
                  //   String finalAddress = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
                  //   controller.selectedLocation.value = finalAddress;
                  //   controller.searchController.text = finalAddress;

                  // mapCtrl.animateToLocation(value: latLang);
                  setState(() {});
                },
                onMapCreated: (
                    GoogleMapController googleMapController) async {
                  // if (!mapCtrl.mapController.isCompleted) {
                  //   mapCtrl.mapController.complete(googleMapController);
                  mapController.complete(googleMapController);
                  await mapCtrl.locateToCurrentLocation(mapController);
                  setState(() {});
                  // }
                },
              ),
              Positioned(
                bottom: 150,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 300,
                  child: Obx(() {

                    if(driverHomeDataCtrl.isHomeDataListLoading.value){
                      return const DriverHomeScreenLoading();
                    }

                    if ((driverHomeDataCtrl.orderItemData ?? []).isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: PageView.builder(
                          itemCount:
                              driverHomeDataCtrl.orderItemData?.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.to(AcceptScreen(
                                  orderItemId: driverHomeDataCtrl
                                          .orderItemData?[index].orderItemId ??
                                      0,
                                  userOrderLocation: LatLng(double.parse(driverHomeDataCtrl
                                      .orderItemData?[index]
                                      .orderData?.orderAddress?.latitude ?? "0.0"),
                                      double.parse(driverHomeDataCtrl
                                      .orderItemData?[index]
                                      .orderData?.orderAddress?.longitude ?? "0.0"),
                                  ),
                                  destinationLocation: LatLng(double.parse(driverHomeDataCtrl
                                      .orderItemData?[index]
                                      .orderData?.fromAddress?.adminLatitude ?? "0.0"),
                                      double.parse(driverHomeDataCtrl
                                      .orderItemData?[index]
                                      .orderData?.fromAddress?.adminLongitude ?? "0.0"),
                                  ),
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0,
                                ),
                                width: 320,
                                // Specify a width for the container
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: BaseColors.shadowColor,
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                    )
                                  ],
                                ),
                                child: AnimatedColumn(
                                  leftPadding: 0,
                                  rightPadding: 0,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildSizeHeight(10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if ((driverHomeDataCtrl
                                                    .orderItemData?[index]
                                                    .orderedData ?? [])
                                                    .isNotEmpty)
                                                  BaseText(
                                                    value: "# ${driverHomeDataCtrl.orderItemData?[index]
                                                        .orderData?.orderId ?? ""}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                if ((driverHomeDataCtrl
                                                    .orderItemData?[index]
                                                    .orderedData ?? [])
                                                    .isNotEmpty)
                                                BaseText(
                                                  value: driverHomeDataCtrl
                                                          .orderItemData![index]
                                                          .orderedData![0]
                                                          .productData!
                                                          .title ??
                                                      "",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  BaseAssets.locationPin,
                                              ),
                                              buildSizeWidth(10.0),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () {
                                                  Get.to(() => ItemsDetailsScreen(orderedData: driverHomeDataCtrl.orderItemData?[index].orderedData ?? []));
                                                },
                                                child: SvgPicture.asset(
                                                  BaseAssets.info,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const BaseText(
                                            value: 'R',
                                            color: BaseColors.secondaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          if (driverHomeDataCtrl
                                              .orderItemData![index]
                                              .orderedData!
                                              .isNotEmpty)
                                            BaseText(
                                              value: driverHomeDataCtrl
                                                      .orderItemData?[index]
                                                      .totalAmount ??
                                                  "",
                                              color: BaseColors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (driverHomeDataCtrl.orderItemData![index]
                                        .orderedData!.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: BaseText(
                                          value:
                                              'Units : ${driverHomeDataCtrl.orderItemData?[index].orderedData?[0].unit ?? ""}| ${driverHomeDataCtrl.orderItemData?[index].orderedData?[0].productData?.quantity ?? ""}L | ${driverHomeDataCtrl.orderItemData?[index].orderData?.distance ?? ""}',
                                          color: BaseColors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    buildSizeHeight(10),
                                    const Divider(
                                      color: BaseColors.primaryColor,
                                      thickness: 1.0,
                                    ),
                                    buildSizeHeight(10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          Flexible(
                                            child: BaseText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              value:
                                                  '${driverHomeDataCtrl.orderItemData?[index].orderData?.orderAddress?.houseNumber ?? ""},${driverHomeDataCtrl.orderItemData?[index].orderData?.orderAddress?.address ?? ""}',
                                              color: BaseColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    buildSizeHeight(10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.calendar_month_outlined),
                                          BaseText(
                                            value:
                                                '${driverHomeDataCtrl.orderItemData?[index].orderData?.startDate ?? ""} to ${driverHomeDataCtrl.orderItemData?[index].orderData?.endDate ?? ""} ',
                                            color: BaseColors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                    buildSizeHeight(20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Visibility(
                                        visible: driverHomeDataCtrl
                                                .selectedIndex.value ==
                                            0,
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible: driverHomeDataCtrl
                                                      .orderItemData?[index]
                                                      .acceptBtn ??
                                                  false,
                                              child: Expanded(
                                                child: BaseButton(
                                                  borderRadius: 10,
                                                  borderEnable: true,
                                                  btnColor: BaseColors.white,
                                                  title: 'Accept',
                                                  borderColor:
                                                      BaseColors.primaryColor,
                                                  btnTextColor:
                                                      BaseColors.primaryColor,
                                                  onPressed: () {
                                                    controller.driverAcceptOrder(
                                                        orderItemId: driverHomeDataCtrl
                                                                .orderItemData?[
                                                                    index]
                                                                .orderItemId ??
                                                            0,
                                                        isAcceptScreen: false,
                                                      userOrderLocation: LatLng(double.parse(driverHomeDataCtrl
                                                          .orderItemData?[index]
                                                          .orderData?.orderAddress?.latitude ?? "0.0"),
                                                        double.parse(driverHomeDataCtrl
                                                            .orderItemData?[index]
                                                            .orderData?.orderAddress?.longitude ?? "0.0"),
                                                      ),
                                                      destinationLocation: LatLng(double.parse(driverHomeDataCtrl
                                                          .orderItemData?[index]
                                                          .orderData?.fromAddress?.adminLatitude ?? "0.0"),
                                                        double.parse(driverHomeDataCtrl
                                                            .orderItemData?[index]
                                                            .orderData?.fromAddress?.adminLongitude ?? "0.0"),
                                                      ),
                                                    );
                                                    // Get.to(const AcceptScreen(
                                                    //   orderItemId: 1,
                                                    // )
                                                    // );
                                                  },
                                                ),
                                              ),
                                            ),
                                            buildSizeWidth(10),
                                            Visibility(
                                              visible: driverHomeDataCtrl
                                                      .orderItemData?[index]
                                                      .cancelBtn ??
                                                  false,
                                              child: Expanded(
                                                child: BaseButton(
                                                  borderRadius: 10,
                                                  title: 'Reject',
                                                  onPressed: () {
                                                    controller
                                                        .cancelReasonController
                                                        .clear();
                                                    _rejectBottomSheet(
                                                        context, index);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    buildSizeHeight(20),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0,),
                        width: 320,
                        // Specify a width for the container
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadiusDirectional.all(
                                Radius.circular(12),
                              ),
                          boxShadow: [
                            BoxShadow(
                              color: BaseColors.shadowColor,
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        child: const BaseNoData(),
                      );
                    }
                  }),
                ),
              ),
              buildSizeHeight(150),
              const BaseAppBarBgDriver(),
            ],
          ),
        ),
      ),
    );
  }

  void _rejectBottomSheet(BuildContext context, int index) {
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
                      controller: controller.cancelReasonController,
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
                      borderRadius: 5,
                      title: 'Submit',
                      onPressed: () {
                        controller.driverRejectOrder(driverHomeDataCtrl
                            .orderItemData?[index].orderItemId ??
                            0);
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
