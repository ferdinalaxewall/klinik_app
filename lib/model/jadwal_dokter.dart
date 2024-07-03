import 'package:intl/intl.dart';

class JadwalDokter {
  String? id;
  String namaPoli;
  String namaDokter;
  DateTime tanggal;

  final DateFormat format = DateFormat("dd MMMM yyyy");

  JadwalDokter({
    this.id,
    required this.namaPoli,
    required this.namaDokter,
    required this.tanggal,
  });

  factory JadwalDokter.fromJson(Map<String, dynamic> json) {
    return JadwalDokter(
      id: json['id'].toString(),
      namaPoli: json['nama_poli'],
      namaDokter: json['nama_dokter'],
      tanggal: DateFormat('yyyy-MM-dd').parse(json['tanggal']),
    );
  }

  String get formattedTanggal {
    return format.format(tanggal);
  }

  Map<String, dynamic> toJson() {
    return {
      "nama_poli": namaPoli,
      "nama_dokter": namaDokter,
      "tanggal": tanggal.toString()
    };
  }
}
