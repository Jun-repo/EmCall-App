import 'package:flutter/material.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Home Page'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Web Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text('This content is specifically designed for web users.'),
          ],
        ),
      ),
    );
  }
}
