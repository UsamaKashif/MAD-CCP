import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mad_ccp/screens/login_screen.dart';
import 'package:mad_ccp/utils/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign Up"),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Email Address", label: Text("Email Address")),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", label: Text("Password")),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    label: Text("Confirm Password")),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white),
                onPressed: () {},
                child: const Text("Sign Up"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text("Sign In"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
