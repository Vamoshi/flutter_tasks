import 'package:flutter_tasks/old/models/repo_model.dart';

class RepoListModel {
  final List<Repo> _repos = [];

  RepoListModel();

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

    _repos.addAll(temp);
  }

  void addRepos(RepoListModel newList) {
    _repos.addAll(newList.repos);
  }

  List<Repo> get repos => _repos;
}
