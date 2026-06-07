import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/new_password_page.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final emailController = TextEditingController();

  Future<void> cekEmail() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Masukkan email")));
      return;
    }

    bool exists = await DBHelper.instance.checkEmailExists(email);

    if (!mounted) return;

    if (exists) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NewPasswordPage(email: email)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Email tidak ditemukan")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/leaf_bottom.png",
                fit: BoxFit.cover,
                height: 250,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Reset Sandi",

                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF162B5B),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Masukkan email akun yang terdaftar.",

                    style: TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller: emailController,

                    decoration: InputDecoration(
                      hintText: "Email",

                      prefixIcon: const Icon(Icons.email_outlined),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: cekEmail,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F80ED),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        "Lanjut",

                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
