import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String userName;
  final String image;
  final String url;
  final int followers;
  final int following;

  const User(this.id, this.userName, this.image, this.url, this.followers,
      this.following);

  @override
  List<Object?> get props => [id, userName, image, url, followers, following];
}
