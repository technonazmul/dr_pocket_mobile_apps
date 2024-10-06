import 'package:flutter/material.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to Login Page
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Go to Login Page'),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Signup Page
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Go to Signup Page'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to otp
                Navigator.pushNamed(context, '/otp');
              },
              child: const Text('Go to OTP'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to otp
                Navigator.pushNamed(context, '/userprofile');
              },
              child: const Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to otp
                Navigator.pushNamed(context, '/speciality');
              },
              child: const Text('Speciality'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to otp
                Navigator.pushNamed(context, '/appointment');
              },
              child: const Text('Appointment'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to otp
                Navigator.pushNamed(context, '/doctorsearch');
              },
              child: const Text('Search Doctor'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to otp
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
