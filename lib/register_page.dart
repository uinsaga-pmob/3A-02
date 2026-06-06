import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (namaController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field harus diisi")));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak sesuai")),
      );
      return;
    }

    try {
      await DBHelper.instance.registerUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Akun berhasil dibuat")));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Email sudah digunakan")));
    }
  }

  InputDecoration customInput({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF2F80ED)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: [
            // DAUN PALING BAWAH
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Image.asset(
                  "assets/images/leaf_bottom.png",
                  height: 270,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Buat Akun",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF162B5B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Buat akun untuk mulai\nmenulis di MyDiary.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 32),

                  TextField(
                    controller: namaController,
                    decoration: customInput(
                      hint: "Nama Lengkap",
                      icon: Icons.person_outline,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: emailController,
                    decoration: customInput(
                      hint: "Email",
                      icon: Icons.email_outlined,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: customInput(
                      hint: "Password",
                      icon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: confirmPasswordController,
                    obscureText: hideConfirmPassword,
                    decoration: customInput(
                      hint: "Konfirmasi Password",
                      icon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          hideConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F80ED),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Sudah punya akun? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Masuk",
                            style: TextStyle(
                              color: Color(0xFF2F80ED),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 180),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
