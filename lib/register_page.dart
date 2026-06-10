import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Semua field harus diisi")),
    );
    return;
  }

  // Password harus tepat 8 karakter
  if (passwordController.text.trim().length != 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password harus tepat 8 karakter"),
      ),
    );
    return;
  }

  // Konfirmasi password harus tepat 8 karakter
  if (confirmPasswordController.text.trim().length != 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Konfirmasi password harus tepat 8 karakter"),
      ),
    );
    return;
  }

  // Password dan konfirmasi harus sama
  if (passwordController.text != confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Konfirmasi password tidak sesuai"),
      ),
    );
    return;
  }

  try {
    await DBHelper.instance.registerUser(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Akun berhasil dibuat")),
    );

    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email sudah digunakan")),
    );
  }
}

  InputDecoration customInput({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,

      filled: true,
      fillColor: Colors.white,

      prefixIcon: Icon(icon, color: Colors.grey.shade700, size: 24),

      suffixIcon: suffixIcon,

      contentPadding: const EdgeInsets.symmetric(vertical: 18),

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2F80ED), width: 1.5),
      ),

      hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.9,
                    child: Image.asset(
                      "assets/images/leaf_bottom.png",
                      width: size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
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

                      SizedBox(height: size.height * 0.02),

                      const Text(
                        "Buat Akun",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF162B5B),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Buat akun untuk mulai\nmenulis di MyDiary.",
                        style: TextStyle(color: Colors.black54, height: 1.5),
                      ),

                      SizedBox(height: size.height * 0.04),

                      TextField(
                        controller: namaController,
                        decoration: customInput(
                          hint: "Nama Lengkap",
                          icon: Icons.person_outline,
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      TextField(
                        controller: emailController,
                        decoration: customInput(
                          hint: "Email",
                          icon: Icons.email_outlined,
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        maxLength: 8,
                        inputFormatters: [LengthLimitingTextInputFormatter(8)],
                        decoration: customInput(
                          hint: "Password",
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey.shade700,
                            ),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ).copyWith(counterText: ""),
                      ),

                      SizedBox(height: size.height * 0.02),

                      TextField(
                        controller: confirmPasswordController,
                        obscureText: hideConfirmPassword,
                        maxLength: 8,
                        inputFormatters: [LengthLimitingTextInputFormatter(8)],
                        decoration: customInput(
                          hint: "Konfirmasi Password",
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            icon: Icon(
                              hideConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey.shade700,
                            ),
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                          ),
                        ).copyWith(counterText: ""),
                      ),

                      SizedBox(height: size.height * 0.03),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F80ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Daftar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),

                      const Spacer(),

                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Sudah punya akun? ",
                              style: TextStyle(color: Colors.black54),
                            ),
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

                      SizedBox(height: size.height * 0.02),
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
