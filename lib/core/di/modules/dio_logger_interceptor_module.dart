import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/networking/dio_logger_interceptor.dart';

@module
abstract class DioLoggerInterceptorModule {
  @lazySingleton
  DioLoggerInterceptor get dioLoggerInterceptor => DioLoggerInterceptor();
}
