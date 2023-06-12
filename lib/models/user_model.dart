import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String fullName;
  int score;
  String? recentGame;

  UserModel({
    required this.email,
    required this.fullName,
    this.score = 0,
    this.recentGame = "null",
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'score': score,
      'recentGame': recentGame,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      score: snapshot['score'] ?? 0,
      recentGame: snapshot['recentGame'],
    );
  }
}
