import 'package:flutter/material.dart';
import 'package:veterinaria/core/di/app_container.dart';
import 'package:veterinaria/features/users/presentation/pages/login_page.dart';
import 'package:veterinaria/theme/theme.dart';

class App extends StatelessWidget {
  final AppContainer container;

  const App({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    MaterialTheme myTheme = MaterialTheme(myTextTheme);
    return MaterialApp(
      title: 'Veterinaria',
      theme: myTheme.light(),
      darkTheme: myTheme.dark(),
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
