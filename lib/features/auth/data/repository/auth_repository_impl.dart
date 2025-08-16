import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:proteknodenee/features/auth/data/models/user_model.dart';
import 'package:proteknodenee/features/auth/data/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  @override
  Future<Either<String, User>> login(String email, String password) async {
    try {
      final response = await _dio.get('/users');
      final List data = response.data;
      final users = data.map((json) => User.fromJson(json)).toList();

      final user = users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase(),
        orElse: () => throw Exception('User not found'),
      );

      // Not: JsonPlaceholder’da şifre yok, sadece test için email kontrolü yapıyoruz
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> register(String email, String password) async {
    return Left('Not implemented');
  }
}
