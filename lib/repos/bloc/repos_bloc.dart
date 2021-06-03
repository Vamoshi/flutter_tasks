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
    if (event is ReposFetching) {
      yield await _mapReposStateToState(state);
    }
  }

  Future<ReposState> _mapReposStateToState(ReposState state) async {
    if (state.hasReachedMax) return state;

    // Initialize
    try {
      if (state.status == ReposStatus.initial) {
        final List<Repo> repos =
            await repository.fetchRepos(searchString, state.page);

        return state.copyWith(
          status: ReposStatus.success,
          repos: repos,
          hasReachedMax: false,
          page: 1,
          searchString: searchString,
        );
      }

      print("------------------");

      // Fetching new
      final repos = await repository.fetchRepos(searchString, state.page);

      return repos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ReposStatus.success,
              repos: List.of(state.repos)..addAll(repos),
              hasReachedMax: false,
              page: state.page + 1,
              searchString: searchString,
            );
    } on Exception {
      return state.copyWith(status: ReposStatus.failure);
    }
  }
}
