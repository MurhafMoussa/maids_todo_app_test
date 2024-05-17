
import 'package:maids_todo_app_test/core/networking/base_entity.dart';

abstract class BaseModel<T extends BaseEntity>{
  T toEntity();
}

