import 'package:flutter/material.dart';
import 'package:app_3a_02/profil_page.dart';

class KeluarPage extends StatelessWidget{
  const KeluarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFF5FB9E3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}