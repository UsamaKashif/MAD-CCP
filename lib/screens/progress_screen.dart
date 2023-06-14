import 'package:flutter/material.dart';
import 'package:mad_ccp/components/side_bar.dart';
import 'package:mad_ccp/models/user_model.dart';
import 'package:mad_ccp/providers/progress_provider.dart';
import 'package:mad_ccp/providers/user_provider.dart';
import 'package:mad_ccp/screens/home_screen.dart';
import 'package:mad_ccp/screens/levels_screen.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProgressProvider progressProvider =
        Provider.of<ProgressProvider>(context, listen: false);
    Map progress = progressProvider.getProgress as Map;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserModel user = userProvider.getUser as UserModel;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          },
          child: const Icon(Icons.home),
        ),
      ),
      endDrawer: const SideBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        child: Column(
          children: [
            Profile(
              user: user,
            ),
            Score(
              score: user.score,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Games Progress",
              style: TextStyle(
                fontFamily: AppFonts.openSans,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CountingProgress(
              progress: progress["counting"] as int,
            ),
            const SizedBox(
              height: 16,
            ),
            SpellingProgress(
              progress: progress["spelling"] as int,
            )
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final UserModel user;
  const Profile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.black.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              Text(
                user.fullName,
                style: TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                user.email,
                style: TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Score extends StatelessWidget {
  final int score;
  const Score({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              Text(
                "My Score",
                style: TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                score.toString(),
                style: TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountingProgress extends StatelessWidget {
  final int progress;
  const CountingProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LevelsScreen(gameId: "counting");
        }));
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Counting Game",
                  style: TextStyle(
                    fontFamily: AppFonts.valeriaRound,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    CircularProgressIndicator(
                      value: (progress - 1) / 5,
                      strokeWidth: 8,
                      semanticsLabel: "Counting Game Progress",
                      backgroundColor: AppColors.black.withOpacity(0.4),
                      color: AppColors.accentColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${progress - 1}/5",
                      style: TextStyle(
                        fontFamily: AppFonts.openSans,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpellingProgress extends StatelessWidget {
  final int progress;
  const SpellingProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LevelsScreen(gameId: "spelling");
        }));
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Spelling Game",
                  style: TextStyle(
                    fontFamily: AppFonts.valeriaRound,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    CircularProgressIndicator(
                      value: (progress - 1) / 5,
                      strokeWidth: 8,
                      semanticsLabel: "Spelling Game Progress",
                      backgroundColor: AppColors.black.withOpacity(0.4),
                      color: AppColors.accentColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${progress - 1}/5",
                      style: TextStyle(
                        fontFamily: AppFonts.openSans,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
