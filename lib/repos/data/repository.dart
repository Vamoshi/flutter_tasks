import 'package:flutter_tasks/repos/data/repo_provider.dart';
import 'package:flutter_tasks/repos/models/repo_model.dart';

class Repository {
  final repoProvider = RepoProvider();

  Future<List<Repo>> fetchRepos(searchString, page) async {
    final List items = await repoProvider.fetchRepos(searchString, page);

    List<Repo> repos = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      repos.add(Repo(
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
