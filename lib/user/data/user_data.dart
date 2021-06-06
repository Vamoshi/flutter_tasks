import 'dart:convert';

import 'package:http/http.dart' as http;

class UserData {
  Future fetchUser(userId) async {
    try {
      final url = "http://127.0.0.1:5000/api/user?userId=$userId";
      // "https://api.github.com/user/$userId";

      final response = await http.get(Uri.parse(url));
      final user = json.decode(response.body);
      return user;
    } catch (e) {
      print(e);
      throw Exception("Error fetching user");
    }
  }
}
