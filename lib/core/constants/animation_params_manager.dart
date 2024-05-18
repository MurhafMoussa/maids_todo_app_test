import 'package:flutter/animation.dart';

interface class AnimationParamsManager {
  static const animateToDuration = Duration(milliseconds: 500);
  static const slidingIntervalDuration = Duration(seconds: 5);
  static const slidingAnimationDuration = Duration(milliseconds: 300);
  static const animatedSwitcherDuration = Duration(milliseconds: 500);
  static const animateToCurve = Curves.easeOut;
  static const slidingCurve = Curves.easeIn;
}
