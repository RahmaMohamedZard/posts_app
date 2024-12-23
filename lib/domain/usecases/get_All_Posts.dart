import 'package:dartz/dartz.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/domain/repository/posts_repository.dart';
import 'package:pots_app/src/core/error/error.dart';

class GetAllPosts {
  final PostsRepository repository;

  GetAllPosts(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}