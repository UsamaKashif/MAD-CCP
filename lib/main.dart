import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mad_ccp/providers/user_provider.dart';
import 'package:mad_ccp/screens/home_screen.dart';
import 'package:mad_ccp/screens/signup_screen.dart';
import 'package:mad_ccp/utils/colors.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        title: 'Learn N Play',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
            background: AppColors.white,
          ),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const SignUp();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ),
      ),
    );
  }
}
