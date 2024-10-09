import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  late String _phoneNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the phone number passed from the SignupPage
    _phoneNumber = ModalRoute.of(context)?.settings.arguments as String;
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((controller) => controller.text).join();

    if (otp.length == 4) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:5000/api/auth/verify-otp'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone': _phoneNumber, // Use the passed phone number here
            'otp': otp,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final token = responseData['token'];

          // Store the token locally, e.g., using shared_preferences
          await SharedPreferences.getInstance().then((prefs) {
            prefs.setString('token', token);
          });

          Navigator.pushNamed(context, '/home');
        } else {
          final errorData = jsonDecode(response.body);
          final errorMessage = errorData['message'] ?? 'Unknown error';
          print('Failed: $errorMessage');
        }
      } catch (e) {
        print('An error occurred: $e');
      }
    } else {
      print('Invalid OTP');
    }
  }

  void _resendOtp() {
    print("OTP resent");
  }

  @override
  void dispose() {
    // Clean up the controllers and focus nodes to prevent memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Code')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please enter the code we just sent to your phone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  color: Color.fromARGB(255, 53, 64, 68),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      counterText: '', // Hides the length counter at the bottom
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index + 1]);
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index - 1]);
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resendOtp,
              child: const Text("Didn't receive OTP? Resend code"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: _verifyOtp,
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
                child: const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
