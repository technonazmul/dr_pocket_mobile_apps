import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  String? userName;
  String? profileImage;
  String? phone;

  @override
  void initState() {
    getUser();
  }

  // Method to show the Privacy Policy popup
  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const Text(
              'This is where you can explain your app\'s privacy policy.'),
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

  // Method to show the Contact Us popup
  void _showContactUsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Us'),
          content: const Text('You can contact us at contact@yourapp.com'),
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

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/app/user'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['user'];
        setState(() {
          userName = user['name'];
          profileImage = user['image'];
          phone = user['phone'];
        });
      } else if (response.statusCode == 403) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: profileImage != null
                            ? Image.network(
                                'http://localhost:5000/uploads/$profileImage',
                              )
                            : Image.asset('assets/no_profile_picture.png'),
                      ),
                    ),
                    // Icon for upload image
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0094FF),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt_outlined,
                              color: Colors.white),
                          onPressed: () {
                            print('upload image');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userName ?? "",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(phone ?? ""),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Account Settings',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.perm_identity,
                          color: Colors.black, size: 25),
                      TextButton(
                        child: const Text("Edit Profile",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF354044))),
                        onPressed: () {
                          Navigator.pushNamed(context, '/userprofile');
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF354044), size: 20),
                        onPressed: () {
                          Navigator.pushNamed(context, '/userprofile');
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.lock_outline,
                          color: Colors.black, size: 25),
                      TextButton(
                        child: const Text("Change Password",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF354044))),
                        onPressed: () {
                          Navigator.pushNamed(context, '/changepassword');
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF354044), size: 20),
                        onPressed: () {
                          Navigator.pushNamed(context, '/changepassword');
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.notifications_outlined,
                          color: Colors.black, size: 25),
                      TextButton(
                        child: const Text("Notification",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF354044))),
                        onPressed: () {
                          print('clicked');
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF354044), size: 20),
                        onPressed: () {
                          print('clicked');
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people_outline_outlined,
                          color: Colors.black, size: 25),
                      TextButton(
                        child: const Text("Share This App",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF354044))),
                        onPressed: () {
                          print('clicked');
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF354044), size: 20),
                        onPressed: () {
                          print('clicked');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        'About Us',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.lock_open,
                          color: Colors.black, size: 25),
                      TextButton(
                        child: const Text("Privacy Policy",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF354044))),
                        onPressed: () {
                          _showPrivacyPolicyDialog();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF354044), size: 20),
                        onPressed: () {
                          _showPrivacyPolicyDialog();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.markunread_outlined,
                          color: Colors.black, size: 25),
                      TextButton(
                        child: const Text("Contact Us",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF354044))),
                        onPressed: () {
                          _showContactUsDialog();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF354044), size: 20),
                        onPressed: () {
                          _showContactUsDialog();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
