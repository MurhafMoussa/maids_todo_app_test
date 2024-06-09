import 'package:flutter/material.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/display_messages_widgets.dart';

void handleStandardBlocListener(
  StandardState<String> state,
  BuildContext context, {
  VoidCallback? onSuccess,
  VoidCallback? onError,
}) {
  state.whenOrNull(
    failure: (exception) {
      showErrorSnackBar(
        AppExceptions.getErrorMessage(exception),
        context,
      );
      if (onError != null) {
        onError();
      }
    },
    success: (successValue) {
      showSuccessSnackBar(successValue, context);
      if (onSuccess != null) {
        onSuccess();
      }
    },
  );
}
