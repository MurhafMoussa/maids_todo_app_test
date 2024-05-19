import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/features/todo/presentation/pages/todos_page.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_local_data_source.dart';
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
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.urlPath,
          redirect: (context, state) {
            final user = getIt<UserLocalDataSource>().getUser();
            return optionOf(user).fold(() => null, (_) => TodosPage.urlPath);
          },
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: TodosPage.routeName,
          path: TodosPage.urlPath,
          builder: (context, state) {
            return const TodosPage();
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
