import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_ccp/models/user_model.dart';
import 'package:mad_ccp/providers/progress_provider.dart';
import 'package:mad_ccp/providers/user_provider.dart';
import 'package:mad_ccp/screens/success_screen.dart';
import 'package:mad_ccp/utils/auth_methods.dart';
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
  final TextEditingController _textEditingController = TextEditingController();
  final List<Widget> _circleWidgets = [];

  final ProgressMethods _progressMethods = ProgressMethods();
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _createCircles();
  }

  void checkAnswer() async {
    int answer = int.parse(_textEditingController.text);
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
        title: Text('Counting Game: Level ${widget.level}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: _circleWidgets,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter circle count',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: const Text('Submit'),
                ),
              ],
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
}
