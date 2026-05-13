import 'package:flutter/material.dart';
import 'package:app_3a_02/buat_page.dart';
import 'package:app_3a_02/diary1_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/database/db_helper.dart';

class PerpustakaanPage extends StatefulWidget {
  const PerpustakaanPage({super.key});

  @override
  State<PerpustakaanPage> createState() => _PerpustakaanPageState();
}

class _PerpustakaanPageState extends State<PerpustakaanPage> {
  final List<DiaryItem> _diarySqlite = [];

  @override
  void initState() {
    super.initState();
    _loadDiary();
  }

  Future<void> _loadDiary() async {
    final data = await DBHelper.instance.getAllDiary();
    if (!mounted) return;
    setState(() {
      _diarySqlite
        ..clear()
        ..addAll(data);
    });
  }

  Future<void> _hapusDiary(int id) async {
    await DBHelper.instance.deleteDiary(id);
    await _loadDiary();
  }

  Future<void> _bukaBuatDiary() async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const BuatPage()),
    );

    if (hasil == true) {
      await _loadDiary();
    }
  }

  Widget _buildCard({
    required String judul,
    required String tanggal,
    required VoidCallback onTap,
    required VoidCallback onDelete,
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
            children: [
              Expanded(
                child: Text(
                  judul,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Text(
                tanggal,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.white),
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
                  'Diary Pengguna',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                if (_diarySqlite.isEmpty)
                  const Text(
                    'Belum ada diary',
                    style: TextStyle(color: Colors.blueGrey),
                  )
                else
                  for (int i = 0; i < _diarySqlite.length; i++)
                    _buildCard(
                      judul: _diarySqlite[i].judul,
                      tanggal: _diarySqlite[i].tanggal,
                      onTap: () async {
                        final hasil = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Diary1Page(item: _diarySqlite[i]),
                          ),
                        );
                        if (hasil == true) {
                          await _loadDiary();
                        }
                      },
                      onDelete: () async {
                        if (_diarySqlite[i].id != null) {
                          await _hapusDiary(_diarySqlite[i].id!);
                        }
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
