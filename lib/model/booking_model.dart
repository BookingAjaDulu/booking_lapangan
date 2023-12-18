// model.dart
import 'package:meta/meta.dart';

@immutable
class BookingDetails {
  final String namaLapangan;
  final DateTime tanggal;
  final String jamMulai;
  final int totalJamMain;
  final double harga;

  BookingDetails({
    required this.namaLapangan,
    required this.tanggal,
    required this.jamMulai,
    required this.totalJamMain,
    required this.harga,
  });
}