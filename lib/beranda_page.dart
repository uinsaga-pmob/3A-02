import 'package:flutter/material.dart';
import 'package:app_3a_02/buat_page.dart';
import 'package:app_3a_02/perpustakaan_page.dart';
import 'package:app_3a_02/diary1_page.dart';
import 'package:app_3a_02/profil_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/database/db_helper.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final List<DiaryItem> _riwayatDiary = [];

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    final data = await DBHelper.instance.getAllDiary();
    if (!mounted) return;
    setState(() {
      _riwayatDiary
        ..clear()
        ..addAll(data);
    });
  }

  Future<void> _bukaBuatDiary() async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const BuatPage()),
    );

    if (hasil == true) {
      await _loadRiwayat();
    }
  }

  Future<void> _bukaPerpustakaan() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PerpustakaanPage()),
    );
    await _loadRiwayat();
  }

  Future<void> _bukaPencarian() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hubungkan ke halaman pencarian asli kamu')),
    );
  }

  Future<void> _bukaProfil() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfilPage()),
    );
    await _loadRiwayat();
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
              Expanded(
                child: Text(
                  judul,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _bukaPencarian,
                      icon: const Icon(Icons.search, color: Colors.blue),
                    ),
                    const Text(
                      'Beranda',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _bukaProfil,
                      icon: const Icon(Icons.person, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _bukaBuatDiary,
                    child: const Text('Buat Diary'),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    onPressed: _bukaPerpustakaan,
                    child: const Text('Perpustakaan'),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Riwayat Diary',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                if (_riwayatDiary.isEmpty)
                  const Text(
                    'Belum ada riwayat diary',
                    style: TextStyle(color: Colors.blueGrey),
                  )
                else
                  for (int i = 0; i < _riwayatDiary.length; i++)
                    _buildCard(
                      judul: _riwayatDiary[i].judul,
                      tanggal: _riwayatDiary[i].tanggal,
                      onTap: () async {
                        final hasil = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Diary1Page(item: _riwayatDiary[i]),
                          ),
                        );
                        if (hasil == true) {
                          await _loadRiwayat();
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
