import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_3a_02/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
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
            colors: [Color.fromARGB(255, 73, 128, 211), Color(0xFF1B3A6F)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -30,
              left: -20,
              child: Opacity(
                opacity: 0.5,
                child: Icon(
                  Icons.local_florist,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: -20,
              child: Opacity(
                opacity: 0.5,
                child: Icon(
                  Icons.local_florist,
                  size: 150,
                  color: Colors.white,
                ),
              ),
            ),

            Center(child: Image.asset("assets/images/logo.png", width: 180)),
          ],
        ),
      ),
    );
  }
}
