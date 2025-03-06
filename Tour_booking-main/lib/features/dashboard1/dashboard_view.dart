import 'package:flutter/material.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/bookmark_view.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/contact_view.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/homescreen_view.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/profile_view.dart';
import 'package:hotel_booking/sensor/near_detector.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    BookmarkView(),
    ContactView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Cycle to the next bottom navigation item.
  void _cycleBottomNav() {
    setState(() {
      _selectedIndex = (_selectedIndex + 1) % _screens.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the whole scaffold with NearDetector.
      child: NearDetector(
        onNearDetected: _cycleBottomNav,
        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel),
                label: 'Tours',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
                label: 'Contact',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
