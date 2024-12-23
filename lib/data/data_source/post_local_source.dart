import 'dart:convert';
import 'package:pots_app/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSource({required this.sharedPreferences});

  Future<void> cachePosts(List<PostModel> posts) async {
    final List<Map<String, dynamic>> postsJson = posts.map((post) => post.toJson()).toList();
    final String encodedData = json.encode(postsJson);
    await sharedPreferences.setString('CACHED_POSTS', encodedData);
  }

  List<PostModel> getCachedPosts() {
    final String? cachedData = sharedPreferences.getString('CACHED_POSTS');
    if (cachedData != null) {
      final List<dynamic> decodedData = json.decode(cachedData);
      return decodedData.map((data) => PostModel.fromJson(data)).toList();
    } else {
      return [];
    }
  }}