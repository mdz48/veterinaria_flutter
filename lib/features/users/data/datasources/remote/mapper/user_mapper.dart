import 'package:veterinaria/features/users/data/datasources/remote/model/user_model.dart';
import 'package:veterinaria/features/users/domain/entities/user.dart';

extension UserModelMapper on UserModel {
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
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
