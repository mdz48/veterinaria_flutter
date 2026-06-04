import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinaria/features/appointments/domain/entities/appoinment.dart'
    hide AppointmentStatus;
import 'package:veterinaria/features/appointments/presentation/providers/update_appointment_provider.dart';

class EditAppointmentPage extends StatefulWidget {
  final Appointment appointment;

  const EditAppointmentPage({super.key, required this.appointment});

  @override
  State<EditAppointmentPage> createState() => _EditAppointmentPageState();
}

class _EditAppointmentPageState extends State<EditAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _petNameController;
  late TextEditingController _reasonController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _petNameController = TextEditingController(text: widget.appointment.petName);
    _reasonController = TextEditingController(text: widget.appointment.reason);
    _selectedDate = widget.appointment.date;
    _selectedTime = TimeOfDay.fromDateTime(widget.appointment.date);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateAppointmentProvider>().reset();
    });
  }

  @override
  void dispose() {
    _petNameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debe iniciar sesión para editar una cita'),
          ),
        );
        return;
      }

      final combinedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final updatedAppointment = Appointment(
        id: widget.appointment.id,
        userId: widget.appointment.userId,
        petName: _petNameController.text,
        date: combinedDate,
        reason: _reasonController.text,
        status: widget.appointment.status,
      );

      context.read<UpdateAppointmentProvider>().updateAppointment(updatedAppointment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Cita')),
      body: Consumer<UpdateAppointmentProvider>(
        builder: (context, provider, child) {
          if (provider.status == UpdateAppointmentStatus.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context, true);
            });
          }

          if (provider.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${provider.error}')),
              );
              provider.reset();
            });
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _petNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la Mascota',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre de la mascota';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text('Fecha: ${_selectedDate.toLocal()}'.split(' ')[0]),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text('Hora: ${_selectedTime.format(context)}'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () => _selectTime(context),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Motivo de la Cita',
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el motivo de la cita';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: provider.status == UpdateAppointmentStatus.loading
                        ? null
                        : _submit,
                    child: provider.status == UpdateAppointmentStatus.loading
                        ? const CircularProgressIndicator()
                        : const Text('Guardar Cambios'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
