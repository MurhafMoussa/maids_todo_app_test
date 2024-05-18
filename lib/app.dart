import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/navigation/route_generator.dart';

import 'core/theme/themes_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: getIt<NavigationRoute>().router,
          theme: ThemesData.lightTheme(),
          darkTheme: ThemesData.darkTheme(),
          title: 'Maidoy',
          builder: (context, child) {
            return MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
        );
      },
    );
  }
}
