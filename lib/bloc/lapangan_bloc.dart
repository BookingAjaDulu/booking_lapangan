import 'dart:convert';

import 'package:booking_lapangan/helpers/api.dart';
import 'package:booking_lapangan/helpers/api_url.dart';
import 'package:booking_lapangan/model/lapangan.dart';

class LapangBloc {
  static Future<List<Lapang>> getLapangs() async {
    Uri apiUrl =
        Uri.parse(ApiUrl.listLapang); // Use Uri.parse to convert to Uri
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listLapang = (jsonObj as Map<String, dynamic>)['data'];
    List<Lapang> lapangs = [];
    for (int i = 0; i < listLapang.length; i++) {
      lapangs.add(Lapang.fromJson(listLapang[i]));
    }
    return lapangs;
  }

  static Future addLapang({Lapang? lapang}) async {
    String apiUrl = ApiUrl.createLapang;

    var body = {
      "nama_lapang": lapang!.namaLapang,
      "tanggal": lapang.Tanggal,
      "jam_mulai": lapang.jamMulai,
      "total_jam_main": lapang.totalJamMain,
      "nominal": lapang.nominal.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateLapang({required Lapang lapang}) async {
    String apiUrl = ApiUrl.updateLapang(lapang.id!);

    var body = {
      "nama_lapang": lapang.namaLapang,
      "tanggal": lapang.Tanggal,
      "jam_mulai": lapang.jamMulai,
      "total_jam_main": lapang.totalJamMain,
      "nominal": lapang.nominal.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteLapang({int? id}) async {
    String apiUrl = ApiUrl.deleteLapang(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
