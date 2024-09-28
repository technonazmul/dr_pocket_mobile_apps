import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Schedule the navigation after the first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed('/');
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity, // Ensures it takes full width
          height: double.infinity, // Ensures it takes full height
          child: FittedBox(
            fit: BoxFit.cover, // Specify how to fit the image
            child: Image.asset(
                'assets/images/splash.png'), // Ensure this path is correct
          ),
        ),
      ),
    );
  }
}
