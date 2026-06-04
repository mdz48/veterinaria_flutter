import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinaria/app.dart';
import 'package:veterinaria/core/di/app_container.dart';
import 'package:veterinaria/features/users/presentation/providers/login_provider.dart';
import 'package:device_preview/device_preview.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:veterinaria/features/users/presentation/providers/register_provider.dart';
import 'package:veterinaria/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: DevicePreview(
        enabled: isSkiaWeb,
        builder: (context) => App(container: container),
      ),
    ),
  );
}
