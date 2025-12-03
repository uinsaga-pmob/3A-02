import 'package:flutter/material.dart';
import 'package:app_3a_02/beranda_page.dart';

class PerpustakaanPage extends StatelessWidget {
  const PerpustakaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFF5FB9E3)],
            ),
          ),
        ),
      ),
    );
  }
}
