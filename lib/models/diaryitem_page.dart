class DiaryItem {
  int? id;
  String judul;
  String isi;
  String tanggal;
  int isFavorite;

  DiaryItem({
    this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
    this.isFavorite = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'tanggal': tanggal,
      'isFavorite': isFavorite,
    };
  }

  factory DiaryItem.fromMap(Map<String, dynamic> map) {
    return DiaryItem(
      id: map['id'],
      judul: map['judul'] ?? '',
      isi: map['isi'] ?? '',
      tanggal: map['tanggal'] ?? '',
      isFavorite: map['isFavorite'] ?? 0,
    );
  }
}