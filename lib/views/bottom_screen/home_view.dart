import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter something',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // Adds spacing

              // Button
              ElevatedButton(
                onPressed: () {
                  // Handle button press logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Button Pressed')),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
