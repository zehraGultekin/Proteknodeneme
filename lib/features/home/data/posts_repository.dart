import 'package:dartz/dartz.dart';
import 'package:proteknodenee/features/home/data/models/post_model.dart';

abstract interface class PostsRepository {
  Future<Either<String, List<Post>>> getPosts();
}
