import 'package:flutter/material.dart';

class AppointmentHistoryPage extends StatefulWidget {
  const AppointmentHistoryPage({super.key});

  @override
  _AppointmentHistoryPageState createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AppointmentListView(status: "upcoming"),
            AppointmentListView(status: "completed"),
            AppointmentListView(status: "cancelled"),
          ],
        ),
      ),
    );
  }
}

class AppointmentListView extends StatelessWidget {
  final String status;

  const AppointmentListView({required this.status});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final appointments = [
      {
        "id": 1,
        "doctor": "Dr. Smith",
        "image": "1727847618761.png",
        "designation": "surgeon . Apollo Mehta hospital",
        "date": "Oct 30, 2024",
        "time": "10:00AM - 10:15AM",
        "status": "upcoming"
      },
      {
        "id": 2,
        "doctor": "Dr. John",
        "image": "1727847618761.png",
        "designation": "surgeon . Apollo Mehta hospital",
        "date": "Oct 30, 2024",
        "time": "10:00AM - 10:15AM",
        "status": "completed"
      },
      {
        "id": 3,
        "doctor": "Dr. Emily",
        "image": "1727847618761.png",
        "designation": "surgeon . Apollo Mehta hospital",
        "date": "Oct 30, 2024",
        "time": "10:00AM - 10:15AM",
        "status": "cancelled"
      },
    ];

    final filteredAppointments = appointments
        .where((appointment) => appointment['status'] == status)
        .toList();

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                      child: appointment['image'] != null
                          ? Image.network(
                              'http://localhost:5000/uploads/1727847618761.png',
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
                            'Doctor Name',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Designation',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
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
}
