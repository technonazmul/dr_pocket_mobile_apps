import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('http://localhost:5000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': _phoneController.text,
          'password': _passwordController.text,
        }),
      );
      if (response.statusCode == 200) {
        // Handle success
        Fluttertoast.showToast(msg: 'Login successful');
      } else {
        // Handle failure
        Fluttertoast.showToast(msg: 'Login failed');
      }
    }
  }

  void _forgotPassword() {
    // Navigate to forgot password page or show dialog
    Fluttertoast.showToast(msg: 'Forgot Password Clicked');
  }

  void _register() {
    // Navigate to the register page
    Fluttertoast.showToast(msg: 'Register Clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
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
                      backgroundColor:
                          const Color(0xFF0094FF), // Background color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                  onPressed: _login,
                  child: const Text('Sign In'),
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
