class UserEntity {
  final String name;
  final String? email;
  final String pass;

  UserEntity({
    required this.name,
    required this.pass,
    this.email,
  });
}
