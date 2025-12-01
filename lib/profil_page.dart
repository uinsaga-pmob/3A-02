import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget{
  const ProfilPage({super.key});

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
      )
    );
  }
}