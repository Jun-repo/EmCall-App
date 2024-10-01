import 'package:emcall/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for the onboarding slides
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _isLastPage = (index == 2);
              });
            },
            children: [
              buildPageContent(
                context,
                "assets/your_image.png",
                "Welcome to EmCall!",
                "Stay connected with Responderss in your town.",
              ),
              buildPageContent(
                context,
                "assets/your_image.png",
                "Easy Messaging!",
                "Send Alert messages effortlessly.",
              ),
              buildPageContent(
                context,
                "assets/your_image.png",
                "Real-time Location!",
                "Share your location with Agencies.",
              ),
            ],
          ),
          // Skip button positioned at the top-right
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                _controller.jumpToPage(2); // Jump to last page when skipping
              },
              child: const Text("Skip",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ),
          // Page indicator and Next/Start button at the bottom
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Dot Indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                // Circular Next/Start button
                CircleAvatar(
                  radius: 40, // Circular button
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: Icon(
                      size: 40,
                      _isLastPage ? Icons.check : Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_isLastPage) {
                        // Navigate to Sign In Screen on last page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      } else {
                        // Go to next page
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageContent(
      BuildContext context, String image, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(image, height: 300),
        const SizedBox(height: 20), // Space between image and text
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8), // Space between title and subtitle
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white60,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        const SizedBox(height: 90),
      ],
    );
  }
}
