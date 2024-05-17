import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/navigation/route_data_handler.dart';

@lazySingleton
class NavigationRoute {
  NavigationRoute() {
    _currentRouter = _getRouter;
  }
  late GoRouter _currentRouter;
  final GlobalKey<NavigatorState> _routerKey = GlobalKey(debugLabel: 'root');

  GoRouter get router => _currentRouter;

  GlobalKey<NavigatorState> get routerKey => _routerKey;

  GoRouter refreshRouter() => _getRouter;

  GoRouter get _getRouter {
    final routeData = getIt<RouteDataHandler>();
    return GoRouter(
      navigatorKey: _routerKey,
      initialLocation: '/',
      routes: [
        // GoRoute(
        //   path: '/',
        //   redirect: (context, state) {
        //     return LoginScreen.urlPath;
        //   },
        // ),
        // GoRoute(
        //   name: LoginScreen.routeName,
        //   path: LoginScreen.urlPath,
        //   redirect: (context, state) {
        //     if (routeData.isLoggedIn) {
        //       return AppMainScreen.urlPath;
        //     }
        //     return null;
        //   },
        //   builder: (context, state) {
        //     return LoginScreen(
        //       param: LoginScreenParam(),
        //     );
        //   },
        // ),
      ],
      errorBuilder: (context, state) {
        return _errorRoute();
      },
    );
  }

  Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ROUTE ERROR CHECK THE ROUTE GENERATOR'),
      ),
    );
  }
}
