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
  final TextEditingController _namaC =
      TextEditingController();

  final TextEditingController _emailC =
      TextEditingController();

  final TextEditingController _bioC =
      TextEditingController();

  final TextEditingController _hobiC =
      TextEditingController();

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
    final XFile? picked =
        await _picker.pickImage(
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
    if (_namaC.text.trim().isEmpty ||
        _emailC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Nama dan email wajib diisi',
          ),
        ),
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
      return FileImage(
        File(fotoPath!),
      );
    }

    return const AssetImage(
      "assets/images/profil.png",
    );
  }

  Widget _buildLabel(String text) {
    return Align(
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
  }

  Widget _buildField(
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType =
        TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          centerTitle: false,

          title: const Text(
            "Edit profil",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          actions: [
            IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.blue,
              ),
              onPressed: _simpan,
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context)
                      .size
                      .height,
            ),

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFF5FB9E3),
                ],
              ),
            ),

            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom:
                    MediaQuery.of(context)
                        .viewInsets
                        .bottom +
                    24,
              ),

              child: Column(
                children: [
                  GestureDetector(
                    onTap: _editFoto,

                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              _buildFotoImage(),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        const Text(
                          'Ubah foto',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight:
                                FontWeight.bold,
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

                  _buildField(
                    _emailC,
                    keyboardType:
                        TextInputType
                            .emailAddress,
                  ),

                  const SizedBox(height: 16),

                  _buildLabel('Bio'),

                  _buildField(
                    _bioC,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 16),

                  _buildLabel('Hobi'),

                  _buildField(
                    _hobiC,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}