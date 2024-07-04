import 'package:dio/dio.dart'; // Package untuk melakukan HTTP request
import 'package:klinik_app/helper/api_client.dart'; // Mengimpor ApiClient dari helper
import 'package:klinik_app/model/jadwal_dokter.dart'; // Mengimpor model JadwalDokter

// Service untuk mengelola data JadwalDokter
class JadwalDokterService {
  
  // Method untuk mengambil semua data jadwal dokter
  Future<List<JadwalDokter>> listData() async {
    final Response response = await ApiClient().get('jadwal-dokter');
    final List data = response.data as List;
    List<JadwalDokter> result = data.map((json) => JadwalDokter.fromJson(json)).toList();
    return result;
  } 
  
  // Method untuk menyimpan jadwal dokter baru
  Future<JadwalDokter> simpan(JadwalDokter jadwal_dokter) async {
    var data = jadwal_dokter.toJson();
    final Response response = await ApiClient().post('jadwal-dokter', data);
    JadwalDokter result = JadwalDokter.fromJson(response.data);
    return result;
  } 

  // Method untuk mengubah data jadwal dokter berdasarkan id
  Future<JadwalDokter> ubah(JadwalDokter jadwal_dokter, String id) async {
    var data = jadwal_dokter.toJson();
    final Response response = await ApiClient().put('jadwal-dokter/${id}', data);
    JadwalDokter result = JadwalDokter.fromJson(response.data);
    return result;
  } 

  // Method untuk mengambil data jadwal dokter berdasarkan id
  Future<JadwalDokter> getById(String id) async {
    final Response response = await ApiClient().get('jadwal-dokter/${id}');
    JadwalDokter result = JadwalDokter.fromJson(response.data);
    return result;
  } 

  // Method untuk menghapus data jadwal dokter
  Future<void> hapus(JadwalDokter jadwal_dokter) async {
    await ApiClient().delete('jadwal-dokter/${jadwal_dokter.id}');
    return;
  } 
}
