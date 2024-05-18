import 'package:flutter/cupertino.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/form_field_controller.dart';

class NameFormFieldController extends FormFieldController {
  NameFormFieldController._({
    required super.onChange,
    required super.tag,
    required super.isFieldRequired,
    required super.title,
    required super.hint,
    required super.keyboardType,
  });
  NameFormFieldController.filled({
    required ValueChanged<String> onChange,
  }) : this._(
          onChange: onChange,
          tag: 'UserNameField',
          title: 'Username',
          hint: 'enter your username',
          isFieldRequired: true,
          keyboardType: TextInputType.text,
        );
}
