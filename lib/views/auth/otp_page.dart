import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/inc/custom_toast.dart';

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
  bool _isResendButtonDisabled = false;
  bool _isButtonDisabled = false;
  int _countdown = 0;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the phone number passed from the SignupPage
    _phoneNumber = ModalRoute.of(context)?.settings.arguments as String;
    //_phoneNumber = "01619139091";
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((controller) => controller.text).join();

    if (otp.length == 4) {
      try {
        _isButtonDisabled = true;
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
          showCustomToast(context, 'Failed: $errorMessage');
          _isButtonDisabled = false;
        }
      } catch (e) {
        showCustomToast(context, 'An error occurred: $e');
      }
    } else {
      showCustomToast(context, 'Invalid OTP');
    }
  }

  Future<void> _resendOtp() async {
    if (_isResendButtonDisabled) return;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/auth/resend-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': _phoneNumber, // Use the passed phone number here
        }),
      );

      if (response.statusCode == 200) {
        showCustomToast(context, 'OTP resent successfully');

        // Start countdown for 10 seconds
        setState(() {
          _isResendButtonDisabled = true;
          _countdown = 10;
        });

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (_countdown > 0) {
              _countdown--;
            } else {
              _isResendButtonDisabled = false;
              _timer?.cancel();
            }
          });
        });
      } else {
        showCustomToast(context, 'Failed to resend OTP');
      }
    } catch (e) {
      showCustomToast(context, 'An error occurred while resending OTP: $e');
    }
  }

  @override
  void dispose() {
    // Clean up the controllers and focus nodes and timer to prevent memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verify Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Please enter the code we just sent to $_phoneNumber',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 53, 64, 68),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFEAEAEA), // Background color #EAEAEA
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText:
                            '', // Hides the length counter at the bottom
                        border: InputBorder.none, // Removes the default border
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
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _isResendButtonDisabled ? null : _resendOtp,
              child: Text(
                _isResendButtonDisabled
                    ? "Resend available in $_countdown seconds."
                    : "Didn't receive OTP? Resend code",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: _isButtonDisabled ? null : _verifyOtp,
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
                child: _isButtonDisabled
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        ))
                    : const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
