import 'package:flutter/material.dart';
import 'package:veterinaria/features/appointments/presentation/pages/create_appointment_page.dart';
import 'package:veterinaria/features/appointments/presentation/providers/appointments_provider.dart';
import 'package:provider/provider.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppointmentsProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Citas')),
      body: const Center(child: Text('Lista de citas (por implementar)')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateAppointmentPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
