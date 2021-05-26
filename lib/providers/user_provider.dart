import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_thing/model/user.dart';
import 'package:github_thing/utils/api.dart';
import "package:http/http.dart" as http;

// void getKeysFromMap(Map map) {
//   print('----------');
//   print('Get keys:');
//   // Get all keys
//   map.keys.forEach((key) {
//     print(key);
//   });
// }

class UserProvider with ChangeNotifier {
  late User user;

  Future<void> getUserProfile(String username) async {
    final url = '${Api.api}users/$username';

    // print("Inside user_provider");
    // print(url);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'token ${Api.token}'},
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      // getKeysFromMap(responseData);
      // print(responseData["login"]);

      user = User(
        username: responseData["login"],
        imageUrl: responseData["avatar_url"],
        followers: responseData["followers"],
        followings: responseData["following"],
        publicRepo: responseData["public_repos"],
        joinedDate: responseData["created_at"],
      );

      print("User_provider username");
      print(user.username);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
