// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';  
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/presentation/widgets/post_add_update_page/from_submit_btn.dart';
import 'package:pots_app/presentation/widgets/post_add_update_page/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({
    super.key,
    required this.isUpdatePost,
    this.post,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: "Title",
            multiLines: false,
            controller: _titleController,
          ),
          TextFormFieldWidget(
            name: "Body",
            multiLines: true,
            controller: _bodyController,
          ),
          FormSubmitBtn(
            isUpdatePost: widget.isUpdatePost,
            onPressed: validateFormThenUpdateOrAddPost,
            
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        await updatePost(post); 
      } else {
        await addPost(post); 
      }
    }
  }

  Future<void> addPost(Post post) async {
    try {
      final response = await Dio().post(
        'https://dummyjson.com/posts',
        data: {
          'title': post.title,
          'body': post.body,
        },
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

  Future<void> updatePost(Post post) async {
    try {
      final response = await Dio().put(
        'https://dummyjson.com/posts/${post.id}',
        data: {
          'title': post.title,
          'body': post.body,
        },
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
  }
}