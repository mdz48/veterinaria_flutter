import 'package:flutter/foundation.dart';
import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';
import 'package:veterinaria/features/appointments/domain/usecases/create_appointment_usecase.dart';

enum AppointmentStatus { initial, loading, success, error }

class CreateAppointmentProvider with ChangeNotifier {
  final CreateAppointmentUsecase _createAppointmentUsecase;

  CreateAppointmentProvider(this._createAppointmentUsecase);

  AppointmentStatus _status = AppointmentStatus.initial;
  String? _error;

  AppointmentStatus get status => _status;
  String? get error => _error;

  Future<void> createAppointment(Appointment appointment) async {
    _status = AppointmentStatus.loading;
    _error = null;
    notifyListeners();

    try {
      await _createAppointmentUsecase.execute(appointment);
      _status = AppointmentStatus.success;
    } catch (e) {
      _status = AppointmentStatus.error;
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _status = AppointmentStatus.initial;
    _error = null;
    notifyListeners();
  }
}
