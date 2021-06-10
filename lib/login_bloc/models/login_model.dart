import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String email;
  final String password;

  const LoginModel({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
