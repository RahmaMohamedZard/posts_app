import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/domain/usecases/get_All_Posts.dart';
import 'package:pots_app/presentation/bloc/post/posts_events.dart';
import 'package:pots_app/presentation/bloc/post/posts_states.dart';
import 'package:pots_app/src/core/error/error.dart';



class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(LoadingPostsState());
      final failureOrPosts = await getAllPosts();
      emit(_mapFailureOrPostsToState(failureOrPosts as Either<Failure, List<Post>>));
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return "Unexpected Error. Please try again.";
  }
}