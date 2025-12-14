import 'package:flutter/material.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/buat_page.dart';
import 'package:app_3a_02/diary1_page.dart';
import 'package:app_3a_02/diary2_page.dart';
import 'package:app_3a_02/diary3_page.dart';

class PerpustakaanPage extends StatefulWidget {
  const PerpustakaanPage({super.key});

  @override
  State<PerpustakaanPage> createState() => _PerpustakaanPageState();
}

class _PerpustakaanPageState extends State<PerpustakaanPage> {
  // diary bawaan (Diary 1–3)
  final List<DiaryItem> _riwayat = [
    DiaryItem(judul: 'Diary 1', isi: '', tanggal: '1 hari yang lalu'),
    DiaryItem(judul: 'Diary 2', isi: '', tanggal: '2 hari yang lalu'),
    DiaryItem(judul: 'Diary 3', isi: '', tanggal: '3 hari yang lalu'),
  ];

  // diary baru yang dibuat dari BuatPage
  final List<DiaryItem> _diaryBaru = [];

  Future<void> _bukaBuatDiary() async {
    // BuatPage sebaiknya mengembalikan DiaryItem lewat Navigator.pop(context, item);
    final hasil = await Navigator.push<DiaryItem>(
      context,
      MaterialPageRoute(builder: (_) => const BuatPage()),
    );

    if (hasil != null) {
      setState(() {
        _diaryBaru.insert(0, hasil);
      });
    }
  }

  Future<void> _bukaDiaryRiwayat(int index) async {
    final item = _riwayat[index];

    Widget page;
    if (item.judul == 'Diary 1') {
      page = Diary1Page(item: item);
    } else if (item.judul == 'Diary 2') {
      page = Diary2Page(item: item);
    } else {
      page = Diary3Page(item: item);
    }

    final hasil = await Navigator.push<DiaryItem>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );

    if (hasil != null) {
      setState(() {
        _riwayat[index] = hasil;
      });
    }
  }

  Future<void> _bukaDiaryBaru(int index) async {
    final item = _diaryBaru[index];

    // bisa pakai satu halaman detail generik, di sini contoh pakai Diary1Page
    final hasil = await Navigator.push<DiaryItem>(
      context,
      MaterialPageRoute(builder: (_) => Diary1Page(item: item)),
    );

    if (hasil != null) {
      setState(() {
        _diaryBaru[index] = hasil;
      });
    }
  }

  Widget _buildCard({
    required String judul,
    required String tanggal,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF5FB9E3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                judul,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                tanggal,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Perpustakaan',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: _bukaBuatDiary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5FB9E3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Buat Diary Baru'),
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Riwayat Diary',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                for (int i = 0; i < _riwayat.length; i++)
                  _buildCard(
                    judul: _riwayat[i].judul,
                    tanggal: _riwayat[i].tanggal,
                    onTap: () => _bukaDiaryRiwayat(i),
                  ),

                const SizedBox(height: 24),
                const Text(
                  'Diary Baru',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                if (_diaryBaru.isEmpty)
                  const Text(
                    'Belum ada diary baru',
                    style: TextStyle(color: Colors.blueGrey),
                  )
                else
                  for (int i = 0; i < _diaryBaru.length; i++)
                    _buildCard(
                      judul: _diaryBaru[i].judul,
                      tanggal: _diaryBaru[i].tanggal,
                      onTap: () => _bukaDiaryBaru(i),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
