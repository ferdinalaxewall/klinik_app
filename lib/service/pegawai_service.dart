import 'package:dio/dio.dart';
import 'package:klinik_app/helper/api_client.dart';
import 'package:klinik_app/model/pegawai.dart';

class PegawaiService {
  final String? apiBaseURL = 'https://668797580bc7155dc0183b54.mockapi.io/api/v1/';

  Future<List<Pegawai>> listData() async {
    final Response response = await ApiClient(customBaseURL: apiBaseURL).get('pegawai');
    final List data = response.data as List;
    List<Pegawai> result = data.map((json) => Pegawai.fromJson(json)).toList();

    return result;
  } 
  
  Future<Pegawai> simpan(Pegawai pegawai) async {
    var data = pegawai.toJson();
    final Response response = await ApiClient(customBaseURL: apiBaseURL).post('pegawai', data);
    Pegawai result = Pegawai.fromJson(response.data);

    return result;
  } 

  Future<Pegawai> ubah(Pegawai pegawai, String id) async {
    var data = pegawai.toJson();
    final Response response = await ApiClient(customBaseURL: apiBaseURL).put('pegawai/${id}', data);
    Pegawai result = Pegawai.fromJson(response.data);

    return result;
  } 

  Future<Pegawai> getById(String id) async {
    final Response response = await ApiClient(customBaseURL: apiBaseURL).get('pegawai/${id}');
    Pegawai result = Pegawai.fromJson(response.data);

    return result;
  } 

  Future<void> hapus(Pegawai pegawai) async {
    await ApiClient(customBaseURL: apiBaseURL).delete('pegawai/${pegawai.id}');
    return;
  } 
}