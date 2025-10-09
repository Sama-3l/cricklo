import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

class GlobalVariables {
  static UserEntity? _user;

  static UserEntity? get user => _user;

  static void setUser(UserEntity? user) {
    _user = user;
  }
}
