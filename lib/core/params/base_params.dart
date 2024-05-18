import 'package:dio/dio.dart';

abstract class BaseParams {
  const BaseParams({this.cancelToken});
  final CancelToken? cancelToken;
  Map<String, dynamic> toJson();
}
