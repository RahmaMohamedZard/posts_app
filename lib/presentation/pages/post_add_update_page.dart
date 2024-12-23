import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_bloc.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_state.dart';
import 'package:pots_app/presentation/pages/posts_pages.dart';
import 'package:pots_app/presentation/widgets/post_add_update_page/from_widget.dart';
import 'package:pots_app/src/core/utils/snackbar_meg.dart';
import 'package:pots_app/src/core/widgets/widgets.dart';


class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                  message: state.message,
                  context: context,
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false,
                );
              } else if (state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage().showErrorSnackBar(
                  message: state.message,
                  context: context,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const LoadingWidget();
              }

              return FormWidget(
                isUpdatePost: isUpdatePost,
                post: isUpdatePost ? post : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
