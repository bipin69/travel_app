import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hotel_booking/features/auth/data/data_source/remote_datasource/user_profile_service.dart';
import 'package:hotel_booking/features/auth/data/model/user_profile_model.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/user_booking_page.dart';

import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserProfileService profileService = UserProfileService(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<UserProfile>(
        future: profileService.fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.grey, Colors.lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: user.avatar.isNotEmpty
                              ? NetworkImage(user.avatar)
                              : const AssetImage('assets/images/pro.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hello, ${user.username}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Complete your profile for better recommendations',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(user.username, Icons.person),
                  _buildTextField(user.email, Icons.email),
                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(
                        context,
                        "Edit Profile",
                        Icons.edit,
                        Colors.blueAccent,
                        () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EditProfileView()),
                          );
                          setState(() {});
                        },
                      ),
                         const SizedBox(width: 20),
                      _buildButton(
                        context,
                        "Manage Orders",
                        Icons.shopping_cart,
                        Colors.lightBlue,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const UserBookingPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildTextField(String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon,
      Color color, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
