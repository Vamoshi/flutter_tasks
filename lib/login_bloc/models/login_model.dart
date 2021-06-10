import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String email;
  final String message;
  final int userId;

  const LoginModel({
    required this.email,
    required this.message,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        email,
        message,
        userId,
      ];
}
