import 'package:dio/dio.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://6661bc1c63e6a0189feb5448.mockapi.io/api/v1/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 3)
  )
);

class ApiClient {
  Future<Response> get(String path) async {
    try {
      final response = await dio.get(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await dio.post(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await dio.put(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}