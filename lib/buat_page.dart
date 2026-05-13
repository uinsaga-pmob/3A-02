import 'package:flutter/material.dart';
import 'package:app_3a_02/beranda_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/database/db_helper.dart';

class BuatPage extends StatefulWidget {
  const BuatPage({super.key});

  @override
  State<BuatPage> createState() => _BuatPageState();
}

class _BuatPageState extends State<BuatPage> {
  final TextEditingController _judulC = TextEditingController();
  final TextEditingController _isiC = TextEditingController();

  @override
  void dispose() {
    _judulC.dispose();
    _isiC.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (_judulC.text.trim().isEmpty || _isiC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan isi tidak boleh kosong')),
      );
      return;
    }

    final diary = DiaryItem(
      judul: _judulC.text.trim(),
      isi: _isiC.text.trim(),
      tanggal: 'Hari ini',
    );

    await DBHelper.instance.insertDiary(diary);
    Navigator.pop(context, true);
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
          decoration: const BoxDecoration(
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
                    expands: true,
                    decoration: const InputDecoration(
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
