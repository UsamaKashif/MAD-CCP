import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_ccp/models/game_model.dart';

// create custom type
/* 
{
  level1: 1,
  level2: 2,

}
*/

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

  Future<List> getGameLevels(String gameId) async {
    // games => game => levels => level1 => count:1
    List levels = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('games')
          .doc(gameId)
          .collection('levels')
          .get();
      for (var element in querySnapshot.docs) {
        Map level = element.data() as Map;
        levels.add(level);
      }
      return levels;
    } catch (e) {
      return levels;
    }
  }
}
