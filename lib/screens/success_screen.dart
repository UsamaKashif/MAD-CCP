import 'package:flutter/material.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Level Cleared!",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ],
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
                    foregroundColor: AppColors.black,
                    backgroundColor: AppColors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Next Level",
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 32,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
