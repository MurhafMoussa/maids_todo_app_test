import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/networking/headers_interceptor.dart';

@module
abstract class DioHeadersInterceptorModule {
  @lazySingleton
  DioHeadersInterceptor get dioHeadersInterceptor {
    return DioHeadersInterceptor();
  }
}
