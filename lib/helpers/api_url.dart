class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2/lapangan-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listLapangan = baseUrl + '/lapangan';
  static const String createLapangan = baseUrl + '/lapangan';

  static String updateLapangan(int id) {
    return baseUrl + '/lapangan/' + id.toString() + '/update';
  }

  static String showLapangan(int id) {
    return baseUrl + '/lapangan/' + id.toString();
  }

  static String deleteLapangan(int id) {
    return baseUrl + '/lapangan/' + id.toString();
  }
}
