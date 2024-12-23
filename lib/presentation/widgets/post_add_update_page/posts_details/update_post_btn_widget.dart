import 'package:flutter/material.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/src/core/routes/names.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(
          context,
          RoutesName.addOrUpdate,
          arguments: {
            'isUpdatePost': true,
            'post': post
          },
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}