import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/app.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/networking/http_overrides.dart';
import 'package:maids_todo_app_test/custom_bloc_observer.dart';

void main() async {
  await _initAppConfigs();

  runApp(const App());
}

Future<void> _initAppConfigs() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = CustomBlocObserver();

  /// Injectable initialization
  await configureInjection();

  /// In case of network handshake error
  HttpOverrides.global = BadCertHttpOverrides();
}
