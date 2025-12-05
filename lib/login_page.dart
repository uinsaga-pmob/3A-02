import 'package:flutter/material.dart';
import 'package:app_3a_02/register_page.dart';
import 'package:app_3a_02/datang_page.dart';
import 'package:app_3a_02/reset_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

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
              Image.asset('assets/images/mydiary.png', width: 140, height: 140),

              SizedBox(height: 20),
              //text judul
              Text(
                "Masuk",
                style: TextStyle(
                  fontFamily: "IrishGrover",
                  fontSize: 28,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              //text desc

              //field email
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
              //field password
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

              //lupa sandi button
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    final TextEditingController resetEmailController = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.lock_reset, color: Colors.blue),
                              SizedBox(width: 8),
                              Text("Lupa Sandi?"),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Masukkan email anda untuk menerima instruksi reset sandi.",
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: resetEmailController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan email",
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Batal"),
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                if (resetEmailController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        "Email harus diisi",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                } else {
                                Navigator.pop(context),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetPage(),
                                  ),
                                ),
                                },
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Text(
                                "Kirim",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  child: Text(
                    "Lupa Sandi?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              //login button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email dan Sandi harus diisi",
                      style: TextStyle(color: Colors.blue),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                      ),
                      ),
                  } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DatangPage()),
                  ),
                  }
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
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  ),
                },
                child: Text(
                  "Tidak punya akun? Daftar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
