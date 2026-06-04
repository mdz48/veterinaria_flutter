import 'package:veterinaria/features/users/domain/entities/user.dart';
import 'package:veterinaria/features/users/domain/repositories/user_repository.dart';
// TODO: Import your remote data source

class UserRepositoryImpl implements UserRepository {
  // final UserRemoteDataSource remoteDataSource;
  // UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    // 1. Llama al data source
    // final userModel = await remoteDataSource.login(email, password);
    // 2. Convierte y retorna
    // return userModel.toEntity();
    
    throw UnimplementedError();
  }

  @override
  Future<bool> register(String email, String password) async {
    // final success = await remoteDataSource.register(email, password);
    // return success;
    
    throw UnimplementedError();
  }
}
