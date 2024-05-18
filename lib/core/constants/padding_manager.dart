import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class PaddingManager {
  const PaddingManager._();
  static final EdgeInsets paddingTop48 = const EdgeInsets.only(top: 48).r;
  static final EdgeInsets paddingBottom8 = const EdgeInsets.only(bottom: 8).r;
  static final EdgeInsets paddingBottom16 = const EdgeInsets.only(bottom: 16).r;
  static final EdgeInsets paddingBottom4 = const EdgeInsets.only(bottom: 4).r;
  static final EdgeInsets paddingVertical48 =
      const EdgeInsets.symmetric(vertical: 48).r;
  static final EdgeInsets paddingVertical16 =
      const EdgeInsets.symmetric(vertical: 16).r;
  static final EdgeInsets paddingOnlyT4B2 =
      const EdgeInsets.only(top: 4, bottom: 2).r;
  static final EdgeInsets paddingAll20 = const EdgeInsets.all(20).r;
  static final EdgeInsets paddingHorizontal16 =
      const EdgeInsets.symmetric(horizontal: 16).r;
  static final EdgeInsets paddingHorizontal16Top56 =
      paddingHorizontal16.copyWith(top: 56).r;
  static final EdgeInsets paddingHorizontal30 =
      const EdgeInsets.symmetric(horizontal: 30).r;
  static final EdgeInsets paddingHorizontal8 =
      const EdgeInsets.symmetric(horizontal: 8).r;
  static final EdgeInsets paddingHorizontal14 =
      const EdgeInsets.symmetric(horizontal: 14).r;
  static final EdgeInsets paddingHorizontal4Vertical16 =
      const EdgeInsets.symmetric(horizontal: 4, vertical: 16).r;
  static final EdgeInsets paddingHorizontal8Vertical4 =
      const EdgeInsets.symmetric(horizontal: 8, vertical: 4).r;
  static final EdgeInsets paddingHorizontal8Vertical16 =
      const EdgeInsets.symmetric(horizontal: 8, vertical: 16).r;
  static final EdgeInsets paddingHorizontal4Vertical8 =
      const EdgeInsets.symmetric(horizontal: 4, vertical: 8).r;
  static final EdgeInsets paddingHorizontal2Vertical8 =
      const EdgeInsets.symmetric(horizontal: 2, vertical: 8).r;
  static final EdgeInsets paddingHorizontal2Vertical6 =
      const EdgeInsets.symmetric(horizontal: 2, vertical: 6).r;
  static final EdgeInsets paddingOnlyLR2T4B3 =
      const EdgeInsets.only(left: 2, right: 2, top: 4, bottom: 3).r;
  static final EdgeInsets paddingHorizontal4 =
      const EdgeInsets.symmetric(horizontal: 4).r;
  static final EdgeInsets paddingHorizontal24 =
      const EdgeInsets.symmetric(horizontal: 24).r;
  static final EdgeInsets paddingHorizontal12 =
      const EdgeInsets.symmetric(horizontal: 12).r;
  static final EdgeInsets paddingHorizontal32 =
      const EdgeInsets.symmetric(horizontal: 32).r;
  static final EdgeInsets paddingHorizontal24Vertical16 =
      const EdgeInsets.symmetric(horizontal: 24, vertical: 16).r;
  static final EdgeInsets paddingHorizontal16Vertical8 =
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r;
  static final EdgeInsets paddingHorizontal16Vertical12 =
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r;
  static final EdgeInsets paddingVertical12 =
      const EdgeInsets.symmetric(vertical: 12).r;
  static final EdgeInsets paddingVertical8 =
      const EdgeInsets.symmetric(vertical: 8).r;
  static final EdgeInsets paddingHorizontal12Vertical16 =
      const EdgeInsets.symmetric(vertical: 16, horizontal: 12).r;

  static final EdgeInsetsDirectional paddingDirectionalTBS4E10 =
      EdgeInsetsDirectional.only(top: 4.h, bottom: 4.h, start: 4.w, end: 10.w);
  static final EdgeInsetsDirectional paddingDirectionalTB4S8E16 =
      EdgeInsetsDirectional.only(top: 4.h, bottom: 4.h, start: 8.w, end: 16.w);
  static final EdgeInsetsDirectional paddingDirectionalHorizontal6 =
      EdgeInsetsDirectional.symmetric(horizontal: 6.w);
  static final EdgeInsetsDirectional paddingDirectionalOnlyTB16S0E16 =
      EdgeInsetsDirectional.only(
    top: 16.r,
    bottom: 16.r,
    end: 16.r,
  );
  static final EdgeInsetsDirectional paddingDirectionalOnlyE8 =
      EdgeInsetsDirectional.only(
    end: 8.r,
  );
  static final EdgeInsets paddingOnlyTLR12B16 = EdgeInsets.only(
    top: 12.r,
    bottom: 16.r,
    right: 12.r,
    left: 12.r,
  );
  static final EdgeInsets paddingLRT8B16 =
      const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8).r;
  static final EdgeInsets paddingAll16 = const EdgeInsets.all(16).r;
  static final EdgeInsets paddingAll24 = const EdgeInsets.all(24).r;
  static final EdgeInsets paddingAll32 = const EdgeInsets.all(32).r;
  static final EdgeInsets paddingAll12 = const EdgeInsets.all(12).r;
  static final EdgeInsets paddingAll8 = const EdgeInsets.all(8).r;
  static final EdgeInsets paddingAll4 = const EdgeInsets.all(4).r;
}
