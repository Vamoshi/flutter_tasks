part of 'login_bloc.dart';

enum LoginStatus { initial, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginModel login;

  const LoginState({
    this.status = LoginStatus.initial,
    this.login = const LoginModel(
      email: '',
      message: '',
      userId: -1,
    ),
  });

  LoginState copywith({LoginStatus? status, LoginModel? login}) {
    return LoginState(
      status: status ?? this.status,
      login: login ?? this.login,
    );
  }

  @override
  List<Object?> get props => [status, login];
}
