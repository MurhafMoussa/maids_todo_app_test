import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/di/service_locator.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async => await getIt.init();

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
