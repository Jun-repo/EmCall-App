import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22), // Dark background
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 22, 22, 22), // Match background color
        elevation: 0, // Remove shadow
        automaticallyImplyLeading: false, // Remove the back icon
        title: const Row(
          children: [
            // Profile picture icon
            CircleAvatar(
              backgroundColor: Colors.red,
              maxRadius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 25),
            ),
            SizedBox(width: 10), // Space between icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Susan!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adjusted for visibility
                  ),
                ),
                Text(
                  'Verified',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // Slightly adjusted color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60), // Space before the main button

              // Emergency Help Header
              Text(
                'Emergency help needed?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[800], // Darker red for text
                ),
              ),
              const SizedBox(height: 10), // Space between text and button
              Text(
                'Just hold the button to report!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 82), // Space before the emergency button

              // Emergency Button
              GestureDetector(
                onLongPress: () {
                  // Add your functionality here for long press
                  // Example: call a function to handle the emergency
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.call, // Call icon to represent emergency calling
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 82), // Space after the emergency button

              // Not Sure What To Do? Section
              Text(
                'Not sure what to do?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[800],
                ),
              ),
              const SizedBox(height: 20), // Space between text and options

              // Option Buttons
              SizedBox(
                height: 80, // Set a height for the button container
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildOptionButton('I have an injury'),
                      _buildOptionButton('I\'m feeling bad'),
                      _buildOptionButton('I have a fire emergency'),
                      _buildOptionButton('I need medical help'),
                      _buildOptionButton('I see a crime'),
                      _buildOptionButton('I need urgent help'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space after options
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create option buttons
  Widget _buildOptionButton(String label) {
    return Container(
      height: 140,
      width: 140, // Set a fixed width for all buttons
      margin:
          const EdgeInsets.symmetric(horizontal: 5), // Space between buttons
      child: ElevatedButton(
        onPressed: () {
          // Add functionality for each option
          // Example: navigate to a detailed info page
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 5), // Adjust vertical padding
          backgroundColor: Colors.red[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left-aligned text
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label, // Dynamic label
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2), // Space between text and icons
            // Icons below the text
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_forward, // Right arrow icon
                  color: Colors.white70,
                ),
                Icon(
                  Icons.person, // Profile icon
                  color: Colors.white70,
                ),
              ],
            ),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
