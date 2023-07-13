import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routes/my_rout.dart';
import 'config/services/my_orientation.dart';
import 'config/themes/my_theme.dart';
import 'config/vars/constants.dart';
import 'injector.dart';
import 'presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Tags.hiveBase);
  MyOrientation.systemUiOverlayStyle();
  runApp(const Injector(router: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final providerT = ThemeP.of(context, listen: false);
      providerT.getIsSystem;
      providerT.getIsLight;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).platformBrightness;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doingly',
      themeMode: ThemeP.of(context).mode,
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      routes: Rout.pages,
      initialRoute: Rout.logo,
    );
  }
}
