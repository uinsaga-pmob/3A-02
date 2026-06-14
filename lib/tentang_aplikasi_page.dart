import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.menu_book_rounded,
            size: 80,
            color: Color(0xFF2F80ED),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              "My Diary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          const ListTile(
            leading: Icon(Icons.phone_android),
            title: Text("Versi Aplikasi"),
            subtitle: Text("1.0.0"),
          ),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Developer"),
            subtitle: Text("My Diary"),
          ),

          const ListTile(
            leading: Icon(Icons.email),
            title: Text("Email Developer"),
            subtitle: Text("mydiary@gmail.com"),
          ),

          const ListTile(
            leading: Icon(Icons.school),
            title: Text("Program Studi"),
            subtitle: Text("Teknologi Informasi"),
          ),

          const ListTile(
            leading: Icon(Icons.account_balance),
            title: Text("Universitas"),
            subtitle: Text("Universitas Islam Negeri Salatiga"),
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Deskripsi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "My Diary merupakan aplikasi untuk mencatat aktivitas "
              "dan pengalaman sehari-hari dengan fitur favorit, "
              "gambar, serta pengelolaan data pribadi sehingga "
              "pengguna dapat menyimpan momen penting dengan mudah.",
              textAlign: TextAlign.justify,
            ),
          ),

          const SizedBox(height: 20),

          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Kebijakan Privasi"),
            subtitle: Text(
              "Data pengguna disimpan secara lokal pada perangkat "
              "dan tidak dibagikan kepada pihak lain.",
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              "© 2026 My Diary",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}