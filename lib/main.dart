import 'package:flutter/material.dart';
import 'package:app_3a_02/login_page.dart';
import 'package:app_3a_02/register_page.dart';
import 'package:app_3a_02/datang_page.dart';
import 'package:app_3a_02/beranda_page.dart';
import 'package:app_3a_02/profil_page.dart';
import 'package:app_3a_02/splashscreen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyDiary",
      home: const SplashPage(),
    );
      
  }
}