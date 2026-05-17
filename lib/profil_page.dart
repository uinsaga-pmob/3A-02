import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_3a_02/edit_page.dart';
import 'package:app_3a_02/keluar_page.dart';
import 'package:app_3a_02/utils/user_prefs.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() =>
      _ProfilPageState();
}

class _ProfilPageState
    extends State<ProfilPage> {
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
    final data =
        await UserPrefs.getProfile();

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

    return const AssetImage(
      "assets/images/profil.png",
    );
  }

  Widget _buildItem(
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value.isEmpty ? "-" : value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 4),

        Container(
          height: 1,
          color: Colors.white,
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _editProfil() async {
    final result =
        await Navigator.push<
            Map<String, dynamic>>(
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
        email =
            result["email"] ?? email;
        bio = result["bio"] ?? bio;
        hobi = result["hobi"] ?? hobi;
        fotoPath =
            result["fotoPath"] ??
                fotoPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

      child: Scaffold(
        backgroundColor:
            Colors.transparent,

        appBar: AppBar(
          backgroundColor:
              Colors.transparent,
          elevation: 0,

          automaticallyImplyLeading:
              false,

          centerTitle: true,

          title: const Text(
            "Profil",
            style: TextStyle(
              color: Colors.blue,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(
              24,
            ),

            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage:
                      _buildFoto(),
                ),

                const SizedBox(
                  height: 12,
                ),

                Text(
                  nama.isEmpty
                      ? "Belum ada nama"
                      : nama,

                  style:
                      const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed:
                      _editProfil,

                  child: const Text(
                    "Edit profil",
                    style: TextStyle(
                      color:
                          Colors.blue,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    24,
                  ),

                  decoration:
                      BoxDecoration(
                    color: const Color(
                      0xFF5FB9E3,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      28,
                    ),
                  ),

                  child: Column(
                    children: [
                      _buildItem(
                        "Username",
                        nama,
                      ),

                      _buildItem(
                        "Email",
                        email,
                      ),

                      _buildItem(
                        "Bio",
                        bio,
                      ),

                      _buildItem(
                        "Hobi",
                        hobi,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      const KeluarPage(),
                            ),
                          );
                        },

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              30,
                            ),
                          ),

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal:
                                40,
                            vertical:
                                12,
                          ),
                        ),

                        child: const Text(
                          "Keluar akun",

                          style:
                              TextStyle(
                            color: Color(
                              0xFF5FB9E3,
                            ),
                            fontSize: 16,
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
      ),
    );
  }
}