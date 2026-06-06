class DiaryItem {
  final int? id;
  final String judul;
  final String isi;
  final String tanggal;
  final String mood;
  final String kategori;
  final int isFavorite;

  DiaryItem({
    this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.mood,
    required this.kategori,
    this.isFavorite = 0,
  });

  factory DiaryItem.fromMap(Map<String, dynamic> map) {
    return DiaryItem(
      id: map['id'],
      judul: map['judul'],
      isi: map['isi'],
      tanggal: map['tanggal'],
      mood: map['mood'] ?? '',
      kategori: map['kategori'] ?? '',
      isFavorite: map['isFavorite'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'tanggal': tanggal,
      'mood': mood,
      'kategori': kategori,
      'isFavorite': isFavorite,
    };
  }
}