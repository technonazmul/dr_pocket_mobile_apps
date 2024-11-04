import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteDoctorsPage extends StatefulWidget {
  const FavoriteDoctorsPage({super.key});

  @override
  _FavoriteDoctorsPageState createState() => _FavoriteDoctorsPageState();
}

class _FavoriteDoctorsPageState extends State<FavoriteDoctorsPage> {
  List doctors = [];
  String query = '';
  bool isLoading = true; // State variable for loading indicator

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5000/api/backend/doctors'));
      if (response.statusCode == 200) {
        setState(() {
          doctors = json.decode(response.body);
          isLoading = false; // Set loading to false once data is fetched
        });
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading to false on error
      });
      print(e);
    }
  }

  Widget buildDoctorList() {
    if (doctors.isEmpty) {
      return const Center(child: Text('No doctors found'));
    }

    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 0,
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 9.0, right: 9.0, bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: doctor['image'] != null
                          ? Image.network(
                              'http://localhost:5000/uploads/${doctor['image']}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/default_profile.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor['name'] ?? 'Unknown Doctor',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            doctor['designationAndDepartment'] ??
                                'No designation available',
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF979797)),
                          ),
                          const SizedBox(height: 4),
                          buildStarRating(doctor['rating'] ?? 5),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Color(0xFFFF0000),
                      ),
                      onPressed: () {
                        // Add functionality for wish button
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                    bottom: 0.0,
                  ),
                  child: Column(
                    children: [
                      Divider(
                        height:
                            0, // The height of the space above and below the divider
                        thickness: 1, // Thickness of the divider line
                        color: Color.fromARGB(
                            255, 235, 239, 242), // Color of the divider
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distributes space between children
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Aligns "test text" to the start
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.black,
                          ),
                          label: const Text("Appointment",
                              style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            backgroundColor: const Color(0xFFEBEFF2),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                    // Using Align to ensure this text is aligned to the right
                    Align(
                      alignment: Alignment
                          .centerRight, // Aligns the column to the right
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .end, // Aligns text to the end of the column
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFEBEFF2), // Background color of the button
                              borderRadius: BorderRadius.circular(
                                  4), // Border radius of 4
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min, // Wrap content
                              children: [
                                SizedBox(
                                    width:
                                        8), // Space between the icon and the text
                                Text(
                                  "Fee: ৳ 1500", // Your text
                                  style: TextStyle(
                                    color: Colors.black, // Text color
                                    fontSize: 12, // Text size
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildStarRating(double rating) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

    List<Widget> stars = [];
    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
    }
    if (halfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 20));
    }
    for (int i = 0; i < emptyStars; i++) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 20));
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Doctor'),
        centerTitle: true,
      ),
      body: isLoading // Show loading indicator while fetching data
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 30),
                Expanded(child: buildDoctorList()),
              ],
            ),
    );
  }
}
