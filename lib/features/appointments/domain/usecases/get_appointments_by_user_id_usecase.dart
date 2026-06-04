import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';
import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';

class GetAppointmentsByUserIdUsecase {
  final AppointmentRepository _repository;

  GetAppointmentsByUserIdUsecase(this._repository);

  Future<List<Appointment>> call(String userId) {
    return _repository.getAppointmentsbyUserId(userId);
  }
}
