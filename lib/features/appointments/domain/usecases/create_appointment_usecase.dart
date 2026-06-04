import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';
import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';

class CreateAppointmentUsecase {
  final AppointmentRepository repository;

  CreateAppointmentUsecase(this.repository);

  Future<Appointment> execute(Appointment appointment) async {
    return await repository.createAppointment(appointment);
  }
}
