import 'package:flutter/cupertino.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/form_field_controller.dart';

class TextAreaFormFieldController extends FormFieldController {
  TextAreaFormFieldController({
    required super.onChange,
    required super.hint,
    required super.isFieldRequired,
    super.tag = 'TextArea',
    super.title = '',
    super.maxLength = 200,
    super.maxLines = null,
    super.keyboardType = TextInputType.text,
    super.showLabel = false,
    super.enableClear = false,
  });
}
