import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_ccp/components/games.dart';
import 'package:mad_ccp/models/user_model.dart';
import 'package:mad_ccp/providers/games_provider.dart';
import 'package:mad_ccp/providers/progress_provider.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  run() async {
    setState(() {
      _isLoading = true;
    });
    await addData();
    await loadGames();
    await loadProgress();
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;
  bool _isGamesLoading = false;
  bool _isProgressLoading = false;

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

  loadProgress() async {
    setState(() {
      _isProgressLoading = true;
    });
    ProgressProvider progressProvider = Provider.of(context, listen: false);
    await progressProvider.refreshProgress(_auth.currentUser!.uid);
    setState(() {
      _isProgressLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get games
    return _isLoading || _isGamesLoading || _isProgressLoading
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
