import 'package:emcall/home_page.dart';
import 'package:emcall/sign_up_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true; // For showing/hiding PIN
  String? _phoneNumber;
  String? _pinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to dark
      body: SingleChildScrollView(
        // Make the body scrollable
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: [
            const SizedBox(height: 120),
            // Title
            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
              ),
            ),
            const SizedBox(height: 10),
            // Subtitle
            const Text(
              'Hi there! Nice to see you again.',
              style: TextStyle(
                  fontSize: 16, color: Colors.white70), // White with opacity
            ),
            const SizedBox(height: 30),
            // Phone Number Input using IntlPhoneField
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900], // Dark background for input
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              initialCountryCode: 'PH', // Default country code
              onChanged: (phone) {
                setState(() {
                  _phoneNumber = phone.completeNumber; // Save complete number
                });
              },
              style: const TextStyle(color: Colors.white), // White input text
            ),
            const SizedBox(height: 20),
            // PIN Code Input (4 digits)
            TextFormField(
              obscureText: _obscureText, // Toggle obscure text
              keyboardType: TextInputType.number,
              maxLength: 4, // Set maximum length to 4 digits
              style: const TextStyle(color: Colors.white), // White input text
              decoration: InputDecoration(
                labelText: 'PIN Code (4 digits)',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900], // Dark background for input
                counterText: '', // Hide character counter
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70, // White icon color
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle obscure text
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (pin) {
                _pinCode = pin; // Save pin code
              },
            ),
            const SizedBox(height: 20),
            // Forgot PIN Button
            Align(
              alignment: Alignment.centerRight, // Align to the right
              child: TextButton(
                onPressed: () {
                  _showForgotPinDialog(context); // Call the dialog when clicked
                },
                child: const Text(
                  'Forgot PIN?',
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                if (kDebugMode) {
                  print('Phone Number: $_phoneNumber');
                }
                if (kDebugMode) {
                  print('PIN Code: $_pinCode');
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.red, // Red background color for button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.white), // White text color
              ),
            ),
            const SizedBox(height: 20),
            // Don't have an account? Sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                      color: Colors.white70), // White text with opacity
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to sign up screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.red), // Red text color
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Method to show the Forgot PIN dialog box
  void _showForgotPinDialog(BuildContext context) {
    String? forgotPhoneNumber;
    List<String> verificationCodeDigits =
        List.filled(6, ''); // List to hold each digit of the code
    bool codeSent = false; // Tracks if the code has been sent
    bool isPhoneNumberComplete = false; // Tracks if phone number input is valid
    bool isVerificationCodeComplete =
        false; // Tracks if verification code input is valid

    // Text editing controller to retain the phone number input
    TextEditingController phoneNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(codeSent ? 'Enter Verification Code' : 'Forgot PIN'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!codeSent)
                    // Show phone number field before sending the code
                    IntlPhoneField(
                      controller: phoneNumberController, // Use the controller
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      initialCountryCode: 'PH',
                      onChanged: (phone) {
                        forgotPhoneNumber = phone.completeNumber;
                        setState(() {
                          isPhoneNumberComplete = phone.completeNumber.length >=
                              13; // Adjust the length as needed
                        });
                      },
                    )
                  else
                    // Show separate digit input fields for verification code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 40, // Set width for each digit box
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1, // Limit to 1 character per field
                            decoration: InputDecoration(
                              counterText: '', // Hide the character counter
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                            initialValue: verificationCodeDigits[index],
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  verificationCodeDigits[index] =
                                      value; // Store the digit
                                } else {
                                  verificationCodeDigits[index] =
                                      ''; // Clear the digit if input is empty
                                }
                                // Check if all digits are entered (verification code is complete)
                                isVerificationCodeComplete =
                                    verificationCodeDigits
                                        .every((digit) => digit.isNotEmpty);
                              });
                              // Move focus to the next field automatically
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                ],
              ),
              actions: [
                if (!codeSent)
                  // Show Send Code button if code has not been sent yet, and disable if phone number is not complete
                  TextButton(
                    onPressed: isPhoneNumberComplete
                        ? () {
                            setState(() {
                              codeSent =
                                  true; // Code sent, switch to code input
                            });
                            // Logic to send the code to the phone number
                            forgotPhoneNumber = phoneNumberController.text;
                            if (kDebugMode) {
                              print('Code sent to $forgotPhoneNumber');
                            }
                          }
                        : null, // Disable button if the phone number is incomplete
                    child: const Text('Send Code'),
                  )
                else
                  // Show OK button after code is sent and enable it only if the verification code input is complete
                  TextButton(
                    onPressed: isVerificationCodeComplete
                        ? () {
                            // Combine all digits
                            String verificationCode =
                                verificationCodeDigits.join('');
                            // Logic to verify the entered code
                            Navigator.of(context)
                                .pop(); // Close the current dialog
                            if (kDebugMode) {
                              print('Verification Code: $verificationCode');
                            }
                            // Show the dialog for entering the new PIN
                            _showNewPinDialog(context);
                          }
                        : null, // Disable button if the verification code is incomplete
                    child: const Text('OK'),
                  ),
                // Show Cancel button when phone number input is active, or Back when code input is active
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (codeSent) {
                        codeSent = false; // Go back to phone number input
                      } else {
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    });
                  },
                  child: Text(codeSent ? 'Back' : 'Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

// Function to show the new PIN entry dialog
  void _showNewPinDialog(BuildContext context) {
    TextEditingController newPinController = TextEditingController();
    bool isPinVisible = false; // Track visibility of the PIN

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Add a listener to the TextEditingController
            newPinController.addListener(() {
              setState(() {
                // Enable or disable the button based on the input length
              });
            });

            return AlertDialog(
              title: const Text('Set New PIN'),
              content: TextFormField(
                controller: newPinController,
                keyboardType: TextInputType.number,
                maxLength: 4, // Limit the PIN to 4 digits
                obscureText:
                    !isPinVisible, // Hide the PIN input based on the toggle
                decoration: InputDecoration(
                  labelText: 'New PIN',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPinVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPinVisible = !isPinVisible; // Toggle visibility
                      });
                    },
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: newPinController.text.length == 4
                      ? () {
                          String newPin = newPinController.text;
                          Navigator.of(context)
                              .pop(); // Close the new PIN dialog
                          if (kDebugMode) {
                            print('New PIN: $newPin');
                          }
                        }
                      : null, // Disable button if the input is not valid
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
