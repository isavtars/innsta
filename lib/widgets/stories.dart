import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  Stories({super.key});

  final List<String> stories = [
    'assets/story1.jpg',
    'assets/story2.jpg',
    'assets/story3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: stories.length,
        itemBuilder: (ctx, index) => Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(stories[index]),
                ),
                // Text(stories[index].name),
              ],
            ));
  }
}
