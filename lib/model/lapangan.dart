class Lapangan {
  int? id;
  String? namaLapangan;
  String? Tanggal;
  String? jamMulai;
  String? totalJamMain;
  int? nominal;

  Lapangan(
      {this.id,
      this.namaLapangan,
      this.Tanggal,
      this.jamMulai,
      this.totalJamMain,
      this.nominal});

  factory Lapangan.fromJson(Map<String, dynamic> obj) {
    return Lapangan(
      id: int.tryParse(obj['id'].toString()),
      namaLapangan: obj['nama_lapangan'],
      Tanggal: obj['tanggal'],
      jamMulai: obj['jam_mulai'],
      totalJamMain: obj['total_jam_main'],
      nominal: int.tryParse(obj['nominal'].toString()), // Safely parse to int
    );
  }
}
