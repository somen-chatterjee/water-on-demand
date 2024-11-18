import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:water_on_demand/utils/base_variables.dart';

import '../utils/base_functions.dart';
import '../utils/get_storage.dart';
import '../utils/storage_keys.dart';
import 'api_end_points.dart';


class BaseApiService {
  late Dio _dio;
  static final BaseApiService _singleton = BaseApiService._internal();

  factory BaseApiService() {
    return _singleton;
  }

  BaseApiService._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: apiTimeOut),
        receiveTimeout: const Duration(seconds: apiTimeOut),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));
    _dio.interceptors.add(
        CurlLoggerDioInterceptor(printOnSuccess: true, convertFormData: true));
    // _dio.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: [systemSha256]));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        FocusManager.instance.primaryFocus?.unfocus();
        if (await checkInternetConnection()) {
          return handler.next(options);
        } else {
          dismissBaseLoader();
          log("sam please check internet");
          return handler.reject(DioException(
            error: 'No Internet Connection',
            requestOptions: options,
            type: DioExceptionType.connectionError,
          ));
        }
      },
    ));
  }

  // /// GET Method
  // Future<Response?> testingGet({required String apiEndPoint, Map<String, dynamic>? queryParameters,bool? showLoader,bool? showErrorSnackbar}) async {
  //   showBaseLoader(showLoader: showLoader??true);
  //   try {
  //     final Response response = await _dio.get("https://v1.checkprojectstatus.com/",
  //       queryParameters: queryParameters,
  //       options: Options(headers: {"Authorization": "Bearer ${BaseStorage.read(StorageKeys.apiToken)}"}),
  //     );
  //     dismissBaseLoader(showLoader: showLoader??true);
  //     return response;
  //   } on DioException catch (e) {
  //     dismissBaseLoader(showLoader: showLoader??true);
  //     if (e.error.toString() == "No Internet Connection") {
  //       showSnackBar(subtitle: e.error.toString());
  //     }
  //     _handleError(e,showErrorSnackbar: showErrorSnackbar??true);
  //     rethrow;
  //   }
  // }

  /// GET Method
  Future<Response?> get(
      {required String apiEndPoint,
        Map<String, dynamic>? queryParameters,
        bool? showLoader,
        bool? showErrorSnackbar}) async {
    showBaseLoader(showLoader: showLoader ?? true);
    try {
      final Response response = await _dio.get(
        ApiEndPoints().baseUrl + apiEndPoint,
        queryParameters: queryParameters,
        options: Options(headers: {
          "Authorization": "Bearer ${BaseStorage.read(StorageKeys.apiToken)}"
        }),
      );
      log("Response----->>>> $response");
      dismissBaseLoader(showLoader: showLoader ?? true);
      return response;
    } on DioException catch (e) {
      dismissBaseLoader(showLoader: showLoader ?? true);
      if (e.error.toString() == "No Internet Connection") {
        showSnackBar(subtitle: e.error.toString());
      }
      _handleError(e, showErrorSnackbar: showErrorSnackbar ?? true);
      try {
        showSnackBar(subtitle: e.response?.data['message'].toString());
      } catch (e) {
        log("$e");
      }
      rethrow;
    }
  }

  /// POST Method
  Future<Response?> post(
      {required String apiEndPoint,
        required dynamic data,
        Map<String, dynamic>? headers,
        bool? showLoader}) async {
    showBaseLoader(showLoader: showLoader ?? true);
    log("Request----->>>> $data");
    try {
      final Response response = await _dio.post(
        ApiEndPoints().baseUrl + apiEndPoint,
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer ${BaseStorage.read(StorageKeys.apiToken)}"
        }),
      );

      log("Response----->>>> $response");
      dismissBaseLoader(showLoader: showLoader ?? true);
      return response;
    } on DioException catch (e) {
      dismissBaseLoader(showLoader: showLoader ?? true);
      if (e.error.toString() == "No Internet Connection") {
        showSnackBar(subtitle: e.error.toString());
      }
      _handleError(e);
      try {
        showSnackBar(subtitle: e.response?.data['message'].toString());
      } catch (e) {
        log("$e");
      }

      rethrow;
    }
  }

  /// PUT Method
  Future<Response?> put(
      {required String apiEndPoint,
        dynamic data,
        Map<String, dynamic>? headers,
        bool? showLoader}) async {
    showBaseLoader(showLoader: showLoader ?? true);
    try {
      final Response response = await _dio.put(
        ApiEndPoints().baseUrl + apiEndPoint,
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer ${BaseStorage.read(StorageKeys.apiToken)}"
        }),
      );
      dismissBaseLoader(
        showLoader: showLoader ?? true,
      );
      return response;
    } on DioException catch (e) {
      dismissBaseLoader(showLoader: showLoader ?? true);
      _handleError(e);
      try {
        showSnackBar(subtitle: e.response?.data['message'].toString());
      } catch (e) {
        log("$e");
      }
      rethrow;
    }
  }

  // /// PATCH Method

  Future<Response?> patch(
      {required String apiEndPoint,
        dynamic data,
        Map<String, dynamic>? headers,
        bool? showLoader}) async {
    showBaseLoader(showLoader: showLoader ?? true);
    log("Request----->>>> $data");
    try {
      final Response response = await _dio.patch(
        ApiEndPoints().baseUrl + apiEndPoint,
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer ${BaseStorage.read(StorageKeys.apiToken)}"
        }),
      );

      log("Response----->>>> $response");
      dismissBaseLoader(showLoader: showLoader ?? true);
      return response;
    } on DioException catch (e) {
      dismissBaseLoader(showLoader: showLoader ?? true);
      if (e.error.toString() == "No Internet Connection") {
        showSnackBar(subtitle: "No Internet Connection");
      }
      _handleError(e);
      // try {
      //   showSnackBar(subtitle: e.response?.data['message'].toString());
      // } catch (e) {
      //   log("$e");
      // }
      rethrow;
    }
  }
  // /// Delete Method

  Future<Response?> delete(
      {required String apiEndPoint,
        dynamic data,
        Map<String, dynamic>? headers,
        bool? showLoader}) async {
    showBaseLoader(showLoader: showLoader ?? true);
    log("Request----->>>> $data");
    try {
      final Response response = await _dio.delete(
        ApiEndPoints().baseUrl + apiEndPoint,
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer ${BaseStorage.read(StorageKeys.apiToken)}"
        }),
      );

      log("Response----->>>> $response");
      dismissBaseLoader(showLoader: showLoader ?? true);
      return response;
    } on DioException catch (e) {
      dismissBaseLoader(showLoader: showLoader ?? true);
      if (e.error.toString() == "No Internet Connection") {
        showSnackBar(subtitle: e.error.toString());
      }
      _handleError(e);
      try {
        showSnackBar(subtitle: e.response?.data['message'].toString());
      } catch (e) {
        log("$e");
      }
      rethrow;
    }
  }

  /// Check Internet Connection
  Future<bool> checkInternetConnection() async {
    // try {
    //   bool status = false;
    //   final Connectivity connectivity = Connectivity();
    //
    //     var connectionResult = await connectivity.checkConnectivity();
    //     if (connectionResult == ConnectivityResult.mobile) {
    //       status = true;
    //     } else if (connectionResult == ConnectivityResult.wifi) {
    //       status = true;
    //     } else {
    //       print("connectionResult $connectionResult");
    //
    //       status = false;
    //     }
    //
    //     return status;
    //   } on SocketException catch (_) {
    //     return false;
    //   }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        showSnackBar(subtitle: "No Internet Connection");
        log("No internet connection");
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  // Future<Response> postFormData(String url, Map<String, dynamic> formData, String type, {Map<String, dynamic>? headers, bool? showLoader}) async {
  //   BaseOverlays().showLoader(showLoader: showLoader);
  //   FocusScope.of(X.Get.context!).requestFocus(FocusNode());
  //   try {
  //     final String token = await BaseSharedPreference().getString(SpKeys().apiToken) ?? "";
  //     String currentBaseURL = await BaseSharedPreference().getString(SpKeys().currentBaseURL)??ApiEndPoints().concatBaseUrl2;
  //     var response;
  //     if (type == "post") {
  //       response = await _dio.post(currentBaseURL+url, data: FormData.fromMap(formData), options: Options(headers: headers ?? {"Authorization": "Bearer $token", "Accept-Language":languageCode}));
  //     }
  //     if (type == "patch") {
  //       response = await _dio.patch(currentBaseURL+url, data: FormData.fromMap(formData), options: Options(headers: headers ?? {"Authorization": "Bearer $token", "Accept-Language":languageCode}));
  //     }
  //     if (type == "put") {
  //       response = await _dio.put(currentBaseURL+url, data: FormData.fromMap(formData), options: Options(headers: headers ?? {"Authorization": "Bearer $token", "Accept-Language":languageCode}));
  //     }
  //     // BaseOverlays().dismissOverlay(showLoader: showLoader);
  //     X.Get.back();
  //     return response;
  //   } on DioException catch (e) {
  //     X.Get.back();
  //     // BaseOverlays().dismissOverlay(showLoader: showLoader);
  //     _handleError(e);
  //     rethrow;
  //   }
  // }
  //
  // Future<Response> uploadFile(File file, String url, {Function(int, int)? onSendProgress}) async {
  //   try {
  //     String currentBaseURL = await BaseSharedPreference().getString(SpKeys().currentBaseURL)??ApiEndPoints().concatBaseUrl2;
  //     final formData = FormData.fromMap({
  //       "file": await MultipartFile.fromFile(file.path),
  //     });
  //     final response = await _dio.post(
  //       currentBaseURL+url,
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           HttpHeaders.contentTypeHeader: "multipart/form-data",
  //         },
  //       ),
  //       onSendProgress: onSendProgress,
  //     );
  //     return response;
  //   } on DioException catch (e) {
  //     _handleError(e);
  //     rethrow;
  //   }
  // }

  void _handleError(DioException e, {bool? showErrorSnackbar}) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      // Handle timeout error
      log('Timeout Error: ${e.message}');
    } else if (e.type == DioExceptionType.unknown) {
      // Handle response error
      log('Bad Response Error: ${e.message}');
      if (showErrorSnackbar ?? true) {
        showSnackBar(subtitle: (e.response?.data['message'] ?? "") ?? "");
      }
    } else if (e.type == DioExceptionType.cancel) {
      // Handle cancel error
      log('Request Cancelled Error: ${e.message}');
    } else if (e.type == DioExceptionType.badResponse) {
      // Handle cancel error
      log('Request Cancelled Error: ${e.message}');
      if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
        clearSessionData();
        showSnackBar(subtitle: "Session Expired, Please Login Again");
      }
    } else {
      // Handle other errors
      showSnackBar(subtitle: "Something went wrong, please try again");
      log('Unknown Error: ${e.response?.data["message"]}');
      if ((e.response?.data["message"].toString() ?? "").isNotEmpty) {
        if (showErrorSnackbar ?? true) {
          showSnackBar(subtitle: e.response?.data["message"]);
        }
      }
    }
  }
}
