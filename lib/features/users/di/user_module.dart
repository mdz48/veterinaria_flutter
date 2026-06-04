import 'package:veterinaria/features/users/data/datasources/repositories/user_repository_impl.dart';
import 'package:veterinaria/features/users/domain/repositories/user_repository.dart';
import 'package:veterinaria/features/users/domain/usecases/login_usecase.dart';
import 'package:veterinaria/features/users/domain/usecases/register_usecase.dart';

class UserModule {
  late final UserRepository userRepository;
  late final LoginUsecase loginUsecase;
  late final RegisterUsecase registerUsecase;
  UserModule() {
    // final userRemoteDataSource = UserRemoteDataSourceImpl(apiClient);

    // Inyectamos el data source al repositorio
    userRepository = UserRepositoryImpl();
    loginUsecase = LoginUsecase(userRepository);
    registerUsecase = RegisterUsecase(userRepository);
  }
}
