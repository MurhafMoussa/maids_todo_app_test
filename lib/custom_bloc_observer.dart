import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_todo_app_test/core/extensions/logger_extension.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    '${bloc.runtimeType} $change'.logI;
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition'.logI;
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    'onError -- bloc: ${bloc.runtimeType}, error: $error'.logI;
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    'onClose -- bloc: ${bloc.runtimeType}'.logI;
  }
}
