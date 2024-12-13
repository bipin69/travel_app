import 'package:flutter/material.dart';
import 'package:travel_app_project/views/onboarding_screen.dart';
import 'package:travel_app_project/views/splash_screen.dart';
import 'package:travel_app_project/views/login_screen.dart';
import 'package:travel_app_project/views/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // Splash Screen
        '/onboarding': (context) => const OnboardingScreen(), // Onboarding Screen
        '/login': (context) => LoginScreen(), // Login Screen
        '/signup': (context) => SignUpScreen(), // Sign-Up Screen
        '/home': (context) => HomeScreen(), // Placeholder for Home/Dashboard Screen
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Travel App!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
