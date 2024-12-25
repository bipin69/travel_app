import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/images/ikka.jpeg'), // Replace with your image
          ),
        ),
        title: const Text(
          'IKKA',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore the Beautiful world!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Best Destination",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View all",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCard(
                    image:
                        'assets/images/phewa.jpeg', // Replace with your image
                    title: 'Phewa Lake',
                    location: 'Pokhara',
                    rating: 4.7,
                    userCount: 50,
                  ),
                  buildCard(
                    image: 'assets/images/mustang.jpeg',
                    title: 'Mustang',
                    location: 'Mustang',
                    rating: 4.5,
                    userCount: 30,
                  ),
                  buildCard(
                    image: 'assets/images/Chitwan.jpg',
                    title: 'Chitwan Natonal Park',
                    location: 'Chitwan',
                    rating: 4.5,
                    userCount: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
                color: Colors.blue,
              ),
              label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message, color: Colors.blue), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              label: "Profile"),
        ],
      ),
    );
  }

  Widget buildCard({
    required String image,
    required String title,
    required String location,
    required double rating,
    required int userCount,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover, // Ensures the image scales properly
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.5), // Background overlay for text
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 16),
                Text(
                  location,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 12,
                  backgroundImage:
                      AssetImage('assets/images/ikka.jpeg'), // User avatars
                ),
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage('assets/images/ikka.jpeg'),
                ),
                Text(
                  "+$userCount",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
