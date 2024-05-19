import 'package:flutter/material.dart';
import 'package:maids_todo_app_test/core/constants/border_radius_manager.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/theme/app_colors.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/custom_textfield.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/text_area_form_field/text_area_form_field_controller.dart';

class TextAreaFormField extends StatelessWidget {
  const TextAreaFormField({super.key, required this.controller});
  final TextAreaFormFieldController controller;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      decoration: InputDecoration(
        border: _fieldBorder,
        enabledBorder: _fieldBorder,
        disabledBorder: _fieldBorder,
        errorBorder: _fieldBorder,
        focusedBorder: _fieldBorder,
        focusedErrorBorder: _fieldBorder,
        contentPadding: PaddingManager.paddingHorizontal8Vertical16,
      ),
    );
  }

  OutlineInputBorder get _fieldBorder {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadiusManager.radiusAll8,
    );
  }
}
