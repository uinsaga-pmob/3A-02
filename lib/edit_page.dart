import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget{
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _namaC = TextEditingController(text: "Biru Samudra");
  final TextEditingController _emailC = TextEditingController(text: "birusamudra@gmail.com");
  final TextEditingController _bioC = TextEditingController(text: "Bahagia dengan hal-hal kecil");
  final TextEditingController _hobiC = TextEditingController(text: "Membaca, Journaling, Mendengarkan musik");

  String? fotoPath = "assets/images/profil.png";
  final ImagePicker _picker = ImagePicker();

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
        print("EditPage fotoPath $fotoPath");
      });
    }
  }

  void _simpan() {
    Navigator.pop(context, {
      "nama": _namaC.text,
      "email":_emailC.text,
      "bio": _bioC.text,
      "hobi": _hobiC.text,
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


  /* void _editFoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ubah foto belum diaktifkan",
      style: TextStyle(color: Colors.blue),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton( 
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          "Edit profil",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton( 
          icon: Icon(Icons.check, color: Colors.blue),
          onPressed: _simpan,
          ),
        ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _editFoto,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _buildFotoImage(),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ubah foto',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildLabel('Username'),
                _buildField(_namaC),
                const SizedBox(height: 16),

                _buildLabel('Email'),
                _buildField(_emailC,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),

                _buildLabel('Bio'),
                _buildField(_bioC, maxLines: 2),
                const SizedBox(height: 16),

                _buildLabel('Hobi'),
                _buildField(_hobiC, maxLines: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildField(
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}