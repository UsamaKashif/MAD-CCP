import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_ccp/models/user_model.dart';
import 'package:mad_ccp/providers/progress_provider.dart';
import 'package:mad_ccp/providers/user_provider.dart';
import 'package:mad_ccp/screens/success_screen.dart';
import 'package:mad_ccp/utils/auth_methods.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:mad_ccp/utils/progress_methods.dart';
import 'package:mad_ccp/utils/utils.dart';
import 'package:provider/provider.dart';

class SpellingGame extends StatefulWidget {
  final Map game;
  const SpellingGame({super.key, required this.game});

  @override
  State<SpellingGame> createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  final ProgressMethods _progressMethods = ProgressMethods();
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void correctSelect() async {
    ProgressProvider progressProvider = Provider.of(context, listen: false);
    Map progress = progressProvider.getProgress!;
    if (progress["spelling"] != widget.game["level"]) {
      // ignore: use_build_context_synchronously
      showSnackBar("Correct Answer", context);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const SuccessScreen();
      }));
      return;
    }
    int level = widget.game["level"] + 1 > 5 ? 6 : widget.game["level"] + 1;
    _progressMethods.updateProgress(_auth.currentUser!.uid, "spelling", level);
    await progressProvider.refreshProgress(_auth.currentUser!.uid);
    // ignore: use_build_context_synchronously
    UserProvider user = Provider.of(context, listen: false);
    UserModel userModel = user.getUser!;
    _authMethods.updateUserScore(_auth.currentUser!.uid, userModel.score + 5);
    await user.refreshUser();
    // ignore: use_build_context_synchronously
    showSnackBar("Correct Answer", context);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const SuccessScreen();
    }));
  }

  void incorrectSelect() {
    showSnackBar("Incorrect Answer! Please try again", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spelling Game: Level ${widget.game["level"]}'),
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select the word with correct spelling",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                  minimumSize: const Size(double.infinity, 57),
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: correctSelect,
                child: Text(widget.game["correct"].toString().toUpperCase()),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                  minimumSize: const Size(double.infinity, 57),
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: incorrectSelect,
                child: Text(widget.game["incorrect"].toString().toUpperCase()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
