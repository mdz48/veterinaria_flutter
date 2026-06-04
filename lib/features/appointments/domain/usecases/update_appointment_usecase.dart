import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';
import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';

class UpdateAppointmentUsecase {
  final AppointmentRepository _repository;

  UpdateAppointmentUsecase(this._repository);

  Future<Appointment> execute(Appointment appointment) {
    return _repository.updateAppointment(appointment);
  }
}
