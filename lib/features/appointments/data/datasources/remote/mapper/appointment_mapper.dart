import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veterinaria/features/appointments/data/models/appointment_model.dart';
import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';

extension AppointmentModelMapper on AppointmentModel {
  static AppointmentModel fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      petName: map['petName'] as String? ?? '',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      reason: map['reason'] as String? ?? '',
      status: map['status'] as String? ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'petName': petName,
      'date': Timestamp.fromDate(date),
      'reason': reason,
      'status': status,
    };
  }

  Appointment toEntity() {
    return Appointment(
      id: id,
      userId: userId,
      petName: petName,
      date: date,
      reason: reason,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => AppointmentStatus.pending,
      ),
    );
  }
}

extension AppointmentEntityMapper on Appointment {
  AppointmentModel toModel() {
    return AppointmentModel(
      id: id,
      userId: userId,
      petName: petName,
      date: date,
      reason: reason,
      status: status.name,
    );
  }
}
