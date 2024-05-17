import 'package:dio/dio.dart';
import 'package:maids_todo_app_test/core/constants/strings_manager.dart';

class DioHeadersInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      StringsManager.accept: StringsManager.applicationJson,
      StringsManager.contentType: StringsManager.applicationJson,
      StringsManager.authorization: StringsManager.bearer
    };
    handler.next(options);
    super.onRequest(options, handler);
  }
}
