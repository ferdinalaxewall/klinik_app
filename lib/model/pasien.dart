// model/pasien.dart

import 'package:intl/intl.dart';

class Pasien {
  final String? id;
  final String nomorRM;
  final String nama;
  final DateTime tanggalLahir;
  final String nomorTelepon;
  final String alamat;

  Pasien({
    this.id,
    required this.nomorRM,
    required this.nama,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.alamat,
  });

  final DateFormat format = DateFormat("dd MMMM yyyy");

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      id: json['id'].toString(),
      nomorRM: json['nomor_rm'],
      nama: json['nama'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      nomorTelepon: json['nomor_telepon'],
      alamat: json['alamat'],
    );
  }

  String get formattedTanggalLahir {
    return format.format(tanggalLahir);
  }

  Map<String, dynamic> toJson() {
    return {
      'nomor_rm': nomorRM,
      'nama': nama,
      'tanggal_lahir': tanggalLahir.toString(),
      'nomor_telepon': nomorTelepon,
      'alamat': alamat,
    };
  }
}
