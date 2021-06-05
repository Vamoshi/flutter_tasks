part of 'user_bloc.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable {
  final UserStatus status;
  final User user;

  const UserState({
    this.status = UserStatus.initial,
    this.user = const User(0, "", "", "", 0, 0),
  });

  UserState copywith({
    UserStatus? status,
    User? user,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
