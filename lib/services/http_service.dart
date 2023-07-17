// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/extensions/logger/logger_extension.dart';
import '../utils/exceptions/dio_exception.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio _dio = Dio();

  Future<HttpService> init(url, Map<String, String>? headers) async {
    final Map<String, String> _headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    if (headers != null) {
      _headers.addEntries(headers.entries);
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: url,
        headers: _headers,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        followRedirects: true,
      ),
    );
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) async {
          if (kDebugMode) {
            ("REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path} => "
                    "REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}")
                .iLog();
          }
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            ("RESPONSE[${response.statusCode}] => "
                    "DATA: ${response.data}")
                .wLog();
          }
          return handler.next(response);
        },
        onError: (err, handler) async {
          if (kDebugMode) {
            ("Error[${err.response?.statusCode}] => "
                    "MESSAGE: ${err.response?.data}")
                .eLog();
          }

          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request({
    required String url,
    required Method method,
    dynamic params,
  }) async {
    Response response;

    try {
      switch (method) {
        case Method.POST:
          response = await _dio.post(url, data: params);
          break;
        case Method.DELETE:
          response = await _dio.delete(url, data: params);
          break;
        case Method.PATCH:
          response = await _dio.patch(url, data: params);
          break;
        case Method.PUT:
          response = await _dio.put(url, data: params);
          break;
        case Method.GET:
          response = await _dio.get(url, queryParameters: params);
          break;
      }
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          return response;
        default:
          throw Exception('error.an_error_happened');
      }
    } on SocketException {
      throw Exception('error.internet');
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
