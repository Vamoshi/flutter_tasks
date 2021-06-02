import 'dart:convert';

import 'package:flutter_tasks/repos/models/repo_model.dart';
import 'package:http/http.dart' as http;

class RepoProvider {
  Future<List<Repo>> fetchRepos(searchString, page) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.github.com/search/repositories?q=$searchString&sort=stars&order=desc&per_page=20&page=$page"));

      final items = json.decode(response.body)["items"];

      return items as Future<List<Repo>>;
    } catch (e) {
      print(e);
      throw Exception("error fetching posts");
    }
  }
}
