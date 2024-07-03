import 'package:dio/dio.dart';
import 'package:first_mobile_app/helper/api_client.dart';
import 'package:first_mobile_app/model/jadwal_dokter.dart';

class JadwalDokterService {
  Future<List<JadwalDokter>> listData() async {
    final Response response = await ApiClient().get('jadwal-dokter');
    final List data = response.data as List;
    List<JadwalDokter> result = data.map((json) => JadwalDokter.fromJson(json)).toList();

    return result;
  } 
  
  Future<JadwalDokter> simpan(JadwalDokter jadwal_dokter) async {
    var data = jadwal_dokter.toJson();
    print(data);
    final Response response = await ApiClient().post('jadwal-dokter', data);
    JadwalDokter result = JadwalDokter.fromJson(response.data);

    return result;
  } 

  Future<JadwalDokter> ubah(JadwalDokter jadwal_dokter, String id) async {
    var data = jadwal_dokter.toJson();
    final Response response = await ApiClient().put('jadwal-dokter/${id}', data);
    JadwalDokter result = JadwalDokter.fromJson(response.data);

    return result;
  } 

  Future<JadwalDokter> getById(String id) async {
    final Response response = await ApiClient().get('jadwal-dokter/${id}');
    JadwalDokter result = JadwalDokter.fromJson(response.data);

    return result;
  } 

  Future<void> hapus(JadwalDokter jadwal_dokter) async {
    await ApiClient().delete('jadwal-dokter/${jadwal_dokter.id}');
    return;
  } 
}