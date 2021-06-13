part of 'user_authentication_bloc.dart';

enum UserAuthenticationStatus {
  UserAuthInitial,
  UserAuthSuccess,
  UserAuthFailure,
  FitbitAuthFailure,
  FitbitAuthSuccess,
}

class UserAuthenticationState extends Equatable {
  final UserAuthenticationStatus status;
  final UserAuthenticationModel login;

  const UserAuthenticationState({
    this.status = UserAuthenticationStatus.UserAuthInitial,
    this.login = const UserAuthenticationModel(
      email: '',
      message: '',
      userId: -1,
    ),
  });

  UserAuthenticationState copywith({
    UserAuthenticationStatus? status,
    UserAuthenticationModel? login,
  }) {
    return UserAuthenticationState(
      status: status ?? this.status,
      login: login ?? this.login,
    );
  }

  @override
  List<Object?> get props => [status, login];
}
