import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfileData {
  Future fetchProfile() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/crossroad/profile",
        ),
      );

      print("response is ${response.body}");

      final result = json.decode(response.body);

      return result;
    } catch (e) {
      print(e);
    }
  }
}
