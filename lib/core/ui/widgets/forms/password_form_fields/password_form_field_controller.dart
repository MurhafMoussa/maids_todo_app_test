import 'package:flutter/cupertino.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/form_field_controller.dart';

class PasswordFormFieldController extends FormFieldController {
  PasswordFormFieldController._({
    required super.onChange,
    required super.tag,
    required super.isFieldRequired,
    required super.title,
    required super.hint,
    required super.keyboardType,
  });
  PasswordFormFieldController.filled({
    required ValueChanged<String> onChange,
  }) : this._(
          onChange: onChange,
          isFieldRequired: true,
          title: 'Password',
          hint: 'enter your password',
          tag: 'PasswordFormField',
          keyboardType: TextInputType.visiblePassword,
        );
  @override
  String? validate(String? value) {
    final requiredMessage = super.validate(value);
    if (requiredMessage != null) {
      return requiredMessage;
    }
    if (value != null && value.length < 8) {
      return 'Password must be 8 characters at least!';
    }
    return null;
  }
}
