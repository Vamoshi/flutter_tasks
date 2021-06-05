import 'dart:async';
import 'package:flutter_tasks/old/models/repo_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepoProvider {
  Future<RepoListModel> fetchRepos(searchString, page) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.github.com/search/repositories?q=$searchString&sort=stars&order=desc&per_page=20&page=$page"));

      final items = json.decode(response.body)["items"];

      return RepoListModel.fromJson(items);
    } catch (e) {
      print(e);
      throw Exception("Failed to find repos");
    }
  }
}
