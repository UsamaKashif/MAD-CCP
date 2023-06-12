import 'package:flutter/material.dart';
import 'package:mad_ccp/components/game_card.dart';
import 'package:mad_ccp/components/side_bar.dart';
import 'package:mad_ccp/models/game_model.dart';
import 'package:mad_ccp/providers/games_provider.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:provider/provider.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    Map<String, GameModel> games =
        Provider.of<GamesProvider>(context).getGame as Map<String, GameModel>;

    return Scaffold(
      endDrawer: const SideBar(),
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Learn N Play",
              style: TextStyle(
                fontFamily: AppFonts.valeriaRound,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Games To Play",
              style: TextStyle(
                fontFamily: AppFonts.openSans,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // loop thorugh the games
            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return GameCard(
                    game: games.values.elementAt(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
