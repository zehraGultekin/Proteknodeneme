import 'package:dartz/dartz.dart';
import 'package:proteknodenee/core/network/dio_client.dart';
import 'auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient = DioClient();

  @override
  Future<Either<String, User>> login(String email, String password) async {
    try {
      final response = await dioClient.dio.get('/users');
      final users = (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
      User? user;
      try {
        user = users.firstWhere(
          (u) => u.email.toLowerCase() == email.toLowerCase(),
        );
      } catch (_) {
        user = null;
      }

      if (user != null && password == "1234") {
        return Right(user);
      } else {
        return Left("Kullanıcı bulunamadı veya şifre yanlış");
      }
    } catch (e) {
      return Left("Bir hata oluştu: $e");
    }
  }

  
}
