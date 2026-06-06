import 'package:app_3a_02/buat_page.dart';
import 'package:app_3a_02/diary1_page.dart';
import 'package:flutter/material.dart';
import 'package:app_3a_02/database/db_helper.dart';
import 'package:app_3a_02/models/diaryitem_page.dart';
import 'package:app_3a_02/diary1_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {

  List<DiaryItem> diaries = [];

  int totalDiary = 0;
  int totalFavorite = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final data =
        await DBHelper.instance.getAllDiary();

    setState(() {
      diaries = data;
      totalDiary = data.length;
      totalFavorite = data
          .where((e) => e.isFavorite == 1)
          .length;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(
      0xFFF7F9FC,
    ),
    body: SafeArea(
      child: Column(
        children: [
          buildAppBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: loadData,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(16),
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

    bottomNavigationBar:
        buildBottomNavigation(),

    floatingActionButton:
        FloatingActionButton(
      backgroundColor:
          const Color(0xFF2F80ED),
      onPressed: () async {

        final result =
            await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const BuatPage(),
          ),
        );

        if (result == true) {
          loadData();
        }
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),

    floatingActionButtonLocation:
        FloatingActionButtonLocation
            .centerDocked,
  );
}

Widget buildAppBar() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        const Icon(Icons.menu),
        const Spacer(),
        const Text(
          "Beranda",
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 18,
          ),
        ),

        const Spacer(),
        const Icon(
          Icons.notifications_none,
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
      borderRadius:
          BorderRadius.circular(20),
      gradient: const LinearGradient(

        colors: [
          Color(0xFF2F80ED),
          Color(0xFF4A90E2),
        ],
      ),
    ),
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                "Halo 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Apa kabar hari ini?",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        Image.asset(
          "assets/images/mydiary.png",
          width: 90,
        ),
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
          "12",
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

Widget statCard(
  String value,
  String label,
) {
  return Container(
    padding:
        const EdgeInsets.symmetric(
      vertical: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 20,
            color:
                Color(0xFF2F80ED),
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
        style: TextStyle(
          fontSize: 18,
          fontWeight:
              FontWeight.bold,
        ),
      ),
      const Spacer(),
      TextButton(
        onPressed: () {},
        child: const Text(
          "Lihat semua",
        ),
      ),
    ],
  );
}

Widget buildDiaryList() {
  if (diaries.isEmpty) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: const Text(
        "Belum ada diary",
      ),
    );
  }
  return Column(
    children: diaries.map((item) {
      return Container(
        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
            15,
          ),
        ),

        child: ListTile(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Diary1Page(
                  diary: item,
                ),
              ),
            );
            loadData();
          },

          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/diary.jpg",
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),

          title: Text(item.judul),

          subtitle: Text(
            item.isi,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          trailing: Icon(
            item.isFavorite == 1
                ? Icons.star
                : Icons.star_border,
            color: Colors.amber,
          ),
        ),
      );
    }).toList(),
  );
}

Widget buildBottomNavigation() {
  return BottomAppBar(
    shape:
        const CircularNotchedRectangle(),
    child: SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home_outlined),
          Icon(Icons.favorite_border),
          SizedBox(width: 40),
          Icon(Icons.menu_book_outlined),
          Icon(Icons.person_outline),
        ],
      ),
    ),
  );
}
}