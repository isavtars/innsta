import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 2, // Replace with the actual number of notifications
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/user_image.jpeg'),
            ),
            title: Row(
              children: [
                const Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'liked your photo',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            // trailing: Image.asset(
            //   'assets/notification_image.jpg',
            //   height: 48,
            //   width: 48,
            //   fit: BoxFit.cover,
            // ),
            // onTap: () {
            //   // Handle notification tap
            // },
          );
        },
      ),
    );
  }
}
