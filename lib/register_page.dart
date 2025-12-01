import 'package:flutter/material.dart';
import 'package:app_3a_02/datang_page.dart';

class RegisterPage extends StatelessWidget{
  const RegisterPage({super.key});

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 100),
              //text judul
              Text(
                "Buat Akun",
                style: TextStyle(fontFamily: "IrishGrover", fontSize: 30),
              ),
              //field email
              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              //field password
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Sandi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              //teks forgot password
              SizedBox(height: 16),
              //login button
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DatangPage()),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Masuk", style: TextStyle(color: Colors.white)),
              ),

              TextButton(
                onPressed: () => {Navigator.pop(context)}, 
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 8),
                    Text(
                      "Kembali ke halaman login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}