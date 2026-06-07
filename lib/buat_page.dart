import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';

class BuatPage extends StatefulWidget {
  const BuatPage({super.key});

  @override
  State<BuatPage> createState() => _BuatPageState();
}

class _BuatPageState extends State<BuatPage> {
  final TextEditingController judulController =
      TextEditingController();

  final TextEditingController isiController =
      TextEditingController();

  final ImagePicker picker = ImagePicker();

  XFile? selectedImage;

  String selectedMood = "Bahagia";
  String selectedKategori = "Pribadi";

  String tag = "";
  String lokasi = "";

  double fontSize = 16;

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    judulController.dispose();
    isiController.dispose();
    super.dispose();
  }

  Future<void> simpanDiary() async {
    if (judulController.text.trim().isEmpty ||
        isiController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Judul dan isi diary wajib diisi",
          ),
        ),
      );
      return;
    }

    await DBHelper.instance.insertDiary(
      DiaryItem(
        judul: judulController.text.trim(),
        isi: isiController.text.trim(),
        tanggal:
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        mood: selectedMood,
        kategori: selectedKategori,
        imagePath: selectedImage?.path ?? "",
        lokasi: lokasi,
      ),
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Future<void> pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> tambahTag() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Tag"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Masukkan tag",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tag = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  Future<void> tambahLokasi() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Lokasi"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Masukkan lokasi",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                lokasi = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void ubahUkuranFont() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  const Text(
                    "Ukuran Tulisan",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  Slider(
                    min: 14,
                    max: 30,
                    value: fontSize,
                    onChanged: (value) {
                      setState(() {
                        fontSize = value;
                      });

                      setModalState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Tulis Diary",
          style: TextStyle(
            color: Colors.black,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [
          TextButton(
            onPressed: simpanDiary,
            child: const Text(
              "Simpan",
              style: TextStyle(
                color: Color(0xFF2F80ED),
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            TextField(
              controller: judulController,
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.w500,
              ),
              decoration:
                  const InputDecoration(
                hintText: "Judul",
                border: InputBorder.none,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      DateTime? picked =
                          await showDatePicker(
                        context: context,
                        initialDate:
                            selectedDate,
                        firstDate:
                            DateTime(2020),
                        lastDate:
                            DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() {
                          selectedDate =
                              picked;
                        });
                      }
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration:
                          BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .grey.shade300,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons
                                .calendar_month,
                            size: 18,
                          ),
                          const SizedBox(
                              width: 8),
                          Expanded(
                            child: Text(
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            ),
                          ),
                          const Icon(Icons
                              .keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child:
                      DropdownButtonFormField<
                          String>(
                    value: selectedMood,
                    decoration:
                        InputDecoration(
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value:
                            "Bahagia",
                        child: Text(
                            "😊 Bahagia"),
                      ),
                      DropdownMenuItem(
                        value: "Sedih",
                        child: Text(
                            "😢 Sedih"),
                      ),
                      DropdownMenuItem(
                        value: "Marah",
                        child: Text(
                            "😡 Marah"),
                      ),
                      DropdownMenuItem(
                        value: "Netral",
                        child: Text(
                            "😐 Netral"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedMood =
                            value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                "Pribadi",
                "Sekolah",
                "Keluarga",
                "Kerja",
              ].map((kategori) {
                return ChoiceChip(
                  label: Text(kategori),
                  selected:
                      selectedKategori ==
                          kategori,
                  selectedColor:
                      const Color(
                    0xFF2F80ED,
                  ),
                  labelStyle: TextStyle(
                    color:
                        selectedKategori ==
                                kategori
                            ? Colors.white
                            : Colors.black,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedKategori =
                          kategori;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              onPressed: tambahTag,
              icon: const Icon(Icons.add),
              label: const Text("Tag"),
            ),

            const SizedBox(height: 15),

            if (tag.isNotEmpty)
              Chip(
                label: Text("#$tag"),
              ),

            if (lokasi.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                    ),
                    const SizedBox(
                        width: 5),
                    Text(lokasi),
                  ],
                ),
              ),

            if (selectedImage != null)
              Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 15,
                ),
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  child: Image.file(
                    File(
                      selectedImage!.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            Container(
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      Colors.grey.shade300,
                ),
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
              child: TextField(
                controller: isiController,
                style: TextStyle(
                  fontSize: fontSize,
                ),
                maxLines: null,
                expands: true,
                decoration:
                    const InputDecoration(
                  hintText:
                      "Tuliskan ceritamu hari ini...",
                  border:
                      InputBorder.none,
                  contentPadding:
                      EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceAround,
              children: [
                IconButton(
                  onPressed: pickImage,
                  icon: const Icon(
                    Icons.image_outlined,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: tambahTag,
                  icon: const Icon(
                    Icons
                        .local_offer_outlined,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed:
                      tambahLokasi,
                  icon: const Icon(
                    Icons
                        .location_on_outlined,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed:
                      ubahUkuranFont,
                  icon: const Icon(
                    Icons.text_fields,
                    size: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}