import 'package:flutter/material.dart';
import 'package:app_3a_02/beranda_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/database/db_helper.dart';

class Diary1Page extends StatefulWidget {
  final DiaryItem item;

  const Diary1Page({super.key, required this.item});

  @override
  State<Diary1Page> createState() => _Diary1PageState();
}

class _Diary1PageState extends State<Diary1Page> {
  late TextEditingController _judulC;
  late TextEditingController _isiC;

  @override
  void initState() {
    super.initState();
    _judulC = TextEditingController(text: widget.item.judul);
    _isiC = TextEditingController(text: widget.item.isi);
  }

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

    final updatedItem = DiaryItem(
      id: widget.item.id,
      judul: _judulC.text.trim(),
      isi: _isiC.text.trim(),
      tanggal: widget.item.tanggal,
    );

    await DBHelper.instance.updateDiary(updatedItem);
    Navigator.pop(context, true);
  }

  Future<void> _hapus() async {
    if (widget.item.id != null) {
      await DBHelper.instance.deleteDiary(widget.item.id!);
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.blue),
          title: const Text(
            'Detail Diary',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: _hapus,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
            IconButton(
              onPressed: _simpan,
              icon: const Icon(Icons.check, color: Colors.blue),
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
