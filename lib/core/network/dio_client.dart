import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
         BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com/',  
  connectTimeout: const Duration(seconds: 5), 
  receiveTimeout: const Duration(seconds: 3), 
),

        );
}
