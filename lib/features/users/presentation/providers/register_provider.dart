import 'package:flutter/foundation.dart';
import 'package:veterinaria/features/users/domain/usecases/register_usecase.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterProvider with ChangeNotifier {
  final RegisterUsecase _registerUsecase;
  RegisterProvider(this._registerUsecase);

  RegisterStatus _status = RegisterStatus.initial;
  String? _error;

  RegisterStatus get status => _status;
  String? get error => _error;

  Future<void> register(String email, String password, String name, String lastName) async {
    _status = RegisterStatus.loading;
    _error = null;
    notifyListeners();

    try {
      final success = await _registerUsecase.execute(email, password, name, lastName);
      if (success) {
        _status = RegisterStatus.success;
      } else {
        _status = RegisterStatus.error;
        _error = 'No se pudo crear la cuenta';
      }
    } catch (e) {
      _status = RegisterStatus.error;
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _status = RegisterStatus.initial;
    _error = null;
    notifyListeners();
  }
}
