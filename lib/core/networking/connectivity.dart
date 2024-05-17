import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Connectivity {
  Future<bool> get isConnected;
}

@LazySingleton(as: Connectivity)
class ConnectivityImpl implements Connectivity {
  ConnectivityImpl({required this.connectionChecker});
  final InternetConnectionChecker connectionChecker;
  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;
}
