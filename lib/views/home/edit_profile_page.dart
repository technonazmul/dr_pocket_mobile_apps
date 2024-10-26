import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/inc/custom_toast.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedGender = 'Male';
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  bool _isLoading = true;
  String? token = null;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      // Retrive the token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');

      if (token == null) {
        print('token not found');
        return;
      }
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/app/user'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final user = data['user'];

        // set the value of name and gender
        setState(() {
          _nameController.text = user['name'] ?? '';
          _selectedGender = user['gender'] ?? 'Male';
          _isLoading = false;
        });
      } else {
        print('Failed to load profile');
      }
    } catch (error) {
      print('Error fetching profile: $error');
    }
  }

  void _completeProfile() async {
    // Logic to handle profile completion
    String name = _nameController.text;
    String gender = _selectedGender;

    try {
      final response = await http.post(
          Uri.parse('http://localhost:5000/api/app/userprofileupdate'),
          headers: {
            'Authorization': 'Bearer $token'
          },
          body: {
            'name': _nameController.text,
            'gender': _selectedGender,
          });

      if (response.statusCode == 200) {
        showCustomToast(context, 'Updated.');
      }
    } catch (error) {
      print('Error fetching profile: $error');
    }

    if (name.isNotEmpty) {
      // Proceed with profile completion logic
      print('Profile completed: Name: $name, Gender: $gender');
    } else {
      // Show error if the name field is empty
      print('Please complete your profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Image with upload feature
                  const SizedBox(height: 20),

                  // Name Field
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Gender Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: const Icon(Icons.male),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    items: _genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 30),

                  // Complete Profile Button
                  SizedBox(
                    width: double.infinity, // Full-width button
                    child: ElevatedButton(
                      onPressed: _completeProfile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
