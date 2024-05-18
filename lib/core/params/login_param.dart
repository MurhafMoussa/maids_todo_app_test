import 'package:json_annotation/json_annotation.dart';
import 'package:maids_todo_app_test/core/params/base_params.dart';

part 'login_param.g.dart';

@JsonSerializable()
class LoginParam extends BaseParams {
  LoginParam({
    required this.expirationDateInMinutes,
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
  @JsonKey(name: 'expiresInMins')
  final int expirationDateInMinutes;

  @override
  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}
