import 'package:veterinaria/core/network/veterinaria_firebase.dart';
import 'package:veterinaria/features/users/data/datasources/repositories/user_repository_impl.dart';
import 'package:veterinaria/features/users/domain/repositories/user_repository.dart';
import 'package:veterinaria/features/users/domain/usecases/login_usecase.dart';
import 'package:veterinaria/features/users/domain/usecases/register_usecase.dart';

class UserModule {
  late final UserRepository userRepository;
  late final LoginUsecase loginUsecase;
  late final RegisterUsecase registerUsecase;

  UserModule({required VeterinariaFirebase firebase}) {
    _initDependencies(firebase);
  }

  void _initDependencies(VeterinariaFirebase firebase) {
    userRepository = UserRepositoryImpl(
      auth: firebase.auth,
      firestore: firebase.firestore,
    );
    loginUsecase = LoginUsecase(userRepository);
    registerUsecase = RegisterUsecase(userRepository);
  }
}
