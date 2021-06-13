import 'dart:convert';

import 'package:flutter_tasks/user_authentication_bloc/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UserAuthenticationData {
  Future getUserId(email, password, userId) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/app/login",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': email,
            'password': password,
            'user_id': userId,
          },
        ),
      );

      final result = json.decode(response.body);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future registerUser(email, password) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/app/register",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': email,
            'password': password,
          },
        ),
      );

      final result = json.decode(response.body);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future authorizeFitbit(userId) async {
    try {
      var response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/consent",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'user_id': userId,
          },
        ),
      );

      var url = response.body;

      if (await canLaunch(url)) {
        await launch(url, forceWebView: true, enableJavaScript: true);
      }

      return UserAuthenticationModel(
        email: "",
        message: "Successfully Logged into Fitbit",
        userId: userId,
      );
    } catch (e) {
      print(e);
      return UserAuthenticationModel(
        email: "",
        message: "Failed to launch url",
        userId: userId,
      );
    }
  }
}
