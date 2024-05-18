import 'package:maids_todo_app_test/core/params/base_params.dart';

class PageParam extends BaseParams {
  PageParam({
    this.page,
    this.pageLength,
  });
  final int? page;
  final int? pageLength;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (page != null) 'page': page,
      if (pageLength != null) 'pageLength': pageLength,
    };
  }
}
