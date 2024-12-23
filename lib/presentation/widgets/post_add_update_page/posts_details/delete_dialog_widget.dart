import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_bloc.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_events.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
// Displaying the post title for confirmation

  const DeleteDialogWidget({
    super.key,
    required this.postId,
   
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text("Are you sure?"),
      content: const Text("This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            // Trigger the deletion event in the Bloc
            BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
              DeletePostEvent(postId: postId),
            );
            Navigator.of(context).pop(); // Close the dialog after deletion
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}