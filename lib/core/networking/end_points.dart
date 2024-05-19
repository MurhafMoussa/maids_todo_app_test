class EndPoints {
  static const String baseUrl = 'https://dummyjson.com/';
  static const String auth = '${baseUrl}auth/';
  static const String todos = '${baseUrl}todos/';
  static const String getCurrentUser = '${auth}me';
  static const String refreshToken = '${auth}refresh';
  static const String login = '${auth}login';
}
