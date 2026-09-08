import 'package:flutter/material.dart';
import 'package:veterinaria/features/appointments/presentation/pages/create_appointment_page.dart';
import 'package:veterinaria/features/appointments/presentation/pages/edit_appointment_page.dart';
import 'package:veterinaria/features/appointments/presentation/providers/appointments_provider.dart';
import 'package:veterinaria/features/appointments/presentation/providers/delete_appointment_provider.dart';
import 'package:provider/provider.dart';
import 'package:veterinaria/features/users/presentation/providers/login_provider.dart';
import 'package:veterinaria/features/appointments/presentation/widgets/appointments_card.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<LoginProvider>().user?.id;
      if (userId != null) {
        context.read<AppointmentsProvider>().loadAppointments(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppointmentsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Citas')),
      body: _buildBody(provider),
      floatingActionButton: Semantics(
        identifier: 'create_appointment_fab',
        label: 'Crear cita',
        child: FloatingActionButton(
          key: const Key('create_appointment_fab'),
          tooltip: 'Crear cita',
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateAppointmentPage()),
            );
            if (!context.mounted) return;
            final userId = context.read<LoginProvider>().user?.id;
            if (userId != null) {
              context.read<AppointmentsProvider>().loadAppointments(userId);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildBody(AppointmentsProvider provider) {
    if (provider.status == AppointmentsListStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (provider.status == AppointmentsListStatus.error) {
      return Center(child: Text('Error: ${provider.error}'));
    } else if (provider.appointments.isEmpty) {
      return const Center(child: Text('No hay citas registradas.'));
    }

    return ListView.builder(
      itemCount: provider.appointments.length,
      itemBuilder: (context, index) {
        final appointment = provider.appointments[index];
        return AppointmentsCard(
          appointment: appointment,
          onEdit: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditAppointmentPage(appointment: appointment),
              ),
            );
            
            if (result == true && context.mounted) {
              final userId = context.read<LoginProvider>().user?.id;
              if (userId != null) {
                context.read<AppointmentsProvider>().loadAppointments(userId);
              }
            }
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Eliminar Cita'),
                content: const Text('¿Está seguro de que desea eliminar esta cita?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );

            if (confirm == true && context.mounted) {
              await context.read<DeleteAppointmentProvider>().deleteAppointment(appointment.id);
              if (!context.mounted) return;
              
              final deleteProvider = context.read<DeleteAppointmentProvider>();
              if (deleteProvider.status == DeleteAppointmentStatus.success) {
                final userId = context.read<LoginProvider>().user?.id;
                if (userId != null) {
                  context.read<AppointmentsProvider>().loadAppointments(userId);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cita eliminada correctamente')),
                );
              } else if (deleteProvider.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${deleteProvider.error}')),
                );
              }
            }
          },
        );
      },
    );
  }
}
