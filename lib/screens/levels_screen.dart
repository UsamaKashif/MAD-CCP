import 'package:flutter/material.dart';
import 'package:mad_ccp/components/side_bar.dart';
import 'package:mad_ccp/providers/games_provider.dart';
import 'package:mad_ccp/providers/progress_provider.dart';
import 'package:mad_ccp/screens/counting_game.dart';
import 'package:mad_ccp/screens/spelling_game.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:provider/provider.dart';

class LevelsScreen extends StatefulWidget {
  final String gameId;
  const LevelsScreen({super.key, required this.gameId});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
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
    Map<String, dynamic> progress =
        Provider.of<ProgressProvider>(context).getProgress!;
    int currentLevel = progress[widget.gameId];
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
            appBar: AppBar(
              backgroundColor: AppColors.white,
              title: Text(
                "Select a level to play",
                style: TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            endDrawer: const SideBar(),
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                              onTap: () {
                                if (widget.gameId == "counting") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return CountingGameScreen(
                                        gameID: "counting",
                                        level: index + 1,
                                        currentLevel: currentLevel,
                                      );
                                    }),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SpellingGame(
                                      game: g[index],
                                    );
                                  }),
                                );
                              },
                              enabled: currentLevel >= index + 1,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              // change border radius
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              tileColor: currentLevel > index + 1
                                  ? AppColors.accentColor
                                  : currentLevel == index + 1
                                      ? AppColors.primaryColor
                                      : AppColors.black.withOpacity(0.5),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Level ${g[index]["level"]}",
                                    style: TextStyle(
                                      fontFamily: AppFonts.valeriaRound,
                                      fontSize: 20,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  currentLevel < index + 1
                                      ? const Icon(
                                          Icons.lock,
                                        )
                                      : currentLevel == index + 1
                                          ? const Icon(
                                              Icons.arrow_right,
                                              size: 40,
                                              color: AppColors.white,
                                            )
                                          : const Icon(
                                              Icons.check,
                                              color: AppColors.white,
                                            )
                                ],
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
