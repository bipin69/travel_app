import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/app/di/di.dart';
import 'package:hotel_booking/features/auth/presentation/view/login_view.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/add_product.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/admin_booking_page.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_contact.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_user.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_hotel.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboardApp extends StatefulWidget {
  const AdminDashboardApp({super.key});

  @override
  State<AdminDashboardApp> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardApp> {
  Widget _selectedScreen = const AddVenueScreen();
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<dynamic>? _proximitySubscription;
  final double _shakeThreshold = 15.0; // Adjust threshold if needed
  DateTime _lastShakeTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Listen for shake events (for logout)
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      final double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (acceleration > _shakeThreshold) {
        final now = DateTime.now();
        if (now.difference(_lastShakeTime) > const Duration(seconds: 2)) {
          _lastShakeTime = now;
          _confirmLogout();
        }
      }
    });
    // Listen for proximity sensor events (for opening drawer)
    _proximitySubscription = ProximitySensor.events.listen((int event) {
      // Typically, a value of 1 means an object is near the sensor.
      if (event == 1) {
        // Using ScaffoldMessenger to show a short message before opening drawer.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Proximity sensor triggered: Opening drawer"),
            duration: Duration(seconds: 1),
          ),
        );
        // Open drawer (ensuring context is a descendant of Scaffold)
        // Use WidgetsBinding to schedule it after the current frame.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Scaffold.of(context).openDrawer();
        });
      }
    });
  }

  Future<void> _confirmLogout() async {
    if (!mounted) return;
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (shouldLogout == true) {
      final sharedPrefs = getIt<SharedPreferences>();
      await sharedPrefs.remove('token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginView()),
      );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _proximitySubscription?.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          _selectedScreen = const AddVenueScreen();
          break;
        case 1:
          _selectedScreen = const AllVenuesPage();
          break;
        case 2:
          _selectedScreen = const ContactsPage();
          break;
        case 3:
          _selectedScreen = const AdminBookingPage();
          break;
        case 4:
          _selectedScreen = const ViewUsersScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blueAccent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text(
                  'Admin Panel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text('Add Products',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () => _onItemTapped(0),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.white),
                title: const Text('View Products',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () => _onItemTapped(1),
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail, color: Colors.white),
                title: const Text('View Contact',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () => _onItemTapped(2),
              ),
              ListTile(
                leading: const Icon(Icons.book, color: Colors.white),
                title: const Text('View Orders',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () => _onItemTapped(3),
              ),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.white),
                title: const Text('View Users',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () => _onItemTapped(4),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Logout',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () => _confirmLogout(),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _confirmLogout(),
          ),
        ],
      ),
      body: _selectedScreen,
    );
  }
}
