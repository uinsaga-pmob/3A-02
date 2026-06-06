import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

class Diary1Page extends StatefulWidget {
  final DiaryItem diary;

  const Diary1Page({
    super.key,
    required this.diary,
  });

  @override
  State<Diary1Page> createState() =>
      _Diary1PageState();
}

class _Diary1PageState
    extends State<Diary1Page> {
  late DiaryItem diary;

  @override
  void initState() {
    super.initState();
    diary = widget.diary;
  }

  Future<void> toggleFavorite() async {
    int newValue =
        diary.isFavorite == 1 ? 0 : 1;

    await DBHelper.instance.toggleFavorite(
      diary.id!,
      newValue,
    );

    setState(() {
      diary = DiaryItem(
        id: diary.id,
        judul: diary.judul,
        isi: diary.isi,
        tanggal: diary.tanggal,
        mood: diary.mood,
        kategori: diary.kategori,
        isFavorite: newValue,
      );
    });
  }

  Future<void> deleteDiary() async {
    await DBHelper.instance.deleteDiary(
      diary.id!,
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Widget buildChip(
    String text,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(
    IconData icon,
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/sky.jpg",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              true,
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20,),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          diary.judul,
                          style:
                              const TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed:
                            toggleFavorite,
                        icon: Icon(
                          diary.isFavorite ==
                                  1
                              ? Icons.star
                              : Icons
                                  .star_border,
                          color:
                              Colors.amber,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    diary.tanggal,
                    style:
                        const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  
                  const SizedBox(height: 18),
                  
                  Wrap(
                    spacing: 10,
                    children: [
                      buildChip(
                        diary.mood,
                        Icons.emoji_emotions,
                        Colors.orange,
                      ),
                      buildChip(
                        diary.kategori,
                        Icons.folder,
                        Colors.blue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Text(
                    diary.isi,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Color(0xFF2F80ED),

          borderRadius:
              BorderRadius.only(
            topLeft:
                Radius.circular(25),
            topRight:
                Radius.circular(25),
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceEvenly,

          children: [
            actionButton(
              Icons.edit,
              "Edit",
              () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Fitur Edit akan dibuat berikutnya",
                    ),
                  ),
                );
              },
            ),

            actionButton(
              Icons.delete_outline,
              "Hapus",
              () async {
                bool? confirm =
                    await showDialog(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                    title: const Text(
                      "Hapus Diary",
                    ),
                    content:
                        const Text(
                      "Yakin ingin menghapus diary ini?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            false,
                          );
                        },
                        child:
                            const Text(
                          "Batal",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            true,
                          );
                        },
                        child:
                            const Text(
                          "Hapus",
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  deleteDiary();
                }
              },
            ),

            actionButton(
              Icons.share_outlined,
              "Bagikan",
              () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Fitur Bagikan belum dibuat",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}