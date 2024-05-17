import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/navigation/route_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return ScreenUtilInit(
      designSize: const Size(360, 812),
      builder: (BuildContext context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          /// Routing
          routerConfig: getIt<NavigationRoute>().router,

          builder: (BuildContext context, Widget? widget) {
            return MediaQuery(
                // Setting font to not scale with system font size
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: Container());
          },
        );
      },
    );
  }
}
