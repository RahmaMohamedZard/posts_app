import 'package:dartz/dartz.dart';
import 'package:pots_app/domain/entity/post.dart';
import 'package:pots_app/src/core/error/error.dart';


abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> deletePost(int postId);
  Future<Either<Failure, Unit>> updatePost(Post post);
}