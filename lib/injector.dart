import 'package:doingly/data/repositories/user_repository.dart';

import '/data/datasourses/remote/user_remote_datasource.dart';

import '/domain/usecases/user_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/repositories/user_repository.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/user_provider.dart';

import 'package:http/http.dart' as http;

class Injector extends StatelessWidget {
  final Widget router;
  const Injector({required this.router, super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          //=======================================
          ChangeNotifierProvider<UserP>(
              create: (_) => UserP(
                    userCase: UserCase(
                        UserRepositoryImpl(UserDataSourceImpl(http.Client()))),
                  )),
          //=======================================
          ChangeNotifierProvider<ThemeP>(create: (context) => ThemeP()),
        ],
        child: router,
      );
}
