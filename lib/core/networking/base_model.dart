import 'package:maids_todo_app_test/core/entities/base_entity.dart';

abstract class BaseModel<T extends BaseEntity> {
  const BaseModel();
  T toEntity();
}
