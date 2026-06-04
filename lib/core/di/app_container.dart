import 'package:veterinaria/features/users/di/user_module.dart';
class AppContainer {
  late final UserModule userModule;

  AppContainer() {
    _initDependencies();
  }

  void _initDependencies() {
    userModule = UserModule();
  }
}