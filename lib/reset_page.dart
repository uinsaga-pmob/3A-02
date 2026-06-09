import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_3a_02/database/db_helper.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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

  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty ||
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

    final success = await DBHelper.instance.resetPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password berhasil diubah")));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Email tidak ditemukan")));
    }
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
                        "Reset Sandi",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF162B5B),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Masukkan email dan\npassword baru kamu.",
                        style: TextStyle(color: Colors.black54, height: 1.5),
                      ),

                      SizedBox(height: size.height * 0.04),

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
                          hint: "Password Baru",
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
                          onPressed: resetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F80ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Simpan",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),

                      const Spacer(),

                      Center(
                        child: Text(
                          "Pastikan email sudah terdaftar",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
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
