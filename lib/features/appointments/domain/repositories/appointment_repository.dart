import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';

abstract class AppointmentRepository {
  Future<Appointment> createAppointment(Appointment appointment);
}
