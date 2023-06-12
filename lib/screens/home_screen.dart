import 'package:flutter/material.dart';
import 'package:mad_ccp/components/games.dart';
import 'package:mad_ccp/providers/games_provider.dart';
import 'package:mad_ccp/providers/user_provider.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    run();
  }

  run() async {
    setState(() {
      _isLoading = true;
    });
    await addData();
    await loadGames();
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;
  bool _isGamesLoading = false;

  addData() async {
    setState(() {
      _isLoading = true;
    });
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      _isLoading = false;
    });
  }

  loadGames() async {
    setState(() {
      _isGamesLoading = true;
    });
    GamesProvider gamesProvider = Provider.of(context, listen: false);
    await gamesProvider.refreshGames();
    setState(() {
      _isGamesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get games
    return _isLoading || _isGamesLoading
        ? Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Getting Ready",
                    style: TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          )
        : const Games();
  }
}
