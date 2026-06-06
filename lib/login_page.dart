import 'package:app_3a_02/beranda_page.dart';
import 'package:flutter/material.dart';
import 'package:app_3a_02/register_page.dart';
import 'package:app_3a_02/reset_page.dart';
import 'package:app_3a_02/database/db_helper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 1,
                    child: Image.asset(
                      "assets/images/leaf_bottom.png",
                      fit: BoxFit.cover,
                      height: 270,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Selamat Datang di",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF1B2A57),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(height: 8),

                                Text(
                                  "MyDiary",
                                  style: TextStyle(
                                    fontFamily: "FrankRuhlLibre",
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1B2A57),
                                  ),
                                ),

                                SizedBox(height: 12),

                                Text(
                                  "Tempat aman untuk menulis\ncerita dan perasaanmu.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Image.asset("assets/images/mydiary.png", width: 120),
                        ],
                      ),

                      const SizedBox(height: 50),

                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: const Icon(Icons.visibility_off),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // pakai kode lupa sandi milikmu
                          },
                          child: const Text(
                            "Lupa sandi?",
                            style: TextStyle(
                              color: Color(0xFF2F80ED),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Email dan Sandi harus diisi"),
                                ),
                              );
                              return;
                            }

                            bool isLoginSuccess = await DBHelper.instance
                                .loginUser(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );

                            if (isLoginSuccess) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BerandaPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Email atau sandi salah"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F80ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Masuk",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterPage()),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(text: "Belum punya akun? "),
                                TextSpan(
                                  text: "Buat akun",
                                  style: TextStyle(
                                    color: Color(0xFF2F80ED),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
