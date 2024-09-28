import 'package:flutter/material.dart';
import 'views/auth/login_page.dart';
import 'views/auth/signup_page.dart';
import 'views/auth/otp_page.dart';
import 'views/home/home_page.dart';
import 'views/home/edit_profile_page.dart';
import 'views/home/speciality_page.dart';
import 'views/others/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE9F7FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0094FF),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/otp': (context) => const OtpPage(),
        '/userprofile': (context) => const EditProfilePage(),
        '/speciality': (context) => const SpecialityPage()
      },
    );
  }
}
