import 'package:veterinaria/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> login(String email, String password);
  Future<bool> register(String email, String password, String name, String lastName);
}
