import 'package:maids_todo_app_test/core/entities/base_entity.dart';

class PaginationEntity<T> extends BaseEntity {
  const PaginationEntity({
    required this.items,
    required this.total,
    required this.pageNumber,
    required this.itemCountPerPage,
  });

  final List<T> items;
  final int total;
  final int pageNumber;
  final int itemCountPerPage;

  @override
  List<Object> get props => [items, total, pageNumber, itemCountPerPage];
}
