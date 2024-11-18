import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart' as as_dio;
import 'package:uuid/uuid.dart';
import 'package:water_on_demand/ui/driver_screen/common_map_component/model/place_details.dart';

import '../../../utils/base_debouncer.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/base_strings.dart';
import 'model/auto_complete_api_response.dart';


class MapViewController extends GetxController{
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  List<Marker> markers = <Marker>[].obs;

  RxString selectedLocation = "".obs;

  String sessionToken = "";
  var uuid = const Uuid();
  BaseDeBouncer deBouncer = BaseDeBouncer();
  as_dio.Dio dio = as_dio.Dio();
  RxList<AutoCompleteResult> searchResultList = <AutoCompleteResult>[].obs;
  TextEditingController searchController = TextEditingController();
  RxBool isAddressSuggestionLoading = false.obs;


  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(26.9124,75.7873),
    zoom: 17,
  );

  addMarker({required double latitude, required double longitude, String? markerImage}) async{
    late BitmapDescriptor icStartMarkerPin;
    if(markerImage != null) {
      // example -> 'assets/images/ic_start_map_pin.png';
      final Uint8List? icStartMarkerPinBytes = await getBytesFromAsset(
          markerImage ?? "", 70);
      icStartMarkerPin = BitmapDescriptor.fromBytes(
          icStartMarkerPinBytes!);
    }
     markers.clear();
     markers.add(Marker(
       markerId: const MarkerId("default_marker"),
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

  Future<LatLng?> getLatLngFromAddress({required String address}) async {
    var locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      return LatLng(locations.first.latitude, locations.first.longitude);
    } else {
      return const LatLng(0, 0);
    }
  }

  Future<LatLng> locateToCurrentLocation(Completer<GoogleMapController> googleMapController) async {

    LatLng currentLatLng = const LatLng(0, 0);

    final GoogleMapController controller = await googleMapController.future;

    await getCurrentLocation(showLoader: true).then((value) async {
      if (value?.latitude != null && value?.longitude != null) {
        currentLatLng = LatLng(value?.latitude??0, value?.longitude??0);
        // addMarker(
        //     latitude: value?.latitude ?? 0, longitude: value?.longitude ?? 0);

        await animateToLocation(
            value: LatLng(value?.latitude ?? 0, value?.longitude ?? 0),
            mapController: googleMapController);

        initialCameraPosition = CameraPosition(
          target: LatLng(value?.latitude ?? 0, value?.longitude ?? 0),
          zoom: 15,
        );

        // controller.animateCamera(CameraUpdate.newCameraPosition(
        //   CameraPosition(
        //     bearing: 0,
        //     target: LatLng(value?.latitude??0, value?.longitude??0),
        //     zoom: 17,
        //   ),
        // ));
        update();
      }
    });

    return currentLatLng;
  }

  Future<Position?> getCurrentLocation({bool? showLoader}) async {
    showBaseLoader(showLoader: showLoader ?? true);
    Position? position;
    bool isPermissionGranted = false;
    isPermissionGranted = await checkLocationPermission();
    if (isPermissionGranted) {
      try {
        position = await Geolocator.getCurrentPosition();
        log('\nCurrent Latitude -> ${(position.latitude).toString()}'
            '\nCurrent Longitude -> ${(position.longitude).toString()}'
            '\nCurrent Accuracy -> ${(position.accuracy).toString()}');
      } catch (e) {
        log(e.toString());
        return position;
      }
    }
    dismissBaseLoader(showLoader: showLoader ?? true);
    return position;
  }

  Future<bool> checkLocationPermission() async {
    bool returnValue = true;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
        returnValue = false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      returnValue = false;
      await Geolocator.openAppSettings();
      log('Location permissions are permanently denied, we cannot request permissions.');
    }
    return returnValue;
  }

  Future<void> animateToLocation({required LatLng value, required Completer<GoogleMapController> mapController}) async {
    final GoogleMapController controller = await mapController.future;
      if (value.latitude != 0 && value.longitude != 0) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(value.latitude, value.longitude),
            zoom: 16,
          ),
        ));
        // addMarker(latitude: value.latitude, longitude: value.longitude);
      }
    update();
  }

  getSuggestionsList(String input) async{
    if (input.isNotEmpty) {
      // deBouncer.run(() async {
        isAddressSuggestionLoading.value = true;
        if (sessionToken.isEmpty) {
          sessionToken = uuid.v4();
        }
        dio = as_dio.Dio();
        String baseURL =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json';
        String request =
            '$baseURL?input=$input&key=$googleApiKey&sessiontoken=$sessionToken';
        as_dio.Response response = await dio.get(request);
        AutoCompleteApiResponse autoCompleteApiResponse =
        AutoCompleteApiResponse.fromJson(response.data);
        isAddressSuggestionLoading.value = false;
        if ((autoCompleteApiResponse.status?.toString().toLowerCase() ?? "") ==
            "ok") {
          searchResultList.value = autoCompleteApiResponse.predictions ?? [];
          log("shubham ${jsonEncode(searchResultList)}");
          searchResultList.refresh();
          update();
        } else {
          throw Exception('Failed to load predictions');
        }
      // });
    } else {
      searchResultList.clear();
      searchResultList.refresh();
    }
    searchResultList.refresh();
    update();
  }

  Future<PlaceDetails> getAddressFromPlaceId(String placeId) async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components,geometry&key=$googleApiKey';

    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      final addressComponents = data['result']['address_components'];
      final geometry = data['result']['geometry'];

      String address = '';
      String city = '';
      String country = '';
      String postalCode = '';
      double latitude = 0.0;
      double longitude = 0.0;

      for (var component in addressComponents) {
        List<dynamic> types = component['types'];
        if (types.contains('street_number') || types.contains('route')) {
          address += component['long_name'] + ', ';
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('country')) {
          country = component['long_name'];
        } else if (types.contains('postal_code')) {
          postalCode = component['long_name'];
        }
      }

      latitude = geometry['location']['lat'];
      longitude = geometry['location']['lng'];
      // showLoader(false);
      return PlaceDetails(
        responseCode: 200,
        address: address.isEmpty ? '' : address.substring(0, address.length - 2),
        city: city,
        country: country,
        postalCode: postalCode,
        latitude: latitude,
        longitude: longitude,
      );
    } else {
      // showLoader(false);

      throw Exception('Failed to load place details');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    // mapController.complete(controller);
  }

  Future<void> getPolyline(
      LatLng source,
      LatLng destination,
      GoogleMapController mapController,
      ) async {
    log("getPolyline $source");
    log("getPolyline $destination");

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

    // update();
    // LatLng source = LatLng(start.latitude, start.longitude);
    // LatLng destination = LatLng(end.latitude, end.longitude);
    //
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