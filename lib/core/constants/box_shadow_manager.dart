import 'package:flutter/material.dart';
import 'package:maids_todo_app_test/core/theme/app_colors.dart';

abstract class BoxShadowManager {
  static final BoxShadow blackOpacity01Blur1 = BoxShadow(
    color: AppColors.black.withOpacity(0.1),
    blurRadius: 1,
  );

  static final BoxShadow blackOpacity003Blur16Offset0X4Y = BoxShadow(
    color: AppColors.black.withOpacity(0.03),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );

  static final BoxShadow blackOpacity004Blur8Offset0X4Y = BoxShadow(
    color: AppColors.black.withOpacity(0.04),
    blurRadius: 8,
    offset: const Offset(0, 4),
  );

  static final BoxShadow blackOpacity005Blur16Offset0X4Y = BoxShadow(
    color: AppColors.black.withOpacity(0.05),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );

  static final BoxShadow blackOpacity008Blur16Offset0XMinus4Y = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    blurRadius: 16,
    offset: const Offset(0, -4),
  );
  static final BoxShadow blackOpacity016Blur8OffsetZero = BoxShadow(
    color: AppColors.black.withOpacity(0.16),
    blurRadius: 8,
  );
  static final BoxShadow richBlackOpacity005Blur16Offset0X4Y = BoxShadow(
    color: AppColors.richBlack.withOpacity(0.05),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
  static final BoxShadow richBlackOpacity003Blur16Offset0X4Y = BoxShadow(
    color: AppColors.richBlack.withOpacity(0.03),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
}
