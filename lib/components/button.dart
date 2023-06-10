import 'package:flutter/material.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final isLoading;
  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
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
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : Text(text));
  }
}
