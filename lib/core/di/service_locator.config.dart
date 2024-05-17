// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:logger/logger.dart' as _i8;
import 'package:maids_todo_app_test/core/di/modules/dio_cache_interceptor_module.dart'
    as _i15;
import 'package:maids_todo_app_test/core/di/modules/dio_headers_interceptor_module.dart'
    as _i16;
import 'package:maids_todo_app_test/core/di/modules/dio_logger_interceptor_module.dart'
    as _i17;
import 'package:maids_todo_app_test/core/di/modules/internet_connection_checker_module.dart'
    as _i18;
import 'package:maids_todo_app_test/core/di/modules/logger_module.dart' as _i19;
import 'package:maids_todo_app_test/core/di/modules/shared_preferences_module.dart'
    as _i14;
import 'package:maids_todo_app_test/core/navigation/route_data_handler.dart'
    as _i9;
import 'package:maids_todo_app_test/core/navigation/route_generator.dart'
    as _i10;
import 'package:maids_todo_app_test/core/networking/api_consumer.dart' as _i11;
import 'package:maids_todo_app_test/core/networking/connectivity.dart' as _i13;
import 'package:maids_todo_app_test/core/networking/dio_consumer.dart' as _i12;
import 'package:maids_todo_app_test/core/networking/dio_logger_interceptor.dart'
    as _i6;
import 'package:maids_todo_app_test/core/networking/headers_interceptor.dart'
    as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioCacheInterceptorModule = _$DioCacheInterceptorModule();
    final dioHeadersInterceptorModule = _$DioHeadersInterceptorModule();
    final dioLoggerInterceptorModule = _$DioLoggerInterceptorModule();
    final internetConnectionCheckerModule = _$InternetConnectionCheckerModule();
    final loggerModule = _$LoggerModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i4.DioCacheInterceptor>(
        () => dioCacheInterceptorModule.dioCacheInterceptor);
    gh.lazySingleton<_i5.DioHeadersInterceptor>(
        () => dioHeadersInterceptorModule.dioHeadersInterceptor);
    gh.lazySingleton<_i6.DioLoggerInterceptor>(
        () => dioLoggerInterceptorModule.dioLoggerInterceptor);
    gh.lazySingleton<_i7.InternetConnectionChecker>(
        () => internetConnectionCheckerModule.logger);
    gh.lazySingleton<_i8.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i9.RouteDataHandler>(() => _i9.RouteDataHandler());
    gh.lazySingleton<_i10.NavigationRoute>(() => _i10.NavigationRoute());
    gh.lazySingleton<_i11.ApiConsumer>(() => _i12.DioConsumer());
    gh.lazySingleton<_i13.Connectivity>(() => _i13.ConnectivityImpl(
        connectionChecker: gh<_i7.InternetConnectionChecker>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i14.SharedPreferencesModule {}

class _$DioCacheInterceptorModule extends _i15.DioCacheInterceptorModule {}

class _$DioHeadersInterceptorModule extends _i16.DioHeadersInterceptorModule {}

class _$DioLoggerInterceptorModule extends _i17.DioLoggerInterceptorModule {}

class _$InternetConnectionCheckerModule
    extends _i18.InternetConnectionCheckerModule {}

class _$LoggerModule extends _i19.LoggerModule {}
