import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpecialityPage extends StatefulWidget {
  const SpecialityPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpecialityPageState createState() => _SpecialityPageState();
}

class _SpecialityPageState extends State<SpecialityPage> {
  List<dynamic> specialties = [];

  @override
  void initState() {
    super.initState();
    fetchSpecialties();
  }

  Future<void> fetchSpecialties() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:5000/api/backend/specilities'));

    if (response.statusCode == 200) {
      setState(() {
        specialties = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load specialties');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Speciality'),
      ),
      body: specialties.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: specialties.length,
                      itemBuilder: (context, index) {
                        return _buildSpecialityCard(
                          specialties[index]['name'],
                          specialties[index]['image'],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSpecialityCard(String name, String imagePath) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'http://127.0.0.1:5000/uploads/$imagePath',
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 80);
            },
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
