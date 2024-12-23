import 'package:flutter/material.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/presentation/pages/posts_details.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(posts[index].id.toString()),
          ),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailPage(post: posts[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}