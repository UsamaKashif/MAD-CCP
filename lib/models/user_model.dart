class User {
  final String email;
  final String fullName;
  int score;
  String? recentGame;

  User({
    required this.email,
    required this.fullName,
    this.score = 0,
    this.recentGame,
  });
}
