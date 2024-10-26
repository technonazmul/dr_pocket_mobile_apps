import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../views/inc/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = false;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': _phoneController.text,
          'password': _passwordController.text,
        }),
      );
      if (!mounted) return;
      if (response.statusCode == 200) {
        // Registration successful, redirect to OTP page

        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userName = responseData['user']['name'];
        final image = responseData['user']['image'] ?? 'no_profile_picture.jpg';
        final userId = responseData['user']['id'];
        final isVerified = responseData['user']['isVerified'];
        String phoneNumber = _phoneController.text;

        // Store the token locally (you can use shared_preferences or similar)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        if (isVerified != true) {
          final responseOtpResend = await http.post(
            Uri.parse('http://127.0.0.1:5000/api/auth/resend-otp'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'phone': phoneNumber, // Use the passed phone number here
            }),
          );

          if (response.statusCode == 200) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(
              context,
              '/otp',
              arguments: phoneNumber,
            );
          } else {
            showCustomToast(context, 'Failed Try Again.');
          }
        } else {
          Navigator.pushNamed(context, '/home');
        }
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] ?? 'Unknown error';
        showCustomToast(context, 'Failed: $errorMessage');
      }
    }
  }

  void _forgotPassword() {
    // Navigate to forgot password page or show dialog
    showCustomToast(context, 'Forgot Password Clicked');
  }

  void _register() {
    // Navigate to the register page
    showCustomToast(context, 'Register Clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text(
                'Hi, Welcome back!',
                style: TextStyle(
                    color: Color.fromRGBO(53, 64, 68, 1), fontSize: 16),
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _forgotPassword,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF0094FF),
                  ),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),
              // Make the ElevatedButton 80% of screen width
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0094FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: _isButtonDisabled ? null : _login,
                  child: _isButtonDisabled
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2.0,
                          ))
                      : const Text('Sing In'),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'By clicking “Sign in” you certify you agree to our terms and conditions',
                  style: TextStyle(
                    color: Color(0xFF354044), // Updated color
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'New user?',
                      style: const TextStyle(
                        color: Color(0xFF354044),
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                      text: 'Register',
                      style: const TextStyle(
                        color: Color(0xFF0094FF),
                        fontSize: 18,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = _register,
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
