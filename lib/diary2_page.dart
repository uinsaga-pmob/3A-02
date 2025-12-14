import 'package:flutter/material.dart';
import 'package:app_3a_02/beranda_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

String formatSelisihHari(DateTime tanggal) {
  final now = DateTime.now();
  final selisih = now.difference(tanggal).inDays;

  if (selisih <= 0) return "Hari ini";
  if (selisih == 1) return "2 hari yang lalu";
  return "$selisih hari yang lalu";
}

class Diary2Page extends StatefulWidget {
  final DiaryItem item;

  const Diary2Page({super.key, required this.item});

  @override
  State<Diary2Page> createState() => _Diary2PageState();
}

class _Diary2PageState extends State<Diary2Page> {
  late TextEditingController _judulC;
  late TextEditingController _isiC;

  @override
  void initState() {
    super.initState();
    _judulC = TextEditingController(text: widget.item.judul);
    _isiC = TextEditingController(text: widget.item.isi);
  }

  void _simpan() {
    final updated = DiaryItem(
      judul: _judulC.text.isEmpty ? widget.item.judul : _judulC.text,
      isi: _isiC.text,
      tanggal: widget.item.tanggal,
    );
    Navigator.pop(context, updated);
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Diary 2",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "2 hari yang lalu",
                style: TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
            ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _judulC,
                  decoration: const InputDecoration(
                    labelText: "Judul Diary",
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
                    decoration: const InputDecoration(
                      hintText: "Tulis diary disini...",
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
