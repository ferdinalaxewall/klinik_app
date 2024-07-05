import 'package:dio/dio.dart';
import 'package:klinik_app/helper/api_client.dart';
import 'package:klinik_app/model/pasien.dart';

class PasienService {
  final String? apiBaseURL = 'https://668797580bc7155dc0183b54.mockapi.io/api/v1/';

  Future<List<Pasien>> listData() async {
    final Response response = await ApiClient(customBaseURL: apiBaseURL).get('pasien');
    final List data = response.data as List;
    List<Pasien> result = data.map((json) => Pasien.fromJson(json)).toList();

    return result;
  } 
  
  Future<Pasien> simpan(Pasien pasien) async {
    var data = pasien.toJson();
    final Response response = await ApiClient(customBaseURL: apiBaseURL).post('pasien', data);
    Pasien result = Pasien.fromJson(response.data);

    return result;
  } 

  Future<Pasien> ubah(Pasien pasien, String id) async {
    var data = pasien.toJson();
    final Response response = await ApiClient(customBaseURL: apiBaseURL).put('pasien/${id}', data);
    Pasien result = Pasien.fromJson(response.data);

    return result;
  } 

  Future<Pasien> getById(String id) async {
    final Response response = await ApiClient(customBaseURL: apiBaseURL).get('pasien/${id}');
    Pasien result = Pasien.fromJson(response.data);

    return result;
  } 

  Future<void> hapus(Pasien pasien) async {
    await ApiClient(customBaseURL: apiBaseURL).delete('pasien/${pasien.id}');
    return;
  } 
}