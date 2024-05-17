import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maids_todo_app_test/core/extensions/logger_extension.dart';
import 'package:maids_todo_app_test/core/navigation/base_screen_param.dart';

/// Class to make navigation calling shorter and faster to use
class Nav {
  /// Push
  static void to<T extends Object?>(
    String routeName, {
    required BaseScreenParam? arguments,
    required BuildContext context,
    bool canGoBack = true,
  }) {
    String location = '-';
    final appConfigOrParamContext = context;
    try {
      location = appConfigOrParamContext.namedLocation(
        routeName,
        queryParameters: arguments?.queryParams ?? {},
        pathParameters: arguments?.pathParams ?? {},
      );
    } catch (ex) {
      ex.toString().logE;
    }
    go() => appConfigOrParamContext.go(
          location,
          extra: arguments?.extra,
        );
    if (canGoBack) {
      go();
    } else {
      Router.neglect(appConfigOrParamContext, go);
    }
  }

  /// Pop
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (context.canPop()) {
      context.pop(result);
    } else {
      throw Exception("Can't go back to the previous screen");
    }
  }
}
