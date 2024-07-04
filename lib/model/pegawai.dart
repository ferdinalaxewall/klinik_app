import 'package:intl/intl.dart';

class Pegawai {
  String? id;
  String nip;
  String nama;
  DateTime tanggalLahir;

  String nomorTelepon;
  String email;
  String password;

  Pegawai({
    this.id,
    required this.nip,
    required this.nama,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.email,
    required this.password,
  });

  final DateFormat format = DateFormat("dd MMMM yyyy");

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'].toString(),
      nip: json['nip'],
      nama: json['nama'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      nomorTelepon: json['nomor_telepon'],
      email: json['email'],
      password: json['password'],
    );
  }
  
  String get formattedTanggalLahir {
    return format.format(tanggalLahir);
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'nama': nama,
      'tanggal_lahir': tanggalLahir.toString(),
      'nomor_telepon': nomorTelepon,
      'email': email,
      'password': password,
    };
  }
}
