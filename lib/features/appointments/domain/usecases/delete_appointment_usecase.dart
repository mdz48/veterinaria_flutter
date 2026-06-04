import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';

class DeleteAppointmentUsecase {
  final AppointmentRepository _repository;

  DeleteAppointmentUsecase(this._repository);

  Future<void> execute(String id) {
    return _repository.deleteAppointment(id);
  }
}
