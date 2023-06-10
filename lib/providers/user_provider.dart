import 'package:flutter/material.dart';
import 'package:mad_ccp/models/user_model.dart';
import 'package:mad_ccp/utils/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel? get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
