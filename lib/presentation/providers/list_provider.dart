import '../../domain/entities/response_entity.dart';
import '/config/services/tost_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/list_entity.dart';
import '/domain/usecases/list_case.dart';

class ListP extends ChangeNotifier {
  final ListCase listCase;
  ListP({required this.listCase});

  Future<ResponseEntity> create(String name) async {
    if (name != "") {
      return await listCase.create(name);
    }
    return ResponseEntity(status: false, message: "List name cannot be empty");
  }

  Future<ResponseEntity> update(String uuid, String name) async {
    if (name != "") {
      return await listCase.update(uuid, name);
    }
    return ResponseEntity(status: false, message: "List name cannot be empty");
  }

  Future<ResponseEntity> delete(String uuid) async {
    if (uuid != "") {
      return await listCase.delete(uuid);
    }
    return ResponseEntity(status: false, message: "List Uuid not found!");
  }

  List<ListEntity>? lists ;
  Future<void> fillLists() async {
    try {
      lists =null;
      notifyListeners();
      final either = await listCase.read();
      if (either.isRight) {
        lists = either.right;
        notifyListeners();
      } else {
        final response = either.left;
        TostService.message(response.message, response.status);
      }
    } catch (err) {
      throw "ListP>fillLists ERROR : $err";
    }
  }

  static ListP of(BuildContext context, {listen = true}) =>
      Provider.of<ListP>(context, listen: listen);
}
