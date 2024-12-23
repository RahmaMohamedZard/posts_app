import 'package:flutter/material.dart';
import 'package:pots_app/domain/entity/post.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "User ID: ${post.props}",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          post.body,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                // Implement your update functionality here
              },
              child: const Text('Edit Post'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Implement your delete functionality here
              },
              child: const Text('Delete Post'),
            ),
          ],
        ),
      ],
    );
  }
}