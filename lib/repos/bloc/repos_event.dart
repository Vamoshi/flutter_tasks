part of 'repos_bloc.dart';

abstract class ReposEvent extends Equatable {
  const ReposEvent();

  @override
  List<Object> get props => [];
}

class ReposFetched extends ReposEvent {}

class ReposChosen extends ReposEvent {
  final Repos repo;
  ReposChosen({required this.repo});
}
