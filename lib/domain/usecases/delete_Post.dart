import 'package:dartz/dartz.dart';
import 'package:pots_app/domain/repository/posts_repository.dart';
import 'package:pots_app/src/core/error/error.dart';

class DeletePost {
  final PostsRepository repository;

  DeletePost(this.repository);

   Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}