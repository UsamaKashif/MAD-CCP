import 'package:flutter/material.dart';
import 'package:mad_ccp/models/game_model.dart';
import 'package:mad_ccp/providers/games_provider.dart';
import 'package:mad_ccp/screens/counting_game.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:provider/provider.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CountingGameScreen(gameId: game.name.toLowerCase());
            },
          ),
        );
      },
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                game.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Card(
                color: AppColors.black.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        game.name,
                        style: TextStyle(
                          fontFamily: AppFonts.openSans,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
