part of 'repos_bloc.dart';

enum ReposStatus { initial, success, failure }

class ReposState extends Equatable {
  final ReposStatus status;
  final List<Repos> repos;
  final bool hasReachedMax;
  final int page;
  final String searchString;

  const ReposState({
    this.status = ReposStatus.initial,
    this.repos = const <Repos>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.searchString = "",
  });

  ReposState copyWith({
    ReposStatus? status,
    List<Repos>? repos,
    bool? hasReachedMax,
    int? page,
    String? searchString,
  }) {
    return ReposState(
      status: status ?? this.status,
      repos: repos ?? this.repos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      searchString: searchString ?? this.searchString,
    );
  }

  @override
  String toString() {
    return '''RepoState {status: $status, hasReachedMax: $hasReachedMax, repos: ${repos.length}, $page}''';
  }

  @override
  List<Object?> get props => [status, repos, hasReachedMax, page];
}
