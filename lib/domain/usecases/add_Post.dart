import 'package:dartz/dartz.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/domain/repository/posts_repository.dart';
import 'package:pots_app/src/core/error/error.dart';

class AddPost {
  final PostsRepository repository;

  AddPost (this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}