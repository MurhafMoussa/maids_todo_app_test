import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/**
 * This class keeps and handles the logic related to routes
 * It's purpose is to keep all the route logic accessible from a single place
 */
@lazySingleton
class RouteDataHandler extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isSplashDone = false;

  void set isLoggedIn(bool logged) {
    _isLoggedIn = logged;
    notifyListeners();
  }

  bool get isSplashDone => _isSplashDone;

  set isSplashDone(bool done) {
    _isSplashDone = false;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;
}
