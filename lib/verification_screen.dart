import 'dart:io'; // For File
import 'package:emcall/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _selectedIdType;
  File? _frontIdImage; // File to store the front of the ID
  File? _backIdImage; // File to store the back of the ID
  final List<File?> _faceImages =
      List.filled(3, null); // List to store face images

  final ImagePicker _picker = ImagePicker();

  // Method to open the camera and capture images for front and back IDs
  Future<void> _pickFrontAndBackImages() async {
    // First, capture the front of the ID
    final XFile? frontImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (frontImage != null) {
      setState(() {
        _frontIdImage = File(frontImage.path); // Store the captured front image
      });

      // After capturing the front, capture the back of the ID
      final XFile? backImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (backImage != null) {
        setState(() {
          _backIdImage = File(backImage.path); // Store the captured back image
        });
      }
    }
  }

  // Method to capture face images
  Future<void> _pickFaceImage(int index) async {
    final XFile? faceImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (faceImage != null) {
      setState(() {
        _faceImages[index] =
            File(faceImage.path); // Store the captured face image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to dark color
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            const SizedBox(height: 10),
            // Title
            const Text(
              'Verification',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
            const Text(
              '  Your Almost Done!',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: Colors.white, // Set text color to white
              ),
            ),
            const SizedBox(height: 40),
            // ID Type Label
            const Text(
              'ID Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White color for label
              ),
            ),
            const SizedBox(height: 10),
            // Add a label for front and back picture
            const Text(
              'Choose your available ID and take a pic, both Front and Back!', // Label text
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: Colors.white, // Set text color to white
              ),
            ),
            const SizedBox(height: 10),
            // ID Type Dropdown
            DropdownButtonFormField<String>(
              value: _selectedIdType,
              onChanged: (String? newValue) async {
                setState(() {
                  _selectedIdType = newValue;
                });
                // Open camera to capture both front and back images
                await _pickFrontAndBackImages();
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black, // Dark background for dropdown
                labelStyle: TextStyle(color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Grey line when not focused
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white, width: 2), // White line when focused
                ),
              ),
              dropdownColor: Colors.grey[900], // Dropdown background color
              items: <String>['Driver\'s License', 'Passport', 'National ID']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white), // White text
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Display captured front and back images if available
            if (_frontIdImage != null && _backIdImage != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Display Front ID Image
                  Column(
                    children: [
                      const Text(
                        'Front ID',
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.file(
                        _frontIdImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  // Display Back ID Image
                  Column(
                    children: [
                      const Text(
                        'Back ID',
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.file(
                        _backIdImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),

            const SizedBox(height: 60),
            // Add label for face view requirements
            const Text(
              'Add 3 Face View Requirements',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White color for label
              ),
            ),
            const SizedBox(height: 10),
            // Display placeholder boxes for face images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                String placeholderText;
                if (index == 0) {
                  placeholderText = 'Tap to\nAdd Left \nSide Face';
                } else if (index == 1) {
                  placeholderText = 'Tap to\nAdd Front \nFace';
                } else {
                  placeholderText = 'Tap to\nAdd Right \nSide Face';
                }

                return GestureDetector(
                  onTap: () =>
                      _pickFaceImage(index), // Capture face image on tap
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _faceImages[index] != null
                        ? Image.file(
                            _faceImages[index]!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              placeholderText, // Use the updated placeholder text
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white, // White text
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 60),
            // Sign Up Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Show snackbar when the button is clicked
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Congratulations! You are now an EmCall user.',
                        textAlign: TextAlign.center,
                      ),
                      duration:
                          Duration(seconds: 3), // Duration for the snackbar
                    ),
                  );

                  // Delay for 3 seconds and then navigate to HomePage
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.red, // Red background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Sign-Up Now!',
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
