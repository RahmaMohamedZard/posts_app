import 'package:flutter/material.dart';
import 'package:pots_app/presentation/pages/post_add_update_page.dart';
import 'package:pots_app/presentation/pages/posts_details.dart';
import 'package:pots_app/presentation/pages/posts_pages.dart';


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.posts:
        return MaterialPageRoute(builder: (_) => const PostsPage());
   
      case RoutesName.postDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PostDetailPage(post: args?['post']),
        );
      
      case RoutesName.addOrUpdate:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PostAddUpdatePage(
            isUpdatePost: args?['isUpdatePost'] ?? false,
            post: args?['post'],
          ),
        );
    }
    return null;
  }
}


   
    