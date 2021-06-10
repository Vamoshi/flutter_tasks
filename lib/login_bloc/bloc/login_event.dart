part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AttemptedLogin extends LoginEvent {
  final String email;
  final String password;

  AttemptedLogin({required this.email, required this.password});
}

class AttemptedRegister extends LoginEvent {}
