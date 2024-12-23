import 'package:dartz/dartz.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/domain/repository/posts_repository.dart';
import 'package:pots_app/src/core/error/error.dart';

class UpDatePost {
  final PostsRepository repository;

  UpDatePost(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}