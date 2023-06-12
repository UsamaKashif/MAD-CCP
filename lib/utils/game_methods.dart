import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_ccp/models/game_model.dart';

class GameMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Map<String, GameModel>> getAllGames() async {
    Map<String, GameModel> games = {};
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('games').get();
      for (var element in querySnapshot.docs) {
        games[element.id] = GameModel.fromSnap(element);
      }
      return games;
    } catch (e) {
      return games;
    }
  }
}
