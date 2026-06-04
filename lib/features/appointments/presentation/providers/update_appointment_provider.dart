import 'package:flutter/foundation.dart';
import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';
import 'package:veterinaria/features/appointments/domain/usecases/update_appointment_usecase.dart';

enum UpdateAppointmentStatus { initial, loading, success, error }

class UpdateAppointmentProvider with ChangeNotifier {
  final UpdateAppointmentUsecase _updateAppointmentUsecase;

  UpdateAppointmentProvider(this._updateAppointmentUsecase);

  UpdateAppointmentStatus _status = UpdateAppointmentStatus.initial;
  String? _error;

  UpdateAppointmentStatus get status => _status;
  String? get error => _error;

  Future<void> updateAppointment(Appointment appointment) async {
    _status = UpdateAppointmentStatus.loading;
    _error = null;
    notifyListeners();

    try {
      await _updateAppointmentUsecase.execute(appointment);
      _status = UpdateAppointmentStatus.success;
    } catch (e) {
      _status = UpdateAppointmentStatus.error;
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _status = UpdateAppointmentStatus.initial;
    _error = null;
    notifyListeners();
  }
}
