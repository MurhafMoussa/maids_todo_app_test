import 'package:flutter/material.dart';

class SlideLeftRoute extends PageRouteBuilder {

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
            key: GlobalKey(),
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
  final Widget page;
  @override
  final RouteSettings settings;
}
