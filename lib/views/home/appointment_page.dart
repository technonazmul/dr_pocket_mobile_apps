import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Doctor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Handle adding to favorites
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's Profile Section
            const Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'http://127.0.0.1:5000/uploads/1727347647552.png'),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Dr. John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Surgeon · Apollo Mehta Hospital',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                // Star Rating section
                Center(
                  // Center only the star rating
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Space before the review section
              ],
            ),
            // Counter Section
            Container(
              width: double.infinity, // Ensure the container takes full width
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
                          Icons.accessible, // Replace with desired icon
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4K',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Patients',
                            style: TextStyle(fontSize: 12, color: Colors.white),
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
                          Icons.verified_user, // Replace with desired icon
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '6 Years',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Experiences',
                            style: TextStyle(fontSize: 12, color: Colors.white),
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              color: Colors.white,
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align the text to the left
                children: [
                  Text(
                    'Biography',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10), // Add spacing between title and text
                  Text(
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from over 2000 years ago.',
                    style: TextStyle(fontSize: 14),
                    softWrap: true, // Ensure text wraps to the next line
                    overflow: TextOverflow.clip, // Clip overflowing text
                  ),
                ],
              ),
            ),
            // Appointment Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Appointment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), // Space between title and buttons
                  SingleChildScrollView(
                    scrollDirection: Axis
                        .horizontal, // Set the scroll direction to horizontal
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Align the buttons to the start
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40,
                                120), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Mon'), // First three letters of the day
                              Text('12'), // Date
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle second button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40,
                                120), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Tue'), // First three letters of the day
                              Text('13'), // Date
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle third button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40,
                                120), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Wed'), // First three letters of the day
                              Text('14'), // Date
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle third button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40,
                                120), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Wed'), // First three letters of the day
                              Text('14'), // Date
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle third button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40,
                                120), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Wed'), // First three letters of the day
                              Text('14'), // Date
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle third button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40,
                                120), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text('Wed'), // First three letters of the day
                              Text('14'), // Date
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Schedule',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), // Space between title and buttons
                  SingleChildScrollView(
                    scrollDirection: Axis
                        .horizontal, // Set the scroll direction to horizontal
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Align the buttons to the start
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80,
                                40), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text(
                                  '10:00AM - 10:20AM'), // First three letters of the day
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80,
                                40), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text(
                                  '10:00AM - 10:20AM'), // First three letters of the day
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80,
                                40), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text(
                                  '10:00AM - 10:20AM'), // First three letters of the day
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80,
                                40), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text(
                                  '10:00AM - 10:20AM'), // First three letters of the day
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80,
                                40), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text(
                                  '10:00AM - 10:20AM'), // First three letters of the day
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle first button press
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80,
                                40), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Color.fromRGBO(234, 234, 234, 1.0),
                                width: 1,
                              ), // Set the border radius
                            ),
                            backgroundColor:
                                Colors.white, // Set the background color
                            foregroundColor:
                                Colors.black, // Set the text color to black
                            elevation: 0, // Remove the shadow
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize
                                .min, // This will wrap the button size around its child
                            children: [
                              Text(
                                  '10:00AM - 10:20AM'), // First three letters of the day
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                  foregroundColor: Colors.black, // Set the text color to black
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
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AppointmentPage(),
  ));
}
