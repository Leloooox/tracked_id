import 'dart:async';
import 'package:flutter/material.dart';

import 'Missing/Missing_Persons.dart';

class WelcomeHomePage extends StatefulWidget {
  const WelcomeHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeHomePageState createState() => _WelcomeHomePageState();
}

class _WelcomeHomePageState extends State<WelcomeHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        seconds: 10,
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const missingChildrenScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff112031),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/welcome.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Text(
                        'انضم إلينا و ساعدنا في جهودنا لإيجاد الأطفال المفقودين وتوفير بيئة آمنة لهم.',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Text(
              'جميع الحقوق محفوظة © 2023 Track ID',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
