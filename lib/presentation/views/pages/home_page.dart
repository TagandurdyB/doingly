import 'package:flutter/material.dart';

import '../../../config/routes/my_rout.dart';
import '../../../config/vars/constants.dart';
import '../../providers/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lists"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final userDo = UserP.of(context, listen: false);
                userDo.saveStr(Tags.hiveToken, null);
                userDo.saveBool(Tags.hiveIsLogin, false);
                Navigator.popAndPushNamed(context, Rout.login);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(child: Text("Salam")),
    );
  }
}
