import 'package:app_3a_02/edit_page.dart';
import 'package:app_3a_02/keluar_page.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget{
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String nama = "Biru Samudra";
  String email = "birusamudra@gmail.com";
  String bio = "Bahagia dengan hal-hal kecil";
  String hobi = "Membaca, Journaling, Mendengarkan musik";
  String fotoPath = "assets/images/profil.png";

  @override
    Widget build(BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF5FB9E3)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,        
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,   
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  SizedBox(height: 40),  
                  ClipOval(
                    child: Image.asset(
                      fotoPath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    nama,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () async {
                      final result = await Navigator.push<Map<String, String>>(
                        context,
                        MaterialPageRoute(builder: (context) =>  EditPage()),
                      );

                      if (result != null) {
                        setState(() {
                          nama = result["nama"] ?? nama;
                          email = result["email"] ?? email;
                          bio = result["bio"] ?? bio;
                          hobi = result["hobi"] ?? hobi;
                          if (result["fotoPath"] != null) {
                            fotoPath = result["fotoPath"]!;
                          }
                        });
                      }
                    },
                    child: Text(
                      "Edit profil",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 350,
                    height: 370,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF5FB9E3),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          nama,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(height: 1, color: Colors.white),

                        SizedBox(height: 3),
                        Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(height: 1, color: Colors.white),

                        SizedBox(height: 3),
                        Text(
                          "Bio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          bio,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(height: 1, color: Colors.white),

                        SizedBox(height: 3),
                        Text(
                          "Hobi",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          hobi,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Container(height: 1, color: Colors.white),
                        SizedBox(height: 40),

                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () => {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => KeluarPage()),
                                ),
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 4,
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(30),
                              ),
                            ),
                            child: Text(
                              "Keluar akun",
                              style: TextStyle(
                                color: Color(0xFF5FB9E3),
                                fontSize: 18,
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
        ),
      );
    }
  }