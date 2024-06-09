import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maids_todo_app_test/core/networking/base_model.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

@freezed
class PaginationModel extends BaseModel<PaginationEntity>
    with _$PaginationModel {
  const factory PaginationModel({
    required List<TodoModel> todos,
    required int total,
    required int skip,
    @JsonKey(name: 'limit') required int itemCountPerPage,
  }) = _PaginationModel;
  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaginationModelFromJson(
        json,
      );
  const PaginationModel._();

  @override
  PaginationEntity toEntity() => PaginationEntity(
        todos: todos
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
        total: total,
        skip: skip,
        itemCountPerPage: itemCountPerPage,
      );
}
