import 'package:flutter/material.dart';
import 'package:mad_ccp/screens/home_screen.dart';
import 'package:mad_ccp/screens/login_screen.dart';
import 'package:mad_ccp/utils/auth_methods.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:mad_ccp/utils/utils.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void logout() async {
    String res = await AuthMethods().signOut();
    if (res == "Success") {
      // ignore: use_build_context_synchronously
      showSnackBar("Signed out", context);
    }
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                tileColor: AppColors.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                titleTextStyle: TextStyle(
                  fontFamily: AppFonts.valeriaRound,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
                title: const Text("Sign Out"),
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
