import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustaad/Helpers/pref_keys.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Screens/Authentication/login_screen.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/keys/global.dart';
import 'package:ustaad/config/keys/headers.dart';
import 'package:ustaad/config/keys/urls.dart';

class AppDioInterceptor extends Interceptor {
  String token = "";
  final AppLogger _logger = AppLogger();

  AppDioInterceptor() {
    getTokenSharedPreferences();
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e({
      "type": err.type,
      "message": err.message,
      "status_code": err.response?.statusCode,
      "status_message": err.response?.statusMessage,
      "headers": err.response?.headers,
      "data": err.response?.data,
      "response": err.response,
    });

    if (err.response != null) {
      handler.resolve(err.response!);
    } else {
      handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i({
      "base_url": response.requestOptions.baseUrl,
      "end_point": response.requestOptions.path,
      "method": response.requestOptions.method,
      "status_code": response.statusCode,
      "status_message": response.statusMessage,
      "headers": response.headers,
      "data": response.data,
      "extra": response.extra,
      "response": response,
    });

    if (response.statusCode == 401) {
      ToastHelper.displayErrorMotionToast(
        context: navigatorKey.currentContext!,
        msg: response.statusMessage ?? "Unauthorized",
      );

      // Pop all routes and push login screen
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LogInScreen()),
        (route) => false,
      );
    }

    handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AppUrls.baseUrl.isEmpty) {
      throw Exception("Base URL is not set");
    }

    options.baseUrl = AppUrls.baseUrl;
    if (token.isNotEmpty) {
      options.headers.addAll({
        RequestHeader.authorization: "Bearer $token",
      });
    }

    _logger.d({
      "base_url": options.baseUrl,
      "end_point": options.path,
      "method": options.method,
      "headers": options.headers,
      "params": options.queryParameters,
      "data": options.data,
      "extra": options.extra,
    });

    handler.next(options);
  }

  void getTokenSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(PrefKey.authorization) ?? "";
  }
}
