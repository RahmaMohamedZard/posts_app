// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';  

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;
  

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.isUpdatePost,
     
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
      },
      icon: isUpdatePost ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: Text(isUpdatePost ? "Update" : "Add"),
    );
  }

  Future<void> addPost(BuildContext context, String title, String body) async {
    try {
      var response = await Dio().post(
        'https://dummyjson.com/posts',
        data: {'title': title, 'body': body},
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post added successfully!')),
        );
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add post.')),
        );
      }
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> updatePost(BuildContext context, String title, String body) async {
    try {
      var response = await Dio().put(
        'https://dummyjson.com/posts/1', 
        data: {'title': title, 'body': body},
      );
      if (response.statusCode == 200) {
    
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post updated successfully!')),
        );
      } else {
      
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update post.')),
        );
      }
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }}