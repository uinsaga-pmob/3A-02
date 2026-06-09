import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_3a_02/utils/user_prefs.dart';

class EditPage extends StatefulWidget {
  final String nama;
  final String email;
  final String bio;
  final String hobi;
  final String? fotoPath;

  const EditPage({
    super.key,
    required this.nama,
    required this.email,
    required this.bio,
    required this.hobi,
    this.fotoPath,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _namaC = TextEditingController();

  final TextEditingController _emailC = TextEditingController();

  final TextEditingController _bioC = TextEditingController();

  final TextEditingController _hobiC = TextEditingController();

  String? fotoPath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _namaC.text = widget.nama;
    _emailC.text = widget.email;
    _bioC.text = widget.bio;
    _hobiC.text = widget.hobi;

    fotoPath = widget.fotoPath;
  }

  @override
  void dispose() {
    _namaC.dispose();
    _emailC.dispose();
    _bioC.dispose();
    _hobiC.dispose();
    super.dispose();
  }

  Future<void> _editFoto() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        fotoPath = picked.path;
      });
    }
  }

  Future<void> _simpan() async {
    if (_namaC.text.trim().isEmpty || _emailC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan email wajib diisi')),
      );
      return;
    }

    await UserPrefs.saveProfile(
      nama: _namaC.text.trim(),
      email: _emailC.text.trim(),
      bio: _bioC.text.trim(),
      hobi: _hobiC.text.trim(),
      foto: fotoPath,
    );

    Navigator.pop(context, {
      "nama": _namaC.text.trim(),
      "email": _emailC.text.trim(),
      "bio": _bioC.text.trim(),
      "hobi": _hobiC.text.trim(),
      "fotoPath": fotoPath,
    });
  }

  ImageProvider _buildFotoImage() {
    if (fotoPath != null &&
        fotoPath!.isNotEmpty &&
        !fotoPath!.contains('assets/')) {
      return FileImage(File(fotoPath!));
    }

    return const AssetImage("assets/images/profil.png");
  }

  Widget _modernField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(icon, color: const Color(0xFF2F80ED)),

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Color(0xFF2F80ED), width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B2A57)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Edit Profil",
          style: TextStyle(
            color: Color(0xFF1B2A57),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              // HEADER BIRU
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F8EF7), Color(0xFF2F80ED)],
                  ),
                ),

                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _editFoto,

                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _buildFotoImage(),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),

                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Color(0xFF2F80ED),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Ketuk foto untuk mengganti",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // FORM
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    _modernField(
                      controller: _namaC,
                      label: "Nama",
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 16),

                    _modernField(
                      controller: _emailC,
                      label: "Email",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    _modernField(
                      controller: _bioC,
                      label: "Bio",
                      icon: Icons.article_outlined,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 16),

                    _modernField(
                      controller: _hobiC,
                      label: "Hobi",
                      icon: Icons.favorite_border,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: _simpan,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F80ED),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        child: const Text(
                          "Simpan Perubahan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
