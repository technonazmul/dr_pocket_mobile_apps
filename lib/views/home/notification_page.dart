import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List notifications = [
    {
      'title': 'Appointment Reminder',
      'message': 'Your appointment with Dr. Smith is tomorrow at 10 AM.',
    },
    {
      'title': 'New Message',
      'message': 'You have a new message from Dr. Emily.',
    },
    {
      'title': 'Health Tip',
      'message': 'Remember to stay hydrated and take breaks!',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        backgroundColor: const Color.fromRGBO(241, 250, 255, 1),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(241, 250, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(218, 218, 218, 1), // Border color
                    width: 1, // Border width (1 pixel)
                  ),
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: ListTile(
                leading: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFD1E6FF), // Background color for the icon
                    shape: BoxShape.circle, // Make the background circular
                  ),
                  padding: const EdgeInsets.all(8), // Padding around the icon
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      notification['title'],
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Text('1m', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                subtitle: Text(notification['message']),
                tileColor: const Color.fromRGBO(241, 250, 255, 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
