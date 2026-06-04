enum AppointmentStatus { pending, confirmed, cancelled }

class Appointment {
  final String id;
  final String userId;
  final String petName;
  final DateTime date;
  final String reason;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.userId,
    required this.petName,
    required this.date,
    required this.reason,
    this.status = AppointmentStatus.pending,
  });
}
