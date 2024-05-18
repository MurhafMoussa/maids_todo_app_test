import 'package:maids_todo_app_test/core/params/base_params.dart';

class NoParams extends BaseParams {
  const NoParams({super.cancelToken});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }
}
