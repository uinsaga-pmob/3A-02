import 'package:flutter/material.dart';
import 'package:app_3a_02/login_page.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Biarkan transparan
        appBar: AppBar(title: Text("Reset Sandi")),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFF5FB9E3), // Gradient sama dengan LoginPage
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, size: 80, color: Colors.blue),
                  SizedBox(height: 20),
                  Text("Instruksi reset sandi telah dikirim ke email Anda!"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Kembali"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
