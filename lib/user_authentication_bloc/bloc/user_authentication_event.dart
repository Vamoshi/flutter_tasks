part of 'user_authentication_bloc.dart';

abstract class UserAuthenticationEvent extends Equatable {
  const UserAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AttemptedLogin extends UserAuthenticationEvent {
  final String email;
  final String password;

  AttemptedLogin({required this.email, required this.password});
}

class AttemptedRegister extends UserAuthenticationEvent {
  final String email;
  final String password;

  AttemptedRegister({required this.email, required this.password});
}

class AttemptedFitbitAuthorization extends UserAuthenticationEvent {}
