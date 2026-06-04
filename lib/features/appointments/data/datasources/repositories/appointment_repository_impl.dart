import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veterinaria/features/appointments/data/datasources/remote/mapper/appointment_mapper.dart';
import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';
import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final FirebaseFirestore _firestore;

  AppointmentRepositoryImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final docRef = _firestore.collection('appointments').doc();
      final newAppointment = Appointment(
        id: docRef.id,
        userId: appointment.userId,
        petName: appointment.petName,
        date: appointment.date,
        reason: appointment.reason,
        status: appointment.status,
      );

      final model = newAppointment.toModel();
      await docRef.set(model.toJson());
      return newAppointment;
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }
}
