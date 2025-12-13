import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_3a_02/beranda_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => const BerandaPage()),
        );
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF5FB9E3)],
           ),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 300,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
