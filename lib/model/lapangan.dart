class Lapangan {
  int? id;
  String? kodeLapangan;
  String? namaLapangan;
  int? nominalLapangan;

  Lapangan(
      {this.id, this.kodeLapangan, this.namaLapangan, this.nominalLapangan});

  factory Lapangan.fromJson(Map<String, dynamic> obj) {
    return Lapangan(
      id: int.tryParse(obj['id'].toString()),
      kodeLapangan: obj['kode_lapangan'],
      namaLapangan: obj['nama_lapangan'],
      nominalLapangan:
          int.tryParse(obj['nominal'].toString()), // Safely parse to int
    );
  }
}
