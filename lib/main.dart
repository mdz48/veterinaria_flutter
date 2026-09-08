import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:provider/provider.dart';
import 'package:veterinaria/app.dart';
import 'package:veterinaria/core/di/app_container.dart';
import 'package:veterinaria/features/appointments/presentation/providers/appointments_provider.dart';
import 'package:veterinaria/features/appointments/presentation/providers/create_appointment_provider.dart';
import 'package:veterinaria/features/appointments/presentation/providers/update_appointment_provider.dart';
import 'package:veterinaria/features/appointments/presentation/providers/delete_appointment_provider.dart';
import 'package:veterinaria/features/users/presentation/providers/login_provider.dart';
import 'package:device_preview/device_preview.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:veterinaria/features/users/presentation/providers/register_provider.dart';
import 'package:veterinaria/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = AppContainer();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(container.userModule.loginUsecase),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              RegisterProvider(container.userModule.registerUsecase),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentsProvider(
            container.appointmentModule.getAppointmentsByUserIdUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateAppointmentProvider(
            container.appointmentModule.createAppointmentUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UpdateAppointmentProvider(
            container.appointmentModule.updateAppointmentUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DeleteAppointmentProvider(
            container.appointmentModule.deleteAppointmentUsecase,
          ),
        ),
      ],
      child: DevicePreview(
        enabled: kIsWeb,
        builder: (context) => App(container: container),
      ),
    ),
  );
}
