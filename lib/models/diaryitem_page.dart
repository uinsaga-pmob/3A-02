class DiaryItem {
  int? id;
  String judul;
  String isi;
  String tanggal;

  DiaryItem({
    this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'judul': judul, 'isi': isi, 'tanggal': tanggal};
  }

  factory DiaryItem.fromMap(Map<String, dynamic> map) {
    return DiaryItem(
      id: map['id'],
      judul: map['judul'],
      isi: map['isi'],
      tanggal: map['tanggal'],
    );
  }
}
