import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List doctors = [];
  String query = '';
  bool isLoading = true;
  List<dynamic> specialities = [];
  List<dynamic> banners = [];

  @override
  void initState() {
    super.initState();
    fetchDoctors();
    fetchSpecialities();
    fetchBanners();
  }

  Future<void> fetchDoctors() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5000/api/backend/doctors'));
      if (response.statusCode == 200) {
        setState(() {
          doctors = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  Future<void> fetchSpecialities() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:5000/api/backend/specilities'));

      if (response.statusCode == 200) {
        setState(() {
          specialities = json.decode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchBanners() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:5000/api/backend/banners'));

      if (response.statusCode == 200) {
        setState(() {
          banners = json.decode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget buildSearchField() {
    return Container(
      color: const Color(0xFF0094FF),
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 5.0, bottom: 18.0),
        child: TextField(
          onChanged: (text) {
            setState(() {
              query = text;
            });
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Color(0xFF0094FF)),
            hintText: 'Search for Doctors',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(202, 236, 255, 1.0),
                  width: 1.0,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Color.fromRGBO(202, 236, 255, 1.0),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Color.fromRGBO(202, 236, 255, 1.0),
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDoctorList() {
    List filteredDoctors = doctors.where((doctor) {
      return doctor['name'] != null &&
              doctor['name'].toLowerCase().contains(query.toLowerCase()) ||
          doctor['designationAndDepartment']
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          doctor['specialty'].toLowerCase().contains(query.toLowerCase()) ||
          doctor['qualifications']
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          doctor['biography'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filteredDoctors.isEmpty) {
      return const Center(child: Text('No doctors found'));
    }

    return Column(
      children: List.generate(filteredDoctors.length, (index) {
        final doctor = filteredDoctors[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 10, // Blur radius for soft shadow
                offset: const Offset(0, 4), // X, Y offset for shadow
              ),
            ],
          ),
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
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          buildStarRating(doctor['rating'] ?? 5),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
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
                        height: 0, // Space above and below the divider
                        thickness: 1, // Thickness of the line
                        color: Color.fromARGB(255, 235, 239, 242), // Color
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBEFF2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  "Fee: ৳ 1500",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
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
      }),
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

  Widget _buildSpecialityCard(String name, String imagePath) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth =
        (screenWidth - 48) / 4; // Subtracting padding and spacing

    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0), // Adjust as needed
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        width: cardWidth, // Set card width based on screen size
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'http://127.0.0.1:5000/uploads/$imagePath',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 80);
              },
            ),
            const SizedBox(height: 8),
            Center(
              // Center the text
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center, // Center text for better alignment
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpecilities() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Doctor Specialty',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: Colors.blue, // Customize color
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0, // Space between items
            runSpacing: 8.0, // Space between lines
            children: List.generate(specialities.length, (index) {
              return _buildSpecialityCard(
                specialities[index]['name'],
                specialities[index]['image'],
              );
            }),
          ),
        ],
      ),
    );
  }

  // Widget to display the banner slider
  Widget buildBannerSlider() {
    if (banners.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 170, // Set the height of the slider
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          // Safely access banner data
          final banner = banners[index];
          final imageUrl = banner['image'] != null
              ? 'http://127.0.0.1:5000/uploads/${banner['image']}'
              : ''; // Handle null image gracefully

          return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage('assets/default_image.png')
                            as ImageProvider, // Use a default image if URL is empty
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Row(
          children: [
            // Profile Picture
            const Padding(
              padding: EdgeInsets.all(10.0), // Adds padding around the avatar
              child: CircleAvatar(
                radius: 25, // Set radius to 40 for the larger profile picture
                backgroundImage: NetworkImage(
                    'http://localhost:5000/uploads/1727351586662.png'), // Your image URL
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome", style: TextStyle(fontSize: 14)),
                Text("Your Name", style: TextStyle(fontSize: 18)),
              ],
            ),
            // Spacer to push notification icon to the right
            const Spacer(),
            // Notification Icon
            Container(
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications),
                color: const Color(0xFF0094FF), // Set the icon color to #0094FF
                onPressed: () {
                  // Add your onPressed functionality here
                },
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  buildSearchField(),
                  query.isEmpty
                      ? Column(
                          children: [
                            buildSpecilities(),
                            const SizedBox(height: 20),
                            buildBannerSlider(),
                            Container(
                              color: Colors.white,
                              margin: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                        bottom: 7.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          const Text('Popular Doctor',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              // Add your navigation or functionality here
                                            },
                                            child: const Text(
                                              "See All",
                                              style: TextStyle(
                                                color: Colors
                                                    .blue, // Customize color
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  buildDoctorList(),
                                ],
                              ),
                            ),
                          ],
                        )
                      : buildDoctorList(),
                ],
              ),
            ),
    );
  }
}
