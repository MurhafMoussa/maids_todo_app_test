import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class BorderRadiusManager {
  static final BorderRadius radiusAll16 = BorderRadius.all(
    const Radius.circular(
      16,
    ).r,
  );
  static final BorderRadius radiusAll12 = BorderRadius.all(
    const Radius.circular(
      12,
    ).r,
  );
  static final BorderRadius radiusAll24 = BorderRadius.all(
    const Radius.circular(
      24,
    ).r,
  );
  static final BorderRadius radiusAll32 = BorderRadius.all(
    const Radius.circular(
      32,
    ).r,
  );
  static final BorderRadius radiusAll8 = BorderRadius.all(
    const Radius.circular(
      8,
    ).r,
  );
  static final BorderRadius radiusAll4 = BorderRadius.all(
    const Radius.circular(
      4,
    ).r,
  );
  static final BorderRadius radiusAll6 = BorderRadius.all(
    const Radius.circular(
      6,
    ).r,
  );
  static final BorderRadius radiusAll2 = BorderRadius.all(
    const Radius.circular(
      2,
    ).r,
  );
  static final BorderRadius radiusOnlyTopRightTopLeft8 = BorderRadius.only(
    topLeft: const Radius.circular(
      8,
    ).r,
    topRight: const Radius.circular(
      8,
    ).r,
  );
  static final BorderRadius radiusOnlyTopRightTopLeft24 = BorderRadius.only(
    topLeft: const Radius.circular(
      24,
    ).r,
    topRight: const Radius.circular(
      24,
    ).r,
  );
  static final BorderRadius radiusOnlyBottomRightBottomLeft8 =
      BorderRadius.only(
    bottomLeft: const Radius.circular(
      8,
    ).r,
    bottomRight: const Radius.circular(
      8,
    ).r,
  );
}
