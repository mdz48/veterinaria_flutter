import 'package:veterinaria/features/users/data/datasources/remote/model/user_model.dart';
import 'package:veterinaria/features/users/domain/entities/user.dart';

extension UserModelMapper on UserModel {
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String?,
      lastName: map['lastName'] as String?,
      email: map['email'] as String? ?? '',
      role: map['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'role': role,
    };
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      role: role,
    );
  }
}
