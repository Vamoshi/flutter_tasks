class User {
  String username;
  String imageUrl;
  int followers;
  int followings;
  int publicRepo;
  String joinedDate;

  User({
    required this.username,
    required this.imageUrl,
    required this.followers,
    required this.followings,
    required this.publicRepo,
    required this.joinedDate,
  });
}
