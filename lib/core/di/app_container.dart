import 'package:veterinaria/core/network/veterinaria_firebase.dart';
import 'package:veterinaria/features/appointments/di/appointment_module.dart';
import 'package:veterinaria/features/users/di/user_module.dart';

class AppContainer {
  late final VeterinariaFirebase firebase;
  late final UserModule userModule;
  late final AppointmentModule appointmentModule;

  AppContainer() {
    _initDependencies();
  }

  void _initDependencies() {
    firebase = VeterinariaFirebase();
    userModule = UserModule(firebase: firebase);
    appointmentModule = AppointmentModule(firebase: firebase);
  }
}