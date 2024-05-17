import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/networking/api_consumer.dart';
import 'package:maids_todo_app_test/core/networking/dio_logger_interceptor.dart';
import 'package:maids_todo_app_test/core/networking/end_points.dart';
import 'package:maids_todo_app_test/core/networking/headers_interceptor.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  DioConsumer() {
    _client.options
      ..sendTimeout = const Duration(seconds: 10)
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 30)
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = true;
    _client.interceptors.add(getIt<DioHeadersInterceptor>());
    if (kDebugMode) {
      _client.interceptors.add(getIt<DioLoggerInterceptor>());
    }
    _client.interceptors.add(getIt<DioCacheInterceptor>());
  }
  late final Dio _client;

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      FormData? formData,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.post(path,
          queryParameters: queryParameters, data: formData ?? body);
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.delete(
        path,
        queryParameters: queryParameters,
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  dynamic _handleOnlineResponseAsJson(Response response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }
}
