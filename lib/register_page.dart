import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFF5FB9E3)],
            ),
          ),

          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: [
              SizedBox(height: 100),

              // JUDUL
              Text(
                "Buat Akun",
                style: TextStyle(fontFamily: "IrishGrover", fontSize: 30),
              ),

              // FIELD EMAIL
              SizedBox(height: 50),

              TextField(
                controller: emailController,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // FIELD PASSWORD
              SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Sandi",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // BUTTON REGISTER
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Email dan Sandi harus diisi",
                          style: TextStyle(color: Colors.blue),
                        ),

                        backgroundColor: Colors.white,

                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    try {
                      await DBHelper.instance.registerUser(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Akun berhasil dibuat",
                            style: TextStyle(color: Colors.blue),
                          ),

                          backgroundColor: Colors.white,

                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Email sudah digunakan",
                            style: TextStyle(color: Colors.blue),
                          ),

                          backgroundColor: Colors.white,

                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  minimumSize: Size(double.infinity, 50),
                ),

                child: Text("Daftar", style: TextStyle(color: Colors.white)),
              ),

              // BUTTON KEMBALI
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

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
