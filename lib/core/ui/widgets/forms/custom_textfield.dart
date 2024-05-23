import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maids_todo_app_test/core/theme/app_colors.dart';
import 'package:maids_todo_app_test/core/theme/text_theme_styles.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/form_field_controller.dart';

class CursorSettings {
  const CursorSettings({
    this.cursorWidth = 2,
    this.cursorHeight,
    this.cursorColor,
    this.cursorRadius,
    this.showCursor,
  });
  final double cursorWidth;
  final double? cursorHeight;
  final Color? cursorColor;
  final Radius? cursorRadius;
  final bool? showCursor;
}

/// A customizable text field widget with various features for form input.
class CustomTextField extends StatefulWidget {
  /// Creates a custom text field.
  ///
  /// [controller]: The form field controller that manages the state of the text field.
  ///
  /// [suffixIcon]: Optional icon widget to be displayed at the end of the text field.
  ///
  /// [prefixIcon]: Optional icon widget to be displayed at the beginning of the text field.
  ///
  /// [decoration]: Additional decoration options for the text field.
  ///
  /// [prefixWidget]: Custom widget to be displayed before the text field. It is typically used for labels.
  CustomTextField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.decoration,
    this.prefixWidget,
  }) : assert(
          (prefixWidget != null && !controller.showLabel) ||
              (prefixWidget == null),
        );

  /// The form field controller managing the state and behavior of the text field.
  final FormFieldController controller;

  /// An optional icon widget to be displayed at the end of the text field.
  final Widget? suffixIcon;

  /// An optional icon widget to be displayed at the beginning of the text field.
  final Widget? prefixIcon;

  /// Additional decoration options for the text field.
  final InputDecoration? decoration;

  /// Custom widget to be displayed before the text field, typically used for labels.
  final Widget? prefixWidget;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// The form field controller instance.
  late final FormFieldController _controller;

  @override
  void initState() {
    // Initialize the form field controller using GetX for state management.
    _controller = Get.put(widget.controller, tag: widget.controller.tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Observe changes in the form field controller using Obx for reactive UI updates.

    return Obx(
            () => TextFormField(
      // Key for identifying and interacting with the text form field.
      key: _controller.key,

      // Control various behavior and appearance of the text form field.
      enabled: _controller.enabled,
      expands: _controller.expands,
      readOnly: _controller.readOnly,
      textDirection: _controller.textDirection,
      controller: _controller.textEditingController,
      focusNode: _controller.focusNode,
      keyboardType: _controller.keyboardType,
      textInputAction: _controller.textInputAction,
      style: _controller.style ??
          TextThemeStyles.getTextStyle(
            FigmaFontStyle.h3Regular,
            color: AppColors.dark,
          ),
      inputFormatters: _controller.inputFormatters,
      autofillHints: _controller.keyboardType == TextInputType.phone
          ? <String>[AutofillHints.telephoneNumberNational]
          : _controller.keyboardType == TextInputType.visiblePassword
              ? <String>[AutofillHints.password]
              : null,

      // Customize the appearance and behavior of the text form field.
      decoration: widget.decoration?.copyWith(
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffixIcon(),
            label: _controller.showLabel ? _buildLabel(context) : null,
            hintText: _buildHint(),
          ) ??
          InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffixIcon(),
            label: _controller.showLabel ? _buildLabel(context) : null,
            hintText: _buildHint(),
          ),

      // Validation function to determine whether the input is valid.
      validator: _controller.validate,

      // Callbacks for handling user interactions with the text form field.
      onTap: () => _controller.onTap(context),
      onFieldSubmitted: _controller.onFieldSubmitted,

      // Configure additional features of the text form field.
      obscureText: _controller.obscureText.value,
      maxLines: _controller.maxLines,
      maxLength: _controller.maxLength,
      textAlign: _controller.textAlign,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: _controller.enableSuggestions,
      cursorWidth: _controller.cursorSettings.cursorWidth,
      cursorHeight: _controller.cursorSettings.cursorHeight,
      cursorColor: _controller.cursorSettings.cursorColor,
      cursorRadius: _controller.cursorSettings.cursorRadius,
      showCursor: _controller.cursorSettings.showCursor,
      textAlignVertical: _controller.textAlignVertical,
      textCapitalization: _controller.textCapitalization,
    ));
  }

  /// Builds the hint text based on the current state of the form field controller.
  String? _buildHint() => _controller.showHint ? _controller.hint : null;

  /// Builds the label text based on the current state of the form field controller.
  Text _buildLabel(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: _controller.title,
        style: context.theme.inputDecorationTheme.floatingLabelStyle,

        // Display a red asterisk (*) if the field is required.
        children: [
          if (_controller.isFieldRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the suffix icon for the text form field based on controller settings.
  Widget suffixIcon() {
    return _controller.keyboardType == TextInputType.visiblePassword
        ? _buildVisibilityIcon()
        : _controller.enableClear && _controller.fieldIsNotEmpty.value
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Clear button to erase the content of the text form field.
                  IconButton(
                    onPressed: () => _controller.clearText(),
                    icon: const Icon(
                      Icons.close_outlined,
                    ),
                  ),

                  // Display the provided suffix icon or an empty widget.
                  if (widget.suffixIcon != null &&
                      _controller.alignClearWithSuffix)
                    widget.suffixIcon!,
                ],
              )
            : widget.suffixIcon ?? const SizedBox.shrink();
  }

  /// Builds the visibility icon for revealing or hiding the password.
  Widget _buildVisibilityIcon() {
    return _controller.customVisibilityIcon ??
        IconButton(
          onPressed: _controller.changeVisibility,
          icon: Obx(
            () => Icon(
              _controller.obscureText.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.gray3,
            ),
          ),
        );
  }
}
