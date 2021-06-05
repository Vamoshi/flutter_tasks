import 'package:flutter_tasks/repos/data/repos_data.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';
import 'package:flutter_tasks/user/data/user_data.dart';
import 'package:flutter_tasks/user/models/user_model.dart';

class ReposRepository {
  final _repoProvider = ReposData();

  Future<List<Repos>> fetchRepos(searchString, page) async {
    final List items = await _repoProvider.fetchRepos(searchString, page);

    List<Repos> repos = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      repos.add(Repos(
        id: item["id"],
        name: item["name"] ?? "No Name",
        language: item["language"] ?? "No Language",
        url: item["html_url"] ?? "No HTML_URL",
        description: item["description"] ?? "No Description",
        ownerId: item["owner"]["id"] ?? "No owner ID",
      ));
    }

    return repos;
  }
}

class UserRepository {
  final _userProvider = UserData();

  Future<User> fetchUser(userId) async {
    final user = await _userProvider.fetchUser(userId);

    return User(
      user["id"],
      user["login"],
      user["avatar_url"],
      user['html_url'],
      user['followers'],
      user['following'],
    );
  }
}
