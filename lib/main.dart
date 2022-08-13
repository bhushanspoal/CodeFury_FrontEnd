import 'package:codefury_start_up_app/pages/user_homepage.dart';
import 'package:codefury_start_up_app/pages/user_login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email and password login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: User_login_page(),
    );
  }
}
