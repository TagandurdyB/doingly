import '/presentation/views/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/pages/disconnect_page.dart';
import '../../presentation/views/pages/home_page.dart';
import '../../presentation/views/pages/logo_page.dart';
import '../../presentation/views/pages/register_page.dart';

class Rout {
  static const String logo = "/";
  static const String home = "/HomePage";
  static const String disconnect = "/PageDisconnect";
  static const String register = "/RegisterPage";
  static const String login = "/LoginPage";

  static Map<String, Widget Function(dynamic)> pages = {
    logo: (context) => const LogoPage(),
    home: (context) =>  const HomePage(),
    register: (context) =>  RegisterPage(),
    login: (context) =>  LoginPage(),
    disconnect: (context) => PageDisconnect(),
  };
}
