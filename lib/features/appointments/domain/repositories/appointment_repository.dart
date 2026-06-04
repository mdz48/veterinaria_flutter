import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';

abstract class AppointmentRepository {
  Future<Appointment> createAppointment(Appointment appointment);
  Future<List<Appointment>> getAppointmentsbyUserId(String userId);
  Future<Appointment> updateAppointment(Appointment appointment);
  Future<void> deleteAppointment(String id);
}
