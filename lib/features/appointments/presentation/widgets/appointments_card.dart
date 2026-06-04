import 'package:flutter/material.dart';
import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart';

class AppointmentsCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AppointmentsCard({
    Key? key,
    required this.appointment,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mascota: ${appointment.petName}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Fecha: ${appointment.date.toLocal()}'.split('.')[0]),
                  const SizedBox(height: 4),
                  Text('Motivo: ${appointment.reason}'),
                  const SizedBox(height: 8),
                  Text(
                    'Estado: ${appointment.status.name}',
                    style: TextStyle(
                      color: appointment.status == AppointmentStatus.confirmed ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            if (onEdit != null || onDelete != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}