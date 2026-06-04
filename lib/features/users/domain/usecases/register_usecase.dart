import 'package:veterinaria/features/users/domain/repositories/user_repository.dart';

class RegisterUsecase {
  final UserRepository repository;

  RegisterUsecase(this.repository);

  Future<bool> execute(String email, String password) async {
    return await repository.register(email, password);
  }
}
