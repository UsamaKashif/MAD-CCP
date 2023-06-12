import 'package:flutter/material.dart';
import 'package:mad_ccp/models/game_model.dart';
import 'package:mad_ccp/providers/games_provider.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:provider/provider.dart';

class CountingGameScreen extends StatefulWidget {
  final String gameId;

  const CountingGameScreen({super.key, required this.gameId});

  @override
  State<CountingGameScreen> createState() => _CountingGameScreenState();
}

class _CountingGameScreenState extends State<CountingGameScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchGame();
  }

  void fetchGame() async {
    setState(() {
      _isLoading = true;
    });
    GamesProvider gamesProvider = Provider.of(context, listen: false);
    await gamesProvider.refreshGameLevels(widget.gameId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List g = Provider.of<GamesProvider>(context).getGameLevels;
    return _isLoading
        ? const Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "Select a level to play",
                        style: TextStyle(
                          fontFamily: AppFonts.openSans,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12,
                          ),
                          child: Card(
                            child: ListTile(
                              onTap: () {},
                              enabled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              // change border radius
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              tileColor: AppColors.accentColor,
                              title: Text(
                                "Level ${g[index]["level"]}",
                                style: TextStyle(
                                  fontFamily: AppFonts.valeriaRound,
                                  fontSize: 20,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: g.length,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
