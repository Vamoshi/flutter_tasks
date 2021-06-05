import 'package:flutter_tasks/repos/data/repos_data.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';

class Repository {
  final repoProvider = ReposData();

  Future<List<Repos>> fetchRepos(searchString, page) async {
    final List items = await repoProvider.fetchRepos(searchString, page);

    List<Repos> repos = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      repos.add(Repos(
        id: item["id"],
        name: item["name"] ?? "No Name",
        language: item["language"] ?? "No Language",
        url: item["url"] ?? "No HTML_URL",
        description: item["description"] ?? "No Description",
      ));
    }

    return repos;
  }
}
