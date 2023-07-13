// ignore_for_file: overridden_fields

import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final String name;
  @override
  final String? email;
  @override
  final String pass;

  UserModel({
    required this.name,
    required this.pass,
    this.email,
  }) : super(name: '', pass: '');

  factory UserModel.fromEntity(UserEntity entity) {
    try {
      return UserModel(
        name: entity.name,
        pass: entity.pass,
        email: entity.email,
      );
    } catch (err) {
      throw ("Error in UserModel>fromEntity : $err");
    }
  }

  Map<String, dynamic> toJsonRegister() => {
        "username": name,
        "password": pass,
        "email": email??"",
      };

    Map<String, dynamic> toJsonLogin() => {
        "username": name,
        "password": pass,
      };
}
