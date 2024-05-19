import 'package:maids_todo_app_test/core/params/base_params.dart';

class PageParam extends BaseParams {
  PageParam({
    required this.skip,
    required this.pageLength,
  });
  final int skip;
  final int pageLength;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'skip': skip,
      'limit': pageLength,
    };
  }
}
