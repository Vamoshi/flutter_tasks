import 'dart:convert';

import 'package:http/http.dart' as http;

class ActivitySummaryData {
  Future getSteps(userId) async {
    try {
      final now = DateTime.now();
      final month = now.month < 10 ? "0${now.month}" : now.month;
      final day = now.day < 10 ? "0${now.day}" : now.day;
      final date = "${now.year}-${month}-${day}";
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/steps/${date}",
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

      final result = json.decode(response.body);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getSleep(userId) async {
    try {
      final now = DateTime.now();
      final month = now.month < 10 ? "0${now.month}" : now.month;
      final day = now.day < 10 ? "0${now.day}" : now.day;
      final date = "${now.year}-${month}-${day}";
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/sleep/${date}",
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

      final result = json.decode(response.body);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getCalories(userId) async {
    try {
      final now = DateTime.now();
      final month = now.month < 10 ? "0${now.month}" : now.month;
      final day = now.day < 10 ? "0${now.day}" : now.day;
      final date = "${now.year}-${month}-${day}";
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/calories/${date}",
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

      final result = json.decode(response.body);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
