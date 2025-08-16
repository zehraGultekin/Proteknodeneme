import 'package:dartz/dartz.dart';
import 'package:proteknodenee/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<String, User>> login(String email, String password);
}
