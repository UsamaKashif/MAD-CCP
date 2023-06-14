import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionScreen extends StatefulWidget {
  const InternetConnectionScreen({super.key});

  @override
  State<InternetConnectionScreen> createState() =>
      _InternetConnectionScreenState();
}

class _InternetConnectionScreenState extends State<InternetConnectionScreen> {
  ConnectivityResult? _connectivityResult;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == ConnectivityResult.none) {
      return const Scaffold(
        body: Center(
          child: Text('No Internet Connection'),
        ),
      );
    } else {
      // Return your main widget or navigate to the appropriate screen
      return const Scaffold(
        body: Center(
          child: Text('Internet Connection Available'),
        ),
      );
    }
  }
}
