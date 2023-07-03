import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Account/Login_Page.dart';
import 'Missing/Missing_Persons.dart';
import 'WelcomeHomePage.dart';
import 'WelcomeLoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Missing Persons',
      initialRoute: token != null ? '/welcomeHome' : '/welcomeLogin',
      getPages: [
        GetPage(
          name: '/welcomeLogin',
          page: () => const WelcomeLoginPage(),
        ),
        GetPage(
          name: '/welcomeHome',
          page: () => const WelcomeHomePage(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/home',
          page: () => const missingChildrenScreen(),
        ),
      ],
    );
  }
}
