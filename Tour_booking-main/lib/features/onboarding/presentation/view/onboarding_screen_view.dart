import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/onBoarding/presentation/view_model/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/introduction1.png",
      "subtitle":
          "At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world",
    },
    {
      "image": "assets/images/introduction2.png",
      "subtitle":
          "To get the best of your adventure you just need to leave and go where you like. We are waiting for you",
    },
    {
      "image": "assets/images/introduction3.png",
      "subtitle":
          "To get the best of your adventure you just need to leave and go where you like. We are waiting for you",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue, // Blue background for the entire screen
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Transparent scaffold background
        body: SafeArea(
          child: Column(
            children: [
              // Image section (flex: 3)
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            _onboardingData[index]["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Text and control section (flex: 2)
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Subtitle text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _onboardingData[_currentPage]["subtitle"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Page indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _onboardingData.length,
                      effect: const SlideEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.white54,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Continue button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<OnboardingCubit>()
                              .navigateToLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Continue"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
