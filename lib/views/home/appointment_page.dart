import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool isLoading = true;
  late String _doctorId;
  bool _hasFetchedDoctor = false;
  Map<String, dynamic>? doctorData;
  List<String> availableDays = [];
  List<String> timeSlots = [];
  String? selectedDay;
  String? selectedDate;
  String? selectedTimeSlot;

  final daysOfWeek = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetchedDoctor) {
      fetchDoctor();
      _hasFetchedDoctor = true; // Set flag to true after fetching data
    }
  }

  Future<void> fetchDoctor() async {
    _doctorId = ModalRoute.of(context)?.settings.arguments as String;

    final response = await http
        .get(Uri.parse('http://localhost:5000/api/app/doctor/$_doctorId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        doctorData = data;
        availableDays = _getNextFourAvailableDays(data['timeSlots']);
        isLoading = false;
      });
    }
  }

  void showTimeSlots(String day) {
    setState(() {
      selectedDate = selectedDate =
          DateFormat('yyyy-MM-dd').format(getNextDateByDayName(day));
      selectedDay = day;
      timeSlots = List<String>.from(doctorData!['timeSlots']
          [day]); // Fetch slots based on the selected day
      selectedTimeSlot = null;
    });
  }

  void selectTimeSlot(String slot) {
    setState(() {
      selectedTimeSlot = slot;
    });
    print(slot);
    print(selectedDate);
  }

  DateTime getNextDateByDayName(String dayName) {
    // Map of day names to their corresponding weekday index in Dart (Monday is 1, Sunday is 7)
    final daysOfWeek = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };

    // Get the current date and the target weekday index
    final now = DateTime.now();
    final targetDay = daysOfWeek[dayName];

    if (targetDay == null) {
      throw ArgumentError("Invalid day name");
    }

    // Calculate the difference to the next target day
    int daysUntilNext = (targetDay - now.weekday + 7) % 7;

    // If it's today, return today's date
    if (daysUntilNext == 0) {
      return now;
    }

    // Otherwise, return the date of the next occurrence of the target day
    return now.add(Duration(days: daysUntilNext));
  }

  List<String> _getNextFourAvailableDays(Map<String, dynamic> timeSlots) {
    final today = DateTime.now();
    List<String> nextFourDays = [];
    for (int i = 0; i < 7 && nextFourDays.length < 4; i++) {
      final day = today.add(Duration(days: i));
      final dayName = DateFormat('EEEE').format(day);
      if (timeSlots.containsKey(dayName) && timeSlots[dayName].isNotEmpty) {
        nextFourDays.add(dayName);
      }
    }
    return nextFourDays;
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final currentDateTime =
        DateTime.now().add(Duration(hours: 6)); // Adjust for GMT +6
    final currentWeekday =
        DateFormat('EEEE').format(currentDateTime); // Get current day as string

    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Appointment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Handle adding to favorites
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : doctorData != null
              ? SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor's Profile Section
                      Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: doctorData!['image'] != null
                                  ? NetworkImage(
                                      'http://127.0.0.1:5000/uploads/${doctorData!['image']}')
                                  : const AssetImage(
                                          'assets/no_profile_picture.png')
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              doctorData!['name'] ?? 'Unknown Doctor',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              doctorData!['designationAndDepartment'] ??
                                  'no data',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Star Rating section
                          const Center(
                            // Center only the star rating
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                              ],
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Space before the review section
                        ],
                      ),
                      // Counter Section
                      Container(
                        width: double
                            .infinity, // Ensure the container takes full width
                        color: const Color.fromRGBO(40, 162, 101, 1.0),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Left Column
                            Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons
                                        .accessible, // Replace with desired icon
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctorData!['patient'] ?? '4K',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const Text(
                                      'Patients',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Right Column
                            Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons
                                        .verified_user, // Replace with desired icon
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctorData!['experience'] ?? '6 Years',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Experiences',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Biography Section
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align the text to the left
                          children: [
                            const Text(
                              'Biography',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                                height:
                                    10), // Add spacing between title and text
                            Text(
                              doctorData!['biography'] ?? 'no data',
                              style: const TextStyle(fontSize: 14),
                              softWrap:
                                  true, // Ensure text wraps to the next line
                              overflow:
                                  TextOverflow.clip, // Clip overflowing text
                            ),
                          ],
                        ),
                      ),
                      // Appointment Section
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Appointment',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                                height: 10), // Space between title and buttons
                            SingleChildScrollView(
                              scrollDirection: Axis
                                  .horizontal, // Set the scroll direction to horizontal
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Align the buttons to the start
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: availableDays.map((day) {
                                        bool isSelected = selectedDay == day;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showTimeSlots(day);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(70, 120),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                side: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      234, 234, 234, 1.0),
                                                  width: 1,
                                                ),
                                              ),
                                              backgroundColor: isSelected
                                                  ? Colors.blue
                                                  : Colors.white,
                                              foregroundColor: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              elevation: 0,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(day.substring(0,
                                                    3)), // Show the first three letters
                                                Text(DateFormat('d').format(
                                                    DateTime.now().add(Duration(
                                                        days: daysOfWeek
                                                                .indexOf(day) -
                                                            daysOfWeek.indexOf(
                                                                DateFormat(
                                                                        'EEEE')
                                                                    .format(DateTime
                                                                        .now())))))),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          color: Colors.white,
                          width: double.infinity,
                          child: timeSlots.isNotEmpty && timeSlots[0] != ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Schedule',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            10), // Space between title and buttons
                                    SingleChildScrollView(
                                      scrollDirection: Axis
                                          .horizontal, // Set the scroll direction to horizontal
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, // Align the buttons to the start
                                        children: [
                                          const SizedBox(width: 10),
                                          timeSlots.isNotEmpty
                                              ? Wrap(
                                                  spacing:
                                                      10, // Adjust the spacing between buttons as needed
                                                  children:
                                                      timeSlots.map((slot) {
                                                    bool isTimeSlotSelected =
                                                        selectedTimeSlot ==
                                                            slot;
                                                    return ElevatedButton(
                                                      onPressed: () {
                                                        selectTimeSlot(slot);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: const Size(
                                                            80,
                                                            40), // Set the width and height of the button
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          side:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    234,
                                                                    234,
                                                                    234,
                                                                    1.0),
                                                            width: 1,
                                                          ), // Set the border radius
                                                        ),
                                                        backgroundColor:
                                                            isTimeSlotSelected
                                                                ? Colors.blue
                                                                : Colors.white,
                                                        foregroundColor:
                                                            isTimeSlotSelected
                                                                ? Colors.white
                                                                : Colors
                                                                    .black, // Set the text color to black
                                                        elevation:
                                                            0, // Remove the shadow
                                                      ),
                                                      child: Text(
                                                        slot, // Display each time slot dynamically
                                                        style: const TextStyle(
                                                            fontSize:
                                                                14), // Adjust font size if needed
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              : const Center(
                                                  child: Text(
                                                    'No time slots available.',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(deviceWidth * 0.9,
                                60), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor: const Color.fromRGBO(
                                0, 148, 255, 1.0), // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Make An Appointment',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors
                                          .white)), // First three letters of the day
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: Text("Doctor data not available")),
    );
  }
}
