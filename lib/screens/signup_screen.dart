import 'package:flutter/material.dart';
import 'package:mad_ccp/components/button.dart';
import 'package:mad_ccp/components/input.dart';
import 'package:mad_ccp/screens/home_screen.dart';
import 'package:mad_ccp/screens/login_screen.dart';
import 'package:mad_ccp/utils/auth_methods.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:mad_ccp/utils/fonts.dart';
import 'package:mad_ccp/utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
    );

    setState(() {
      _isLoading = false;
    });

    // ignore: use_build_context_synchronously
    showSnackBar(res, context);

    if (res == "Success") {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/logo.png"),
                const SizedBox(height: 56),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create an account",
                      style: TextStyle(
                        fontFamily: AppFonts.valeriaRound,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      "Create your account, it takes less than a minute - we promise",
                      style: TextStyle(
                        fontFamily: AppFonts.openSans,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Input(
                  hintText: "Full Name",
                  controller: fullNameController,
                ),
                const SizedBox(height: 12),
                Input(
                  hintText: "Email Address",
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                Input(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 24),
                Button(
                  text: "Create Account",
                  onPressed: signUpUser,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        "SignIn",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                        ),
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
