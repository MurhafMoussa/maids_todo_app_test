import 'package:flutter/material.dart';

class ScaleRoute extends PageRouteBuilder {

  ScaleRoute({
    required this.page,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation,) {
            return page;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(
                    0,
                    0.50,
                  ),
                ),
              ),
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 1.5,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(
                      0.50,
                      1,
                    ),
                  ),
                ),
                child: child,
              ),
            );
          },
          transitionDuration:
              transitionDuration ?? const Duration(milliseconds: 300),
          reverseTransitionDuration:
              reverseTransitionDuration ?? const Duration(milliseconds: 300),
        );
  final Widget page;
}
