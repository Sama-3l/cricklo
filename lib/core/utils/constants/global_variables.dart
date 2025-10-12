import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static UserEntity? _user;

  static GlobalKey<NavigatorState>? _navigatorKey;

  static UserEntity? get user => _user;

  static GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  static void setUser(UserEntity? user) {
    _user = user;
  }

  static void setNavigatorKey(GlobalKey<NavigatorState>? navigatorKey) {
    _navigatorKey = navigatorKey;
  }
}
