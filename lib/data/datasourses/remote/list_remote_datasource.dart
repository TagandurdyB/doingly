import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';

import '../../../config/vars/constants.dart';
import '../../models/list_model.dart';
import '../../models/response_model.dart';

import 'package:http/http.dart' as http;

import 'http_vars.dart';

abstract class ListRemoteDataSource {
  Future<ResponseModel> create(String name);
  Future<Either<ResponseModel, List<ListModel>>> read();
  Future<ResponseModel> update(String uuid, String name);
  Future<ResponseModel> delete(String uuid);
}

class ListDataSourceImpl implements ListRemoteDataSource {
  final http.Client httpClient;
  ListDataSourceImpl(this.httpClient);

  final myBase = Hive.box(Tags.hiveBase);
  String? get token => myBase.get(Tags.hiveToken);

  @override
  Future<ResponseModel> create(String name) async {
    print("Url:=${Uris.lists}");
    const where = "ListDataSourceImpl>create";
    return HttpFuncs.tokenChecker(token, where, () async {
      return await httpClient.post(
        Uris.lists,
        headers: Headers.bearer(token!),
        body: {"name": name},
      ).then((response) {
        HttpFuncs.tryerChecker(where, () async {
          Map<String, dynamic> res = json.decode(response.body);
          print("$where response:=$res");
          return HttpFuncs.statusCodeChecker(
            ResponseModel.frowJson(res),
            response.statusCode,
          );
        });
      });
    });
  }

  @override
  Future<Either<ResponseModel, List<ListModel>>> read() async {
    print("Url:=${Uris.lists}");
    const where = "ListDataSourceImpl>read";
    return HttpFuncs.errCatcher(token, where, () async {
      final response = await httpClient.get(
        Uris.lists,
        headers: Headers.bearer(token!),
      );
      List res = json.decode(response.body);
      print("$where response:=$res");
      return HttpFuncs.statusCodeChecker(
        ListModel.fromJsonList(res),
        response.statusCode,
      );
    });
  }

  @override
  Future<ResponseModel> update(String uuid, String name) async {
    print("Url:=${Uris.listChange(uuid)}");
    const where = "ListDataSourceImpl>update";
    return HttpFuncs.tokenChecker(token, where, () async {
      return await httpClient.put(
        Uris.listChange(uuid),
        headers: Headers.bearer(token!),
        body: {"name": name},
      ).then((response) {
        HttpFuncs.tryerChecker(where, () async {
          Map<String, dynamic> res = json.decode(response.body);
          print("$where response:=$res");
          return HttpFuncs.statusCodeChecker(
            ResponseModel.frowJson(res),
            response.statusCode,
          );
        });
      });
    });
  }

  @override
  Future<ResponseModel> delete(String uuid) async {
    print("Url:=${Uris.listChange(uuid)}");
    const where = "ListDataSourceImpl>delete";
    return HttpFuncs.errCatcher(token, where, () async {
      final response = await httpClient.delete(
        Uris.listChange(uuid),
        headers: Headers.bearer(token!),
      );
      Map<String, dynamic> res = json.decode(response.body);
      print("$where response:=$res");
      return HttpFuncs.statusCodeChecker(
        ResponseModel.frowJson(res),
        response.statusCode,
      );
    });
  }
}
