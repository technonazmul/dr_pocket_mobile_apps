import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../views/inc/custom_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false; // Check state

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_agreeToTerms) {
        // Handle registration logic here
        try {
          // Prepare the registration data
          final response = await http.post(
            Uri.parse('http://localhost:5000/api/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': _fullNameController.text,
              'phone': _phoneController.text,
              'password': _passwordController.text,
            }),
          );

          if (response.statusCode == 200) {
            // Registration successful, redirect to OTP page

            final responseData = jsonDecode(response.body);
            final token = responseData['token'];
            String phoneNumber = _phoneController.text;

            // Store the token locally (you can use shared_preferences or similar)
            await SharedPreferences.getInstance().then((prefs) {
              prefs.setString('token', token);
            });

            // ignore: use_build_context_synchronously
            Navigator.pushNamed(
              context,
              '/otp',
              arguments: phoneNumber,
            );
          } else {
            final errorData = jsonDecode(response.body);
            final errorMessage = errorData['message'] ?? 'Unknown error';
            showCustomToast(context, 'Failed: $errorMessage');
          }
        } catch (e) {
          showCustomToast(context, 'An error occured: $e');
        }
      } else {
        showCustomToast(context, 'You must agree to the terms and conditions');
      }
    } else if (!_agreeToTerms) {
      showCustomToast(context, 'You must agree to the terms and conditions');
    }
  }

  void _viewTermsAndConditions() {
    // For example, you can show a dialog or navigate to a new page
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms and Conditions'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Here are the terms and conditions...'),
                // Add more text or content here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _forgotPassword() {
    // Navigate to forgot password page or show dialog
    showCustomToast(context, 'Forgot Password Clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Fill your information below.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 74, 76, 77),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixText: '+88 ', // Add the non-editable prefix here
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                    // The phone number should be 11 digits long without the prefix
                    if (value.length != 11) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: RichText(
                    text: TextSpan(
                      text: 'I agree to the ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: const TextStyle(color: Color(0xFF0094FF)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _viewTermsAndConditions,
                        ),
                      ],
                    ),
                  ),
                  value: _agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 20),
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
                    onPressed: _register,
                    child: const Text('Sign Up'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: RichText(
                      text: TextSpan(
                          text: 'Already Have Account?',
                          style: const TextStyle(
                            color: Color(0xFF354044),
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Color(0xFF0094FF),
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = _register,
                        ),
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
