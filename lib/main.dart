import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maids_todo_app_test/app.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/networking/http_overrides.dart';

void main() async {
  await _initAppConfigs();

  runApp(const App());
}

Future<void> _initAppConfigs() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIChangeCallback(
    (bool systemOverlaysAreVisible) async {
      if (!systemOverlaysAreVisible) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    },
  );

  /// Injectable initialization
  await configureInjection();

  /// In case of network handshake error
  HttpOverrides.global = BadCertHttpOverrides();
}
