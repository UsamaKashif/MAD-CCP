import 'package:flutter/material.dart';
import 'package:mad_ccp/models/user_model.dart';
import 'package:mad_ccp/providers/user_provider.dart';
import 'package:mad_ccp/screens/login_screen.dart';
import 'package:mad_ccp/utils/auth_methods.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:mad_ccp/utils/utils.dart';
import 'package:provider/provider.dart';

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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser as UserModel;
    return Drawer(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "My Score",
                    style: TextStyle(
                      fontFamily: AppFonts.valeriaRound,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    tileColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    titleTextStyle: TextStyle(
                      fontFamily: AppFonts.valeriaRound,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    title: Center(
                      child: Text("${user.score}"),
                    ),
                  ),
                ],
              ),
              ListTile(
                tileColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                titleTextStyle: TextStyle(
                  fontFamily: AppFonts.valeriaRound,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
                title: const Center(
                  child: Text("Sign Out"),
                ),
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
