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
    required DiaryItem item,
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
            color: const Color(0xFF2F80ED),
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
                onPressed: () async {

                  final newValue =
                    item.isFavorite == 1 ? 0 : 1;

                  await DBHelper.instance.toggleFavorite(
                    item.id!, 
                    newValue,
                    );

                    await _loadDiary();
                },
                icon: Icon(
                  item.isFavorite == 1
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                ),
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
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Perpustakaan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: _bukaBuatDiary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F80ED),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Buat Diary Baru"),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Diary Pengguna",
                style: TextStyle(
                  color: Color(0xFF2F80ED),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (_diarySqlite.isEmpty)
                const Text(
                  "Belum ada diary",
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                )
              else
                for (int i = 0; i < _diarySqlite.length; i++)
                  _buildCard(
                    item: _diarySqlite[i],
                    judul: _diarySqlite[i].judul,
                    tanggal: _diarySqlite[i].tanggal,
                    onTap: () async {
                      final hasil = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Diary1Page(diary: _diarySqlite[i]),
                        ),
                      );

                      if (hasil == true) {
                        await _loadDiary();
                      }
                    },
                    onDelete: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Konfirmasi"),
                            content: const Text(
                              "Apakah diary akan dihapus?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("Tidak"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Ya"),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm == true &&
                          _diarySqlite[i].id != null) {
                        await _hapusDiary(_diarySqlite[i].id!);
                      }
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

