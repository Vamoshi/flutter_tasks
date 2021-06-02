import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_tasks/repos/data/repository.dart';
import 'package:flutter_tasks/repos/models/repo_model.dart';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';

part 'repos_event.dart';
part 'repos_state.dart';

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  final http.Client httpClient;
  final String searchString;
  final repository = Repository();

  ReposBloc(this.httpClient, this.searchString) : super(const ReposState());

  String get getSearchString => searchString;

  @override
  Stream<ReposState> mapEventToState(ReposEvent event) async* {
    print("In the stream of repo_bloc");

    if (event is ReposFetched) {
      yield await _mapReposStateToState(state);
    }
  }

  Future<ReposState> _mapReposStateToState(ReposState state) async {
    print("hasreachedmax: ${state.hasReachedMax}");

    if (state.hasReachedMax) return state;
    try {
      print("initializing ");

      if (state.status == ReposStatus.initial) {
        final items = await repository.fetchRepos(searchString, state.page);

        final repos = items.map(
          (dynamic item) {
            return Repo(
              id: item["id"],
              name: item["name"] ?? "No Name",
              language: item["language"] ?? "No Language",
              url: item["url"] ?? "No HTML_URL",
              description: item["description"] ?? "No Description",
            );
          },
        ) as List<Repo>;

        return state.copyWith(
          status: ReposStatus.success,
          repos: repos,
          hasReachedMax: false,
          page: 1,
          searchString: searchString,
        );
      }

      final repos = await repository.fetchRepos(searchString, state.page);

      return repos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ReposStatus.success,
              repos: List.of(state.repos)..addAll(repos as Iterable<Repo>),
              hasReachedMax: false,
              page: state.page + 1,
              searchString: searchString,
            );
    } on Exception {
      return state.copyWith(status: ReposStatus.failure);
    }
  }
}
