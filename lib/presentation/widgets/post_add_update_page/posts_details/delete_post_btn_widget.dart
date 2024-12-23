import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_bloc.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_state.dart';
import 'package:pots_app/presentation/pages/posts_pages.dart';
import 'package:pots_app/presentation/widgets/post_add_update_page/posts_details/delete_dialog_widget.dart';
import 'package:pots_app/src/core/utils/snackbar_meg.dart';
import 'package:pots_app/src/core/widgets/widgets.dart';  

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const PostsPage(),
                ),
                (route) => false,
              );
            } else if (state is ErrorAddDeleteUpdatePostState) {
              Navigator.of(context).pop();
              SnackBarMessage().showErrorSnackBar(
                  message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }}