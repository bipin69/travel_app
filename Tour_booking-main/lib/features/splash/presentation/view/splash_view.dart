import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(context); // Use SplashCubit for navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
          41, 182, 246, 1), // Background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Main_logo.png', // Path to your image
              width: 360, // Adjust size as needed
              height: 360, // Adjust height as needed
            ),
            const Text(
              'GHUMANTEY',
              style: TextStyle(
                color: Color.fromARGB(255, 210, 212, 215),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Show loading indicator during the splash
          ],
        ),
      ),
    );
  }
}
