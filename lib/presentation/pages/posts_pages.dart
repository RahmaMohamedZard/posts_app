import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/presentation/bloc/post/posts_blok.dart';
import 'package:pots_app/presentation/bloc/post/posts_events.dart';
import 'package:pots_app/presentation/bloc/post/posts_states.dart';
import 'package:pots_app/presentation/widgets/post_add_update_page/posts_details/posts_pages/mege_display_widget.dart';
import 'package:pots_app/presentation/widgets/post_add_update_page/posts_details/posts_pages/posts_list_widget.dart';
import 'package:pots_app/src/core/routes/names.dart';
import 'package:pots_app/src/core/widgets/widgets.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
     RoutesName.addOrUpdate,
          arguments: {'isUpdatePost': false},
        );
      },
      child: const Icon(Icons.add),
    );
  }
}