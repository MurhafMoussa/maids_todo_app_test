import 'package:flutter/material.dart';

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;

  SlideLeftRoute({
    required this.page,
    required this.settings,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
  }) : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            key: new GlobalKey(),
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          transitionDuration:
              transitionDuration ?? const Duration(milliseconds: 300),
          reverseTransitionDuration:
              reverseTransitionDuration ?? const Duration(milliseconds: 300),
        );
}
