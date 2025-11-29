import 'package:flutter/material.dart';
import 'package:multipage_app1/beranda_page.dart';

class DatangPage extends StatelessWidget {
  const DatangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFF5FB9E3), // biru muda kamu
              ],
            ),
          ),
          padding: const EdgeInsets.all(16.0),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //text judul
                Text(
                  "Selamat Datang di MyDiary",
                  style: TextStyle(fontFamily: "IrishGrover", fontSize: 28),
                ),

                Text(
                  "Tempatmu menulis cerita dengan tenang ^^",
                  style: TextStyle(fontFamily: "IrishGrover", fontSize: 22),
                ),
                SizedBox(height: 200),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BerandaPage()),
                    ),
                  },

                  child: Text(
                    "Selanjutnya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
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
