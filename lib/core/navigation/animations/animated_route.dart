import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedRoute extends PageRouteBuilder {

  AnimatedRoute({
    required this.page,
    required RouteSettings settings,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ListenableProvider(
              create: (context) => animation,
              child: page,
            );
          },
          settings: settings,
          transitionDuration:
              transitionDuration ?? const Duration(milliseconds: 1100),
          reverseTransitionDuration:
              reverseTransitionDuration ?? const Duration(milliseconds: 300),
        );
  final Widget page;
}

class SlidingAnimated extends StatelessWidget {

  const SlidingAnimated({
    super.key,
    required this.initialOffsetX,
    required this.intervalStart,
    required this.intervalEnd,
    required this.child,
  });
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(initialOffsetX, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              curve: Interval(
                intervalStart,
                intervalEnd,
                curve: Curves.ease,
              ),
              parent: animation,
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}

class FadeAnimated extends StatelessWidget {

  const FadeAnimated({
    super.key,
    required this.intervalStart,
    required this.intervalEnd,
    required this.child,
  });
  final double intervalStart;
  final double intervalEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(
            CurvedAnimation(
              curve: Interval(
                intervalStart,
                intervalEnd,
                curve: Curves.bounceInOut,
              ),
              parent: animation,
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
