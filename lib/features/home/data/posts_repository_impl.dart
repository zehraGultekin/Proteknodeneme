import 'package:dartz/dartz.dart';
import 'package:proteknodenee/core/network/dio_client.dart';
import 'package:proteknodenee/features/home/data/models/post_model.dart';
import 'package:proteknodenee/features/home/data/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final DioClient dioClient = DioClient();

  @override
 Future<Either<String, List<Post>>> getPosts() async {
    try {
      final response = await dioClient.dio.get('/posts');
      final posts = (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
      return Right(posts);
    } catch (e) {
      return Left("Postlar yüklenemedi: $e");
    }
  }
}