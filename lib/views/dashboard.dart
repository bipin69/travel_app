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
                'assets/images/phewa.jpeg'), // Replace with your image
          ),
        ),
        title: const Text(
          'Ram',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
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
            const SizedBox(height: 16),
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
            SizedBox(height: 16),
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
                    image: 'assets/destination2.jpg',
                    title: 'Destination 2',
                    location: 'Somewhere',
                    rating: 4.5,
                    userCount: 30,
                  ),
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
      margin: EdgeInsets.only(right: 16),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue, size: 16),
              Text(
                location,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 16),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/user1.jpg'), // User avatars
              ),
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/user2.jpg'),
              ),
              Text(
                "+$userCount",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
