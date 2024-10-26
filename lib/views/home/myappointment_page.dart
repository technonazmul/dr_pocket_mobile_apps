import 'package:flutter/material.dart';

class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({super.key});

  @override
  _MyAppointmentPageState createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage> {
  bool _isButtonDisabled = false;

  Future<void> _startMeeting() async {
    print('clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Appointment',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: const Color(0xFF1FAFF),
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(4),
              ),
              margin: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(218, 218, 218, 1),
                              width: 1)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.network(
                            'http://localhost:5000/uploads/1727847618761.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Janitor Jolly',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Surgon apollo hospital',
                                style: TextStyle(color: Color(0xFF979797)),
                              ),
                              Row(children: [
                                Text('Video Call'),
                                SizedBox(width: 10),
                                Text('Scheduled',
                                    style: TextStyle(color: Color(0xFF0094FF))),
                              ]),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Color(0xFF0094FF),
                                    size: 14,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Today 10:00am - 11:00am',
                                    style: TextStyle(color: Color(0xFF354044)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Patient Information',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(
                                1), // First column takes 1x space
                            1: FlexColumnWidth(
                                2), // Second column takes 2x space
                          },
                          children: [
                            TableRow(
                              children: [
                                Text('Name'),
                                Text(
                                  ': Masud Rana',
                                  style: TextStyle(color: Color(0xFF354044)),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text('Gender'),
                                Text(
                                  ': Male',
                                  style: TextStyle(color: Color(0xFF354044)),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text('Age'),
                                Text(
                                  ': 30+',
                                  style: TextStyle(color: Color(0xFF354044)),
                                ),
                              ],
                            ),
                            // Add more rows for additional patient data
                            TableRow(
                              children: [
                                Text('Weight'),
                                Text(
                                  ': 80kg',
                                  style: TextStyle(color: Color(0xFF354044)),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text('Problem'),
                                Text(
                                  ': Heart Attack a heart attack or myocardial infarction, usually tops the list of...',
                                  style: TextStyle(color: Color(0xFF354044)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.92,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0094FF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: _isButtonDisabled ? null : _startMeeting,
                child: _isButtonDisabled
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        ))
                    : const Text('Video call start 2:30pm'),
              ),
            ),
          ],
        ));
  }
}
