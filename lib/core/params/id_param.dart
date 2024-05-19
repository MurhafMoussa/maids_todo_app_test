import 'package:maids_todo_app_test/core/params/base_params.dart';

class IdParam extends BaseParams {
  const IdParam(this.id);
  final int id;

  @override
  Map<String, dynamic> toJson() => {'id': id};
}
