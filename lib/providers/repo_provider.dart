import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:github_thing_2/models/Repo.dart';
import "package:http/http.dart" as http;

class RepoProvider with ChangeNotifier {
  late List repoList;

  Future<void> getRepoList(String searchString) async {
    final url =
        "https://api.github.com/search/repositories?q=$searchString+language:assembly&sort=stars&order=desc&per_page=10";

    if (repoList.isEmpty) {
      try {
        final response = await http.get(
          Uri.parse(url),
          // headers: {
          //   HttpHeaders.authorizationHeader:
          //       "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"
          // },
        );
        var data = json.decode(response.body);

        repoList = data["items"].map((item) {
          // print(item["id"].toString() +
          //     item["name"] +
          //     item["language"] +
          //     item["html_url"] +
          //     item["description"].toString());
          return Repo(
            id: item["id"],
            name: item["name"],
            language: item["language"],
            url: item["html_url"],
            description: item["description"] ?? "No Description",
          );
        }).toList();

        // print(items.length);

        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }
}
