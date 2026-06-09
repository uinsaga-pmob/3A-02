import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/diary1_page.dart';

class SukaPage extends StatefulWidget {
  const SukaPage({super.key});

  @override
  State<SukaPage> createState() => _SukaPageState();
}

class _SukaPageState extends State<SukaPage> {
  List<DiaryItem> _favorit = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavorit();
  }

  Future<void> _loadFavorit() async {
    final data = await DBHelper.instance.getFavoriteDiary();

    if (!mounted) return;

    setState(() {
      _favorit = data;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite(DiaryItem item) async {
    final newValue = item.isFavorite == 1 ? 0 : 1;

    await DBHelper.instance.toggleFavorite(item.id!, newValue);

    await _loadFavorit();
  }

  Widget _buildCard(DiaryItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () async {
          final hasil = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Diary1Page(diary: item)),
          );

          if (hasil == true) {
            await _loadFavorit();
          }
        },
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.judul,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      item.tanggal,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () async {
                  await _toggleFavorite(item);
                },
                icon: Icon(
                  item.isFavorite == 1 ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink,
                ),
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Suka"),
        centerTitle: true,
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

          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _favorit.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada diary favorit',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: _favorit.length,
                  itemBuilder: (context, index) {
                    final item = _favorit[index];

                    return _buildCard(item);
                  },
                ),
        ),
      ),
    );
  }
}
