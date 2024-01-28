class Lapang {
  int? id;
  String? namaLapang;
  String? Tanggal;
  String? jamMulai;
  String? totalJamMain;
  int? nominal;

  Lapang(
      {this.id,
      this.namaLapang,
      this.Tanggal,
      this.jamMulai,
      this.totalJamMain,
      this.nominal});

  factory Lapang.fromJson(Map<String, dynamic> obj) {
    return Lapang(
      id: int.tryParse(obj['id'].toString()),
      namaLapang: obj['nama_lapang'],
      Tanggal: obj['tanggal'],
      jamMulai: obj['jam_mulai'],
      totalJamMain: obj['total_jam_main'],
      nominal: int.tryParse(obj['nominal'].toString()), // Safely parse to int
    );
  }
}
