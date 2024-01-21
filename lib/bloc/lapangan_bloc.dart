import 'dart:convert';

import 'package:booking_lapangan/helpers/api.dart';
import 'package:booking_lapangan/helpers/api_url.dart';
import 'package:booking_lapangan/model/lapangan.dart';

class LapanganBloc {
  static Future<List<Lapangan>> getLapangans() async {
    Uri apiUrl =
        Uri.parse(ApiUrl.listLapangan); // Use Uri.parse to convert to Uri
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listLapangan = (jsonObj as Map<String, dynamic>)['data'];
    List<Lapangan> lapangans = [];
    for (int i = 0; i < listLapangan.length; i++) {
      lapangans.add(Lapangan.fromJson(listLapangan[i]));
    }
    return lapangans;
  }

  static Future addLapangan({Lapangan? lapangan}) async {
    String apiUrl = ApiUrl.createLapangan;

    var body = {
      "kode_lapangan": lapangan!.kodeLapangan,
      "nama_lapangan": lapangan.namaLapangan,
      "nominal": lapangan.nominalLapangan.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateLapangan({required Lapangan lapangan}) async {
    String apiUrl = ApiUrl.updateLapangan(lapangan.id!);

    var body = {
      "kode_lapangan": lapangan.kodeLapangan,
      "nama_lapangan": lapangan.namaLapangan,
      "nominal": lapangan.nominalLapangan.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteLapangan({int? id}) async {
    String apiUrl = ApiUrl.deleteLapangan(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
