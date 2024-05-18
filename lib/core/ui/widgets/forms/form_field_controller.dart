import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/custom_textfield.dart';

/// Base class for managing the state and behavior of form fields.
///
/// This class extends GetxController for reactive state management.
abstract class FormFieldController extends GetxController {
  FormFieldController({
    required this.title,
    required this.onChange,
    required this.tag,
    required this.isFieldRequired,
    this.hint = '',
    this.focusNode,
    this.style,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textAlignVertical = TextAlignVertical.center,
    this.textCapitalization = TextCapitalization.none,
    this.cursorSettings = const CursorSettings(),
    this.customCountryCode,
    this.customVisibilityIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.expands = false,
    this.readOnly = false,
    this.enableSuggestions = false,
    this.enableClear = true,
    this.showLabel = true,
    this.showHint = true,
    this.alignClearWithSuffix = false,
  });

  /// The key for identifying and interacting with the form field.
  final GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();

  /// The text editing controller for the associated text field.
  final TextEditingController textEditingController = TextEditingController();

  /// The unique tag identifying the form field.
  final String tag;

  /// The title or label of the form field.
  final String title;

  /// The hint text displayed when the form field is empty.
  final String hint;

  /// The text direction (if any) for the form field.
  final TextDirection? textDirection;

  /// The vertical alignment of the text within the form field.
  final TextAlignVertical? textAlignVertical;

  /// The capitalization behavior of the text input.
  final TextCapitalization textCapitalization;

  /// The settings for the cursor in the form field.
  final CursorSettings cursorSettings;

  /// Indicates whether the form field is required.
  final bool isFieldRequired;

  /// Callback function invoked when the value of the form field changes.
  final ValueChanged<String> onChange;

  /// Indicates whether the form field is enabled for user interaction.
  final bool enabled;

  /// Indicates whether the form field should expand to fill available space.
  final bool expands;

  /// Indicates whether the form field is read-only.
  final bool readOnly;

  /// The focus node that controls the focus of the form field.
  final FocusNode? focusNode;

  /// The style applied to the text within the form field.
  final TextStyle? style;

  /// The horizontal alignment of the text within the form field.
  final TextAlign textAlign;

  /// The keyboard type used for input.
  final TextInputType? keyboardType;

  /// The action to be triggered when the user interacts with the text input.
  final TextInputAction? textInputAction;

  /// The input formatters used to format and constrain the input.
  final List<TextInputFormatter>? inputFormatters;

  /// Custom widget representing a country code.
  final Widget? customCountryCode;

  /// Custom widget representing a visibility icon.
  final Widget? customVisibilityIcon;

  /// The maximum number of lines to display in the form field.
  final int? maxLines;

  /// The maximum length of the input allowed in the form field.
  final int? maxLength;

  /// Indicates whether suggestions are enabled for the text input.
  final bool enableSuggestions;

  /// Indicates whether a clear button is enabled for the form field.
  final bool enableClear;

  /// Indicates whether to display the label for the form field.
  final bool showLabel;

  /// Indicates whether to display the hint for the form field.
  final bool showHint;

  /// Indicates whether to align the clear button with the suffix icon.
  final bool alignClearWithSuffix;

  /// RxBool to toggle the visibility of the text (password) in the form field.
  final RxBool obscureText = false.obs;

  /// RxBool to track whether the form field is not empty.
  final RxBool fieldIsNotEmpty = false.obs;

  @override
  void onInit() {
    // Listen to changes in the text editing controller.
    textEditingController.addListener(listenToControllerChanges);

    // Initialize the obscureText based on the keyboard type.
    obscureText.value = keyboardType == TextInputType.visiblePassword;

    super.onInit();
  }

  /// Callback function to listen to changes in the text editing controller.
  void listenToControllerChanges() {
    // Invoke the provided onChange callback.
    onChange(textEditingController.text);

    // Update the fieldIsNotEmpty status.
    changeTextFieldEmptynessStatus();
  }

  /// Triggers the validation of the form field.
  bool isValid() {
    return key.currentState != null && key.currentState!.validate();
  }

  /// Updates the fieldIsNotEmpty status based on the text input.
  void changeTextFieldEmptynessStatus() {
    fieldIsNotEmpty.value = textEditingController.text.isNotEmpty;
  }

  /// Clears the text in the form field.
  void clearText() {
    textEditingController.clear();
  }

  /// Toggles the visibility of the text (password) in the form field.
  void changeVisibility() => obscureText.value = !obscureText.value;

  /// Validates the input value of the form field.
  ///
  /// Returns a validation error message if applicable.
  String? validate(String? value) {
    if (isFieldRequired && value != null && value.isEmpty) {
      return 'this field is required';
    }
    return null;
  }

  /// Callback function invoked when the form field is tapped.
  void onTap(BuildContext context) {}

  /// Callback function invoked when the user submits the form field.
  void onFieldSubmitted(String? value) {}

  @override
  void onClose() {
    // Dispose the text editing controller when the controller is closed.
    textEditingController.dispose();
    super.onClose();
  }
}
