import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

class Diary1Page extends StatefulWidget {
  final DiaryItem item;

  const Diary1Page({
    super.key,
    required this.item,
  });

  @override
  State<Diary1Page> createState() =>
      _Diary1PageState();
}

class _Diary1PageState
    extends State<Diary1Page> {
  late final TextEditingController
      _judulController;

  late final TextEditingController
      _isiController;

  late int _isFavorite;

  @override
  void initState() {
    super.initState();

    _judulController =
        TextEditingController(
      text: widget.item.judul,
    );

    _isiController =
        TextEditingController(
      text: widget.item.isi,
    );

    _isFavorite = widget.item.isFavorite;
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();

    super.dispose();
  }

  Future<void> _simpan() async {
    if (_judulController.text
            .trim()
            .isEmpty ||
        _isiController.text
            .trim()
            .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Judul dan isi diary wajib diisi',
          ),
        ),
      );

      return;
    }

    final updated = DiaryItem(
      id: widget.item.id,

      judul:
          _judulController.text.trim(),

      isi:
          _isiController.text.trim(),

      tanggal: widget.item.tanggal,

      isFavorite: _isFavorite,
    );

    await DBHelper.instance
        .updateDiary(updated);

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _suka() async {
    if (widget.item.id == null) return;

    final newValue =
        _isFavorite == 1 ? 0 : 1;

    await DBHelper.instance.toggleFavorite(
      widget.item.id!,
      newValue,
    );

    if (!mounted) return;

    setState(() {
      _isFavorite = newValue;
    });

    Navigator.pop(context, true);
  }

  Future<void> _hapus() async {
    final confirm =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Konfirmasi',
          ),

          content: const Text(
            'Apakah diary akan dihapus?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                'Tidak',
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },

              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      if (widget.item.id != null) {
        await DBHelper.instance
            .deleteDiary(
          widget.item.id!,
        );
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:
            true,

        appBar: AppBar(
          backgroundColor:
              Colors.transparent,

          elevation: 0,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),

            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: const Text(
            "Detail Diary",

            style: TextStyle(
              color: Colors.blue,
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),

          actions: [
            IconButton(
              onPressed: _hapus,

              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),

            IconButton(
              onPressed: _suka,

              icon: Icon(
                _isFavorite == 1
                    ? Icons.favorite
                    : Icons
                        .favorite_border,

                color: Colors.pink,
              ),
            ),

            IconButton(
              onPressed: _simpan,

              icon: const Icon(
                Icons.check,
                color: Colors.blue,
              ),
            ),
          ],
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,

          decoration:
              const BoxDecoration(
            gradient: LinearGradient(
              begin:
                  Alignment.topCenter,

              end:
                  Alignment.bottomCenter,

              colors: [
                Colors.white,
                Color(0xFF5FB9E3),
              ],
            ),
          ),

          child: Padding(
            padding:
                const EdgeInsets.all(
              24,
            ),

            child: Column(
              children: [
                TextField(
                  controller:
                      _judulController,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Judul diary",

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Expanded(
                  child: TextField(
                    controller:
                        _isiController,

                    maxLines: null,

                    expands: true,

                    textAlignVertical:
                        TextAlignVertical
                            .top,

                    decoration:
                        const InputDecoration(
                      hintText:
                          "Tulis diary di sini...",

                      filled: true,

                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(
                        borderSide:
                            BorderSide.none,
                      ),
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