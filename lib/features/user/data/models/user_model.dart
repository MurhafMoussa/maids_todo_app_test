import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maids_todo_app_test/core/entities/base_entity.dart';
import 'package:maids_todo_app_test/core/entities/no_entity.dart';
import 'package:maids_todo_app_test/core/networking/base_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel extends BaseModel with _$UserModel {
  const factory UserModel({
    required String token,
    required int id,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  BaseEntity toEntity() => const NoEntity();
}
