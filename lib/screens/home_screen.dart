import 'package:flutter/material.dart';
import 'package:mad_ccp/components/side_bar.dart';
import 'package:mad_ccp/models/user_model.dart';
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
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser as UserModel;
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
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome"),
            Text(user.fullName),
          ],
        ),
      ),
    );
  }
}
