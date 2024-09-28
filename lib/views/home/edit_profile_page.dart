import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = 'Male';
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  void _completeProfile() {
    // Logic to handle profile completion
    String name = _nameController.text;
    String phone = _phoneController.text;
    String gender = _selectedGender;

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
        title: const Text('Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Image with upload feature
            Stack(
              children: [
                // Circular Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: ClipOval(
                    // Ensure the image is clipped within a circle
                    child: Image.asset(
                      'assets/default_profile.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit
                          .cover, // This ensures the image covers the circle
                    ),
                  ),
                ),
                // Plus Icon for Upload
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Logic to upload profile picture
                        print('Upload profile picture');
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),

            const SizedBox(height: 20),
            // Name Field
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            const SizedBox(height: 20),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Gender',
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
                  'Complete Your Profile',
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
