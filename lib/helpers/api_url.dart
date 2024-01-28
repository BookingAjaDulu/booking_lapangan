class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2/booking-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listLapang = baseUrl + '/lapang';
  static const String createLapang = baseUrl + '/lapang';

  static String updateLapang(int id) {
    return baseUrl + '/lapang/' + id.toString() + '/update';
  }

  static String showLapang(int id) {
    return baseUrl + '/lapang/' + id.toString();
  }

  static String deleteLapang(int id) {
    return baseUrl + '/lapang/' + id.toString();
  }
}
