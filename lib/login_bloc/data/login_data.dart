import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginData {
  Future getUserId(email, password) async {
    try {
      final response = await http.get(Uri.parse(
        "http://127.0.0.1:5000/app/login?email=$email&password=$password",
      ));

      print("LOGIN RESPONSE IS ====== ${response.body}");

      return json.decode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
