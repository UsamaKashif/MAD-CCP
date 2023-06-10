import 'package:flutter/material.dart';
import 'package:mad_ccp/components/side_bar.dart';
import 'package:mad_ccp/utils/auth_methods.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideBar(),
      appBar: AppBar(
          backgroundColor: AppColors.accentColor,
          foregroundColor: AppColors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Learn N Play",
                style: TextStyle(
                  fontFamily: AppFonts.valeriaRound,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          )),
    );
  }
}
