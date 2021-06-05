import 'dart:convert';

import 'package:http/http.dart' as http;

class ReposData {
  Future<List> fetchRepos(searchString, page) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.github.com/search/repositories?q=$searchString&sort=stars&order=desc&per_page=20&page=$page"));

      if (response.statusCode == 403) {
        return [];
      }

      List items = json.decode(response.body)["items"];
      return items;
    } catch (e) {
      print(e);
      throw Exception("Error fetching posts");
    }
  }
}
