import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinaria/app.dart';
import 'package:veterinaria/core/di/app_container.dart';
import 'package:veterinaria/features/users/presentation/providers/login_provider.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = AppContainer();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(container.userModule.loginUsecase),
        ),
      ],
      child: DevicePreview(
        enabled: isSkiaWeb,
        builder: (context) => App(container: container),
      ),
    ),
  );
}
