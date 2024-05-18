import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:maids_todo_app_test/core/constants/border_radius_manager.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/theme/app_colors.dart';

void showSuccessSnackBar(String msg, BuildContext context) {
  final SnackBar snackBar = _customSnackBar(
    context,
    msg,
    'Success!',
    AppColors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar(String msg, BuildContext context) {
  final SnackBar snackBar = _customSnackBar(
    context,
    msg,
    'Failed :(',
    AppColors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

SnackBar _customSnackBar(
  BuildContext context,
  String msg,
  String title,
  Color backgroundColor,
) =>
    SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Text(
            msg,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
      elevation: 2,
      padding: PaddingManager.paddingHorizontal16Vertical12,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadiusManager.radiusAll16),
      showCloseIcon: false,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      backgroundColor: backgroundColor,
    );
