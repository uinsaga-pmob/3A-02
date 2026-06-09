import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_3a_02/edit_page.dart';
import 'package:app_3a_02/keluar_page.dart';
import 'package:app_3a_02/utils/user_prefs.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String nama = "";
  String email = "";
  String bio = "";
  String hobi = "";
  String? fotoPath;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await UserPrefs.getProfile();

    if (!mounted) return;

    setState(() {
      nama = data["nama"] ?? "";
      email = data["email"] ?? "";
      bio = data["bio"] ?? "";
      hobi = data["hobi"] ?? "";
      fotoPath = data["foto"];
    });
  }

  ImageProvider _buildFoto() {
    if (fotoPath != null &&
        fotoPath!.isNotEmpty &&
        !fotoPath!.contains('assets/')) {
      return FileImage(File(fotoPath!));
    }

    return const AssetImage("assets/images/profil.png");
  }

  Future<void> _editProfil() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditPage(
          nama: nama,
          email: email,
          bio: bio,
          hobi: hobi,
          fotoPath: fotoPath,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        nama = result["nama"] ?? nama;
        email = result["email"] ?? email;
        bio = result["bio"] ?? bio;
        hobi = result["hobi"] ?? hobi;
        fotoPath = result["fotoPath"] ?? fotoPath;
      });
    }
  }

  Widget _profileMenu(IconData icon, String title, [String? subtitle]) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),

      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF2F80ED).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF2F80ED)),
      ),

      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),

      subtitle: subtitle != null && subtitle.isNotEmpty ? Text(subtitle) : null,

      trailing: const Icon(Icons.chevron_right),

      onTap: () {},
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Color(0xFF1B2A57),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // HEADER PROFIL
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F8EF7), Color(0xFF2F80ED)],
                  ),
                ),

                child: Row(
                  children: [
                    CircleAvatar(radius: 35, backgroundImage: _buildFoto()),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama.isEmpty ? "Belum Ada Nama" : nama,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            email.isEmpty ? "-" : email,
                            style: const TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            height: 34,
                            child: ElevatedButton.icon(
                              onPressed: _editProfil,

                              icon: const Icon(Icons.edit, size: 16),

                              label: const Text("Edit Profil"),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,

                                foregroundColor: const Color(0xFF2F80ED),

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
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

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ListView(
                    children: [
                      const SizedBox(height: 8),

                      _profileMenu(Icons.person_outline, "Bio", bio),

                      _profileMenu(Icons.favorite_border, "Hobi", hobi),

                      _profileMenu(Icons.lock_outline, "Keamanan"),

                      _profileMenu(Icons.notifications_none, "Notifikasi"),

                      _profileMenu(Icons.palette_outlined, "Tema", "Terang"),

                      _profileMenu(Icons.backup_outlined, "Backup & Restore"),

                      _profileMenu(Icons.info_outline, "Tentang Aplikasi"),

                      const Divider(),

                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),

                        leading: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.logout, color: Colors.red),
                        ),

                        title: const Text(
                          "Keluar",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        trailing: const Icon(Icons.chevron_right),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const KeluarPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                    ],
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
