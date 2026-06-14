import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/utils/user_prefs.dart';

class KeamananPage extends StatefulWidget {
  const KeamananPage({super.key});

  @override
 State<KeamananPage> createState() => _KeamananPageState();
}

class _KeamananPageState extends State<KeamananPage> {
  final TextEditingController passwordLamaController =
      TextEditingController();

  final TextEditingController passwordBaruController =
      TextEditingController();

  final TextEditingController konfirmasiPasswordController =
      TextEditingController();

  bool obscureOld = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  Future<void> simpanPassword() async {
    if (passwordLamaController.text.isEmpty ||
        passwordBaruController.text.isEmpty ||
        konfirmasiPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua data harus diisi"),
        ),
      );
      return;
    }

    final email = await UserPrefs.getCurrentEmail();

    bool benar = await DBHelper.instance.checkPassword(
      email,
      passwordLamaController.text.trim(),
    );

    if (!benar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password lama salah"),
        ),
      );
      return;
    }

    if (passwordBaruController.text.trim().length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password baru harus tepat 8 karakter"),
        ),
      );
      return;
    }

    if (passwordBaruController.text.trim() !=
        konfirmasiPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Konfirmasi password tidak cocok"),
        ),
      );
      return;
    }

    await DBHelper.instance.updatePassword(
      email,
      passwordBaruController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password berhasil diubah"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    passwordLamaController.dispose();
    passwordBaruController.dispose();
    konfirmasiPasswordController.dispose();
    super.dispose();
  }

  Widget inputPassword({
    required String hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        maxLength: 8,
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: toggle,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF2F80ED),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Keamanan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            inputPassword(
              hint: "Password Lama",
              controller: passwordLamaController,
              obscure: obscureOld,
              toggle: () {
                setState(() {
                  obscureOld = !obscureOld;
                });
              },
            ),

            inputPassword(
              hint: "Password Baru",
              controller: passwordBaruController,
              obscure: obscureNew,
              toggle: () {
                setState(() {
                  obscureNew = !obscureNew;
                });
              },
            ),

            inputPassword(
              hint: "Konfirmasi Password Baru",
              controller: konfirmasiPasswordController,
              obscure: obscureConfirm,
              toggle: () {
                setState(() {
                  obscureConfirm = !obscureConfirm;
                });
              },
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: simpanPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F80ED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Simpan Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}