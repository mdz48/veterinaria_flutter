import 'package:flutter/foundation.dart';

enum AppointmentsListStatus { initial, loading, success, error }

class AppointmentsProvider with ChangeNotifier {
  AppointmentsListStatus _status = AppointmentsListStatus.initial;
  String? _error;

  AppointmentsListStatus get status => _status;
  String? get error => _error;

  void reset() {
    _status = AppointmentsListStatus.initial;
    _error = null;
    notifyListeners();
  }
}
