import 'dart:math';

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

class CountingGameScreen extends StatefulWidget {
  final String gameID;
  final int level;
  final int currentLevel;

  const CountingGameScreen(
      {super.key,
      required this.gameID,
      required this.level,
      required this.currentLevel});

  @override
  State<CountingGameScreen> createState() => _CountingGameScreenState();
}

class _CountingGameScreenState extends State<CountingGameScreen> {
  final List<Widget> _circleWidgets = [];
  final List<Widget> _numberTiles = [];

  final ProgressMethods _progressMethods = ProgressMethods();
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _createCircles();
    _createNumberTiles();
    // randomize the number tiles
    _numberTiles.shuffle();
  }

  void checkAnswer(int answer) async {
    if (widget.level != widget.currentLevel) {
      if (answer == widget.level) {
        showSnackBar("Correct Answer", context);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const SuccessScreen();
        }));
      } else {
        showSnackBar("Incorrect Answer! Please try again", context);
      }
      return;
    }

    if (answer == widget.level) {
      int level = widget.level + 1 > 5 ? 6 : widget.level + 1;
      _progressMethods.updateProgress(
          _auth.currentUser!.uid, widget.gameID, level);
      ProgressProvider progressProvider = Provider.of(context, listen: false);
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
    } else {
      showSnackBar("Incorrect Answer! Please try again", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Counting Game'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: _circleWidgets,
            ),
          ),
          Text(
            'Select the correct number of circles',
            style: TextStyle(
              fontFamily: AppFonts.openSans,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: _numberTiles,
            ),
          ),
        ],
      ),
    );
  }

  void _createCircles() {
    int circleCount = widget.level;

    setState(() {
      _circleWidgets.clear();

      for (int i = 0; i < circleCount; i++) {
        _circleWidgets.add(
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 50.0,
            height: 50.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        );
      }
    });
  }

  List _generateRandomNumber() {
    var random = Random();
    var list = List.generate(6, (_) => random.nextInt(10));
    return list;
  }

  void _createNumberTiles() {
    // create a list of numbers from 1 to 5
    // shuffle the list
    // create a grid view of the numbers

    // create a list of 5 random numbers, and it should include the currentLevel
    List randomNumbers = _generateRandomNumber();
    // check if the list contains the currentLevel
    if (!randomNumbers.contains(widget.level)) {
      // if not, replace the first number with the currentLevel
      randomNumbers[0] = widget.level;
    }

    for (int i = 0; i < randomNumbers.length; i++) {
      // create a number tile
      // add it to a list
      setState(() {
        _numberTiles.add(
          GestureDetector(
            onTap: () {
              checkAnswer(randomNumbers[i]);
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 100.0,
              height: 100.0,
              child: Card(
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    randomNumbers[i].toString(),
                    style: TextStyle(
                      fontFamily: AppFonts.openSans,
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
    }
  }
}
