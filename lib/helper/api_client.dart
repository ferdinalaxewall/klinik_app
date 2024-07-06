import 'package:dio/dio.dart'; // Import package Dio untuk melakukan request HTTP

// Class untuk mengelola API client menggunakan Dio
class ApiClient {
  ApiClient({ this.customBaseURL });
  
  String apiBaseURL1 = 'https://6661bc1c63e6a0189feb5448.mockapi.io/api/v1/';
  String? customBaseURL;

  // Inisialisasi objek Dio dengan konfigurasi dasar
  late final Dio dio = Dio(
    BaseOptions(
      // URL dasar menggunakan MockAPI
      baseUrl: customBaseURL ?? apiBaseURL1,

      // URL dasar menggunakan aplikasi lokal NestJS
      // baseUrl: 'http://localhost:3000/',
      connectTimeout: const Duration(seconds: 5), // Waktu timeout untuk koneksi
      receiveTimeout: const Duration(seconds: 3) // Waktu timeout untuk menerima data
    )
  );

  // Method untuk melakukan request GET
  Future<Response> get(String path) async {
    try {
      // Melakukan request GET dan mengembalikan respon
      final response = await dio.get(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      // Menangani kesalahan dan melempar exception
      throw Exception(e.message);
    }
  }

  // Method untuk melakukan request POST
  Future<Response> post(String path, dynamic data) async {
    try {
      // Melakukan request POST dengan data dan mengembalikan respon
      final response = await dio.post(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      // Menangani kesalahan dan melempar exception
      throw Exception(e.message);
    }
  }

  // Method untuk melakukan request PUT
  Future<Response> put(String path, dynamic data) async {
    try {
      // Melakukan request PUT dengan data dan mengembalikan respon
      final response = await dio.put(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      // Menangani kesalahan dan melempar exception
      throw Exception(e.message);
    }
  }

  // Method untuk melakukan request DELETE
  Future<Response> delete(String path) async {
    try {
      // Melakukan request DELETE dan mengembalikan respon
      final response = await dio.delete(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      // Menangani kesalahan dan melempar exception
      throw Exception(e.message);
    }
  }
}
