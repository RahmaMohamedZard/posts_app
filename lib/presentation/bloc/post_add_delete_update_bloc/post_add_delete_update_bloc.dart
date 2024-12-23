import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/domain/usecases/add_Post.dart';
import 'package:pots_app/domain/usecases/delete_Post.dart';
import 'package:pots_app/domain/usecases/up_date_Post.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_events.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_state.dart';
import 'package:pots_app/src/core/error/error.dart';
import 'package:pots_app/src/core/utils/msgs.dart';


class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPost addPost;
  final DeletePost deletePost;
  final UpDatePost updatePost;

  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddPostEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdatePostState());
      final failureOrDoneMessage = await addPost(event.post);
      emit(
        _eitherDoneMessageOrErrorState(
          failureOrDoneMessage,
          ADD_SUCCESS_MESSAGE,
        ),
      );
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdatePostState());
      final failureOrDoneMessage = await updatePost(event.post);
      emit(
        _eitherDoneMessageOrErrorState(
          failureOrDoneMessage,
          UPDATE_SUCCESS_MESSAGE,
        ),
      );
    });

    on<DeletePostEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdatePostState());
      final failureOrDoneMessage = await deletePost(event.postId);
      emit(
        _eitherDoneMessageOrErrorState(
          failureOrDoneMessage,
          DELETE_SUCCESS_MESSAGE,
        ),
      );
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}