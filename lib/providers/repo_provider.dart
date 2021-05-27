import 'dart:convert';

import 'package:github_thing_2/models/repo.dart';
import "package:http/http.dart" as http;

Future<List<Repo>> getRepoList(String searchString, int pages) async {
  final url =
      "https://api.github.com/search/repositories?q=$searchString+language:assembly&sort=stars&order=desc&per_page=20&page=$pages";

  print("I should only run once!! Or everytime you scroll to the bottom");

  final response = await http.get(
    Uri.parse(url),
    // headers: {
    //   HttpHeaders.authorizationHeader:
    //       "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"
    // },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    // var list = data["items"].map((item) {
    //   // print(item["id"].toString() +
    //   //     item["name"] +
    //   //     item["language"] +
    //   //     item["html_url"] +
    //   //     item["description"].toString());
    //   return Repo(
    //     id: item["id"],
    //     name: item["name"],
    //     language: item["language"],
    //     url: item["html_url"],
    //     description: item["description"] ?? "No Description",
    //   );
    // });

    List<Repo> list = [];

    for (var i = 0; i < data["items"].length; i++) {
      var item = data["items"][i];

      list.add(Repo(
        id: item["id"],
        name: item["name"],
        language: item["language"],
        url: item["html_url"],
        description: item["description"] ?? "No Description",
      ));
    }

    return list;
  } else {
    throw Exception();
  }
  // print(items.length);
}
