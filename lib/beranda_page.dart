import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_3a_02/utils/user_prefs.dart';
import 'package:app_3a_02/buat_page.dart';
import 'package:app_3a_02/diary1_page.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/profil_page.dart';
import 'package:app_3a_02/suka_page.dart';
import 'package:app_3a_02/perpustakaan_page.dart';
import 'package:app_3a_02/login_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<DiaryItem> diaries = [];

  int totalDiary = 0;
  int totalFavorite = 0;
  String nama = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await DBHelper.instance.getAllDiary();
    final profile = await UserPrefs.getProfile();

    if(!mounted) return;

    setState(() {
      diaries = data;
      totalDiary = data.length;
      totalFavorite = data.where((e) => e.isFavorite == 1).length;

      nama = profile["nama"] ?? "";
      email = profile["email"] ?? "";
    });
  }

  void _showNotifications() async {
  final allDiary = await DBHelper.instance.getAllDiary();
  final favoriteDiary = await DBHelper.instance.getFavoriteDiary();

  List<Map<String, String>> notifications = [];

  // Belum punya favorit
  if (favoriteDiary.isEmpty) {
    notifications.add({
      "icon": "⭐",
      "title": "Belum punya favorit",
      "subtitle":
          "Tandai diary penting sebagai favorit agar mudah ditemukan.",
    });
  }

  // Belum menulis hari ini
  final now = DateTime.now();

  final today =
      "${now.day}/${now.month}/${now.year}";

  final sudahMenulisHariIni = allDiary.any(
    (e) => e.tanggal == today,
  );

  if (!sudahMenulisHariIni) {
    notifications.add({
      "icon": "📝",
      "title": "Belum menulis hari ini",
      "subtitle": "Kamu belum menulis diary hari ini.",
    });
  }

  // Diary baru (informasi jumlah diary)
  notifications.add({
    "icon": "🎉",
    "title": "Diary Tersimpan",
    "subtitle":
        "Saat ini kamu memiliki ${allDiary.length} diary.",
  });

  // Hari beruntun (sementara dihitung dari jumlah tanggal unik)
  final hariBeruntun =
      allDiary.map((e) => e.tanggal).toSet().length;

  if (hariBeruntun > 1) {
    notifications.add({
      "icon": "🔥",
      "title": "Hari Beruntun",
      "subtitle":
          "Selamat! Hari beruntun menjadi $hariBeruntun hari.",
    });
  }

  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: notifications.isEmpty
            ? const Center(
                child: Text(
                  "Tidak ada notifikasi",
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: notifications.length,
                separatorBuilder: (_, __) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  final item = notifications[index];

                  return ListTile(
                    leading: Text(
                      item["icon"]!,
                      style:
                          const TextStyle(fontSize: 28),
                    ),
                    title: Text(
                      item["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item["subtitle"]!,
                    ),
                  );
                },
              ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF2F80ED),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
              accountName: Text(
                nama.isEmpty ? "Pengguna" : nama,
              ),
              accountEmail: Text(
                email.isEmpty ? "-" : email,
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text("Perpustakaan"),
              onTap: () async {
                Navigator.pop(context);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PerpustakaanPage(),
                  ),
                );

                loadData();
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.star,
              ),
              title: const Text("Favorit"),
              onTap: () async {
                Navigator.pop(context);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SukaPage(),
                  ),
                );

                loadData();
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil"),
              onTap: () async {
                Navigator.pop(context);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilPage(),
                  ),
                );

                loadData();
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Keluar",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Navigator.pop(context); // Menutup Drawer

                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Keluar"),
                      content: const Text(
                        "Apakah Anda yakin ingin keluar dari akun ini?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text(
                            "Keluar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: loadData,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      buildGreetingCard(),
                      const SizedBox(height: 15),
                      buildStatistics(),
                      const SizedBox(height: 20),
                      buildTitle(),
                      const SizedBox(height: 12),
                      buildDiaryList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: buildBottomNavigation(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2F80ED),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BuatPage()),
          );

          if (result == true) {
            loadData();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Diary baru berhasil disimpan"),
                duration: Duration(seconds: 2),
                ),
            );
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          const Spacer(),
          const Text(
            "Beranda",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: (){
              _showNotifications();
            },
          ),
        ],
      ),
    );
  }

  Widget buildGreetingCard() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2F80ED), Color(0xFF4A90E2)],
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Halo 👋",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  "Apa kabar hari ini?",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          Image.asset("assets/images/mydiary.png", width: 90),
        ],
      ),
    );
  }

  Widget buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: statCard(
            totalDiary.toString(),
            "Total Diary",
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: statCard(
            totalDiary.toString(),
            "Hari Beruntun",
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: statCard(
            totalFavorite.toString(),
            "Favorit",
          ),
        ),
      ],
    );
  }

  Widget statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF2F80ED),
            ),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Row(
      children: [
        const Text(
          "Diary Terbaru",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PerpustakaanPage(),
              ),
            );

            loadData();
          },
          child: const Text("Lihat semua"),
        ),
      ],
    );
  }

  Widget buildDiaryList() {
    if (diaries.isEmpty) {
      return Container(
        height: 150,
        alignment: Alignment.center,
        child: const Text("Belum ada diary"),
      );
    }
    return Column(
      children: diaries.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xFF4A90E2),
            borderRadius: BorderRadius.circular(15),
          ),

          child: ListTile(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Diary1Page(diary: item)),
              );
              loadData();
            },

            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imagePath.isNotEmpty &&
                      File(item.imagePath).existsSync()
                  ? Image.file(
                      File(item.imagePath),
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 55,
                      height: 55,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image),
                    ),
            ),

            title: Text(item.judul,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            subtitle: Text(
              item.isi,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),

            trailing: Icon(
              item.isFavorite == 1 ? Icons.star : Icons.star_border,
              color: Colors.amber,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildBottomNavigation() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // HOME
            IconButton(
              icon: const Icon(Icons.home, color: Color(0xFF2F80ED)),
              onPressed: () {},
            ),

            // FAVORIT
            IconButton(
              icon: const Icon(
                Icons.star_border,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SukaPage()),
                );

                loadData();
              },
            ),

            const SizedBox(width: 40),

            // DIARY
            IconButton(
              icon: const Icon(Icons.menu_book_outlined),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PerpustakaanPage(),
                  ),
                );

                if (result == true) {
                  loadData();
                }
              },
            ),

            // PROFIL
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
