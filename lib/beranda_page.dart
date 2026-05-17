import 'package:flutter/material.dart';
import 'package:app_3a_02/buat_page.dart';
import 'package:app_3a_02/perpustakaan_page.dart';
import 'package:app_3a_02/diary1_page.dart';
import 'package:app_3a_02/profil_page.dart';
import 'package:app_3a_02/suka_page.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/utils/user_prefs.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final List<DiaryItem> _riwayatDiary = [];

  final TextEditingController _cariC =
      TextEditingController();

  List<DiaryItem> _hasilCari = [];

  int _currentIndex = 0;

  String _nama = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadRiwayat();

    final nama = await UserPrefs.getName();

    if (!mounted) return;

    setState(() {
      _nama = nama;
    });
  }

  Future<void> _refreshNama() async {
    final nama =
        await UserPrefs.getName();

    if (!mounted) return;

    setState(() {
      _nama = nama;
    });
  }

  Future<void> _loadRiwayat() async {
    final data = await DBHelper.instance.getAllDiary();

    if (!mounted) return;

    setState(() {
      _riwayatDiary
        ..clear()
        ..addAll(data);

      _hasilCari = List.from(data);
    });
  }

  void _cariDiary(String keyword) {
    final hasil = _riwayatDiary.where((item) {
      return item.judul
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();

    setState(() {
      _hasilCari = hasil;
    });
  }

  Future<void> _bukaBuatDiary() async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const BuatPage(),
      ),
    );

    if (hasil == true) {
      await _loadData();
    }
  }

  Future<void> _bukaPerpustakaan() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PerpustakaanPage(),
      ),
    );

    await _loadData();
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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF5FB9E3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  judul,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                tanggal,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHome() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFF5FB9E3),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              Center(
                child: Text(
                  _nama.isEmpty
                      ? "Pengguna"
                      : _nama,
                  style: const TextStyle(
                    color: Color(0xFF2C8FCA),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                _nama.isEmpty
                    ? 'Hai,'
                    : 'Hai ${_nama.split(' ').first},',
                style: const TextStyle(
                  color: Color(0xFF2C8FCA),
                  fontSize: 14,
                ),
              ),

              const Text(
                'apa yang akan kamu tulis hari ini?',
                style: TextStyle(
                  color: Color(0xFF2C8FCA),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: _cariC,
                  onChanged: _cariDiary,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cari Di Sini',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed:
                            _bukaBuatDiary,
                        child: const Text(
                          'Buat Diary Baru',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed:
                            _bukaPerpustakaan,
                        child: const Text(
                          'Perpustakaan',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'Riwayat Diary',
                style: TextStyle(
                  color: Color(0xFF2B87BD),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 12),

              if (_hasilCari.isEmpty)
                const Text(
                  'Diary tidak ditemukan',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                )
              else
                for (int i = 0;
                    i < _hasilCari.length;
                    i++)
                  _buildCard(
                    judul:
                        _hasilCari[i].judul,
                    tanggal:
                        _hasilCari[i].tanggal,
                    onTap: () async {
                      final hasil =
                          await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Diary1Page(
                            item:
                                _hasilCari[i],
                          ),
                        ),
                      );

                      if (hasil == true) {
                        await _loadData();
                      }
                    },
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
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHome(),
          const SukaPage(),
          
          ProfilPage(
            key: UniqueKey(),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });

          await _refreshNama();
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}