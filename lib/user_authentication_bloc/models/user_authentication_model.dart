import 'package:equatable/equatable.dart';

class UserAuthenticationModel extends Equatable {
  final String email;
  final String message;
  final int userId;

  const UserAuthenticationModel({
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
