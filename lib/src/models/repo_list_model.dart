import 'package:flutter_tasks/src/models/repo_model.dart';

class RepoListModel {
  final List<Repo> _repos = [];

  RepoListModel.fromJson(List items) {
    List<Repo> temp = [];

    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      temp.add(
        Repo(
            id: item["id"] ?? 0,
            name: item["name"] ?? "no name",
            language: item["language"] ?? "no language",
            url: item["html_url"] ?? "no url",
            description: item["description"] ?? "no description"),
      );
    }

    print("Temp ${temp.length}");

    _repos.addAll(temp);
  }

  List<Repo> get repos => _repos;
}
