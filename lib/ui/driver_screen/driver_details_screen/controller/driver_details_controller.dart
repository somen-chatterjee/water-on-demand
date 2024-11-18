import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_on_demand/ui/driver_screen/myJobs_screens/controller/driver_job_list_controller.dart';
import 'package:water_on_demand/utils/base_strings.dart';

import '../../../../backend/api_end_points.dart';
import '../../../../backend/base_api_service.dart';
import '../../../../backend/base_success_response.dart';
import '../../../../utils/base_functions.dart';
import '../../complete_screen.dart';
import '../model/driver_details_response.dart';

class DriverOrderDetailsController extends GetxController{
  TextEditingController cancelReasonController = TextEditingController();
  TextEditingController verifyOtpController = TextEditingController();
  RxList<OrderedData>? orderedData = <OrderedData>[].obs;
  Rx<OrderData>? orderData = OrderData().obs;
  Rx<OrderItemData>? orderItemData = OrderItemData().obs;
  RxBool countdownShow = true.obs;
  List<Marker> orderDetailsMarkers = <Marker>[].obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;

  Future<bool> driverOrderDetail(int orderItemId) async{
    bool isSuccess = false;
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
    };

    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().driverOrderDetails, data: data,showLoader: true)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          DriverDetailsResponse response = DriverDetailsResponse.fromJson(value?.data);
          if (response.status ?? false) {
            orderedData?.value = response.data?.orderItemData?.orderedData ?? [];
            orderData?.value = response.data?.orderItemData?.orderData ?? OrderData();
            orderItemData?.value = response.data?.orderItemData ?? OrderItemData();
            isSuccess = true;
            // update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
            // driverList?.value =[] ;
          }
          update();
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });

    return isSuccess;
  }

  picKupOrderApi(int orderItemId) async {
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
    };
    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().pickupOrder, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            driverOrderDetail(orderItemId);
            Get.find<DriverJobListController>().driverJobList();
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

  Future<bool> dropOffApi(int orderItemId,) async {
    bool isDone = false;
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
    };
    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().dropOffOrder, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            isDone = true;
            countdownShow.value = true;
          } else {
            showSnackBar(subtitle: response.message ?? "");
            isDone =  false;
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
          isDone =   false;
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
        isDone =   false;
      }
    });

    return isDone;
  }

  verifyDeliveryApi(int orderItemId) async {
    Map<String, dynamic> data = {
      "order_item_id": orderItemId,
      "verification_otp":verifyOtpController.value.text.trim(),
    };
    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyDeliveryOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            Get.back();
            Get.back();
            Get.to(const CompleteScreen());
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.find<DriverJobListController>().driverJobList();
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

  // map work
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(26.9124,75.7873),
    zoom: 17,
  );

  addMarker({required double latitude, required double longitude, String? markerImage, String? markerId}) async {
    late BitmapDescriptor icStartMarkerPin;
    if(markerImage != null) {
      // example -> 'assets/images/ic_start_map_pin.png';
      final Uint8List? icStartMarkerPinBytes = await getBytesFromAsset(
          markerImage ?? "", 70);
      icStartMarkerPin = BitmapDescriptor.fromBytes(
          icStartMarkerPinBytes!);
    }
    // orderDetailsMarkers.clear();
    orderDetailsMarkers.add(Marker(
      markerId: MarkerId(markerId ?? "default_marker"),
      position: LatLng(latitude, longitude),
      icon: markerImage != null ? icStartMarkerPin : BitmapDescriptor.defaultMarker,
    ));
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  Future<void> getPolyline(
      LatLng source,
      LatLng destination,
      GoogleMapController mapController,
      ) async {
    log("getPolyline $source");
    log("getPolyline $destination");

    showBaseLoader();

    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng start = PointLatLng(source.latitude, source.longitude);
    PointLatLng end = PointLatLng(destination.latitude, destination.longitude);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(origin: start, destination: end, mode: TravelMode.driving),
        googleApiKey: googleApiKey
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      polylineCoordinates.refresh();
    }

    log("marker length ${orderDetailsMarkers.length}");
    // update();
    // LatLng source = LatLng(start.latitude, start.longitude);
    // LatLng destination = LatLng(end.latitude, end.longitude);
    //
    dismissBaseLoader();
    updateCameraLocation(source, destination, mapController);

  }

  Future<void> updateCameraLocation(
      LatLng source,
      LatLng destination,
      GoogleMapController mapController,
      ) async {
    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }
}