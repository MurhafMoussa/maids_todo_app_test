import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/features/user/presentation/pages/login_page.dart';

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
    return GoRouter(
      navigatorKey: _routerKey,
      initialLocation: LoginPage.urlPath,
      routes: [
        // GoRoute(
        //   path: '/',
        //   redirect: (context, state) {
        //     return LoginScreen.urlPath;
        //   },
        // ),
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.urlPath,
          builder: (context, state) {
            return const LoginPage();
          },
        ),
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
