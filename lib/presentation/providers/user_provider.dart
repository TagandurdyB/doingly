import 'package:hive_flutter/hive_flutter.dart';

import '../../config/vars/constants.dart';
import '/domain/entities/user_entity.dart';
import '/domain/usecases/user_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/response_entity.dart';

class UserP extends ChangeNotifier {
  final UserCase userCase;
  UserP({required this.userCase});

  final myBase = Hive.box(Tags.hiveBase);

  Future<ResponseEntity> signUp(UserEntity obj) async {
    final either = await userCase.signUp(obj);
    if (either.isRight) {
      final result = either.right;
      saveStr(Tags.hiveToken, result);
      saveBool(Tags.hiveIsLogin, true);
      return ResponseEntity(status: true, message: "Success");
    }
    return either.left;
  }

  Future<ResponseEntity> login(UserEntity obj) async {
    final either = await userCase.login(obj);
    if (either.isRight) {
      final result = either.right;
      saveStr(Tags.hiveToken, result);
      saveBool(Tags.hiveIsLogin, true);
      return ResponseEntity(status: true, message: "Success");
    }
    return either.left;
  }

  void saveBool(String tag, bool? val) => myBase.put(tag, val);
  void saveStr(String tag, String? val) => myBase.put(tag, val);

  bool? readBool(String tag) => myBase.get(tag);
  bool? readStr(String tag) => myBase.get(tag);

  static UserP of(BuildContext context, {listen = true}) =>
      Provider.of<UserP>(context, listen: listen);
}
