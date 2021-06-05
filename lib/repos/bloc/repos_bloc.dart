import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_tasks/repos/data/repository.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';

part 'repos_event.dart';
part 'repos_state.dart';

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  final http.Client httpClient;
  final String _searchString;
  final _repository = Repository();
  late Repos _repo;

  ReposBloc(this.httpClient, this._searchString) : super(const ReposState());

  String get searchString => _searchString;
  Repos get repo => _repo;

  @override
  Stream<ReposState> mapEventToState(ReposEvent event) async* {
    if (event is ReposFetched) {
      yield await _mapReposStateToState(state);
    }
    if (event is ReposChosen) {
      this._repo = event.repo;
    }
  }

  Future<ReposState> _mapReposStateToState(ReposState state) async {
    if (state.hasReachedMax) return state;

    // Initialize
    try {
      if (state.status == ReposStatus.initial) {
        final List<Repos> repos =
            await _repository.fetchRepos(_searchString, state.page);

        return state.copyWith(
          status: ReposStatus.success,
          repos: repos,
          hasReachedMax: false,
          page: 1,
          searchString: _searchString,
        );
      }

      // Fetching new
      final repos = await _repository.fetchRepos(_searchString, state.page);

      return repos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ReposStatus.success,
              repos: List.of(state.repos)..addAll(repos),
              hasReachedMax: false,
              page: state.page + 1,
              searchString: _searchString,
            );
    } on Exception {
      return state.copyWith(status: ReposStatus.failure);
    }
  }
}
