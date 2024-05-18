class EndPoints {
  static const String baseUrl = 'https://api.malnokhba.qa/';
  static const String auth = '${baseUrl}auth/';
  static const String getCurrentUser = '${auth}me';
  static const String refreshToken = '${auth}refresh';
  static const String login = '${auth}login';
}
