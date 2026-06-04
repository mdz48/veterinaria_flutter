import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veterinaria/features/users/domain/entities/user.dart';
import 'package:veterinaria/features/users/domain/usecases/login_usecase.dart';

enum LoginStatus { initial, loading, success, error }

class LoginProvider with ChangeNotifier {
  final LoginUsecase _loginUsecase;
  LoginProvider(this._loginUsecase);

  LoginStatus _status = LoginStatus.initial;
  String? _error;
  User? _user;

  LoginStatus get status => _status;
  String? get error => _error;
  User? get user => _user;

  Future<void> login(String email, String password) async {
    _status = LoginStatus.loading;
    notifyListeners();

    try {
      _user = await _loginUsecase.execute(email, password);
      _status = LoginStatus.success;
    } catch (_) {
      _status = LoginStatus.error;
    } finally {
      notifyListeners();
    }
  }
}