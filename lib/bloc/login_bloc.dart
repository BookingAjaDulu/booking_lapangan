import 'dart:convert';

import 'package:booking_lapangan/helpers/api.dart';
import 'package:booking_lapangan/helpers/api_url.dart';
import 'package:booking_lapangan/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
