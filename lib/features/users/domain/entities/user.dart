class User {
  final String id;
  final String? name;
  final String? lastName;
  final String email;
  final String? password;
  final String? role;

  User({
    required this.id,
    this.name,
    this.lastName,
    required this.email,
    this.password,
    this.role,
  });
}
