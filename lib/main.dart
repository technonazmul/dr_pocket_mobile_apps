import 'views/home/appointment_history_page.dart';
import 'package:flutter/material.dart';
import 'views/auth/login_page.dart';
import 'views/auth/signup_page.dart';
import 'views/auth/otp_page.dart';
import 'views/home/home_page.dart';
import 'views/home/link_page.dart';
import 'views/home/edit_profile_page.dart';
import 'views/home/speciality_page.dart';
import 'views/others/splash_screen.dart';
import 'views/home/appointment_page.dart';
import 'views/home/search_doctors_page.dart';
import 'views/home/search_doctors_by_speciality_page.dart';
import 'views/home/profilesetting_page.dart';
import 'views/home/change_password_page.dart';
import 'views/home/notification_page.dart';
import 'views/home/myappointment_page.dart';

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
        '/': (context) => const LinkPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/otp': (context) => const OtpPage(),
        '/userprofile': (context) => const EditProfilePage(),
        '/speciality': (context) => const SpecialityPage(),
        '/appointment': (context) => const AppointmentPage(),
        '/doctorsearch': (context) => const DoctorSearchPage(),
        '/doctorsearchbyspeciality': (context) =>
            const DoctorSearchBySpecialityPage(),
        '/profilesetting': (context) => const ProfileSettingPage(),
        '/changepassword': (context) => const ChangePasswordPage(),
        '/notifications': (context) => const NotificationPage(),
        '/myappointment': (context) => const MyAppointmentPage(),
        '/appointmenthistory': (context) => const AppointmentHistoryPage(),
      },
    );
  }
}
