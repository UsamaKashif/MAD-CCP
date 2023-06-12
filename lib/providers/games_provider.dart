import 'package:flutter/material.dart';
import 'package:mad_ccp/models/game_model.dart';
import 'package:mad_ccp/utils/game_methods.dart';

class GamesProvider extends ChangeNotifier {
  Map<String, GameModel>? _games;
  List? _gameLevels;
  final GameMethods _gameMethods = GameMethods();

  Map<String, GameModel>? get getGame => _games;

  List get getGameLevels => _gameLevels!;

  Future<void> refreshGames() async {
    _games = await _gameMethods.getAllGames();
    notifyListeners();
  }

  Future<void> refreshGameLevels(String gameId) async {
    _gameLevels = await _gameMethods.getGameLevels(gameId);
    notifyListeners();
  }
}
