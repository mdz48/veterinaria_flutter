class UserModel {
  final String id;
  final String? name;
  final String? lastName;
  final String email;
  final String? role;

  UserModel({
    required this.id,
    this.name,
    this.lastName,
    required this.email,
    this.role,
  });
}
