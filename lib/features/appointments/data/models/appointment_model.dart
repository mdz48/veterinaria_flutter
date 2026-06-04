class AppointmentModel {
  final String id;
  final String userId;
  final String petName;
  final DateTime date;
  final String reason;
  final String status;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.petName,
    required this.date,
    required this.reason,
    required this.status,
  });
}
