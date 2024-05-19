import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/navigation/route_generator.dart';
import 'package:maids_todo_app_test/core/theme/themes_data.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/user_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      minTextAdapt: true,
      designSize: const Size(390, 844),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<NavigationRoute>().router,
      theme: ThemesData.lightTheme(),
      darkTheme: ThemesData.darkTheme(),
      title: 'Maidoy',
      builder: (context, child) {
        return BlocProvider<UserCubit>(
          create: (context) => getIt<UserCubit>(),
          child: child,
        );
      },
    );
  }
}
