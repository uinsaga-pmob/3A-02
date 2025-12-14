import 'package:flutter/material.dart';
import 'package:app_3a_02/beranda_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

class BuatPage extends StatefulWidget {
  const BuatPage({super.key});

  @override
  State<BuatPage> createState() => _BuatPageState();
}

class _BuatPageState extends State<BuatPage> {
  final TextEditingController _judulC = TextEditingController();
  final TextEditingController _isiC = TextEditingController();

  void _simpan() {
    if (_judulC.text.trim().isEmpty && _isiC.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }

    final diary = DiaryItem(
      judul: _judulC.text.isEmpty ? "Diary Baru" : _judulC.text,
      isi: _isiC.text,
      tanggal: "Hari ini",
    );

    Navigator.pop(context, diary);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Buat Diary",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.blue),
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
              colors: [Colors.white, Color(0xFF5FB9E3)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: _judulC,
                  decoration: const InputDecoration(
                    labelText: "Judul diary",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: TextField(
                    controller: _isiC,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Tulis diary di sini...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
