import 'package:flutter/material.dart';

class AppSnackBar {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey => _scaffoldMessengerKey;

  void showSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}