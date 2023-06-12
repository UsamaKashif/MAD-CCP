import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String name;
  final String description;
  final String img;

  GameModel({required this.name, required this.description, required this.img});

  static fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return GameModel(
      name: snapshot['name'],
      description: snapshot['description'],
      img: snapshot['img'],
    );
  }
}
