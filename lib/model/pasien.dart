import 'package:intl/intl.dart'; // Import package intl untuk format tanggal

// Class model Pasien yang merepresentasikan data pasien
class Pasien {
  // Deklarasi atribut untuk class Pasien
  final String? id;
  final String nomorRM;
  final String nama;
  final DateTime tanggalLahir;
  final String nomorTelepon;
  final String alamat;

  // Konstruktor untuk class Pasien
  Pasien({
    this.id,
    required this.nomorRM,
    required this.nama,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.alamat,
  });

  // Inisialisasi DateFormat untuk format tanggal
  final DateFormat format = DateFormat("dd MMMM yyyy");

  // Factory method untuk membuat instance Pasien dari JSON
  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      id: json['id'].toString(), // Konversi id dari JSON ke String
      nomorRM: json['nomor_rm'], // Ambil nomor rekam medis dari JSON
      nama: json['nama'], // Ambil nama dari JSON
      tanggalLahir: DateTime.parse(json['tanggal_lahir']), // Konversi tanggal lahir dari JSON ke DateTime
      nomorTelepon: json['nomor_telepon'], // Ambil nomor telepon dari JSON
      alamat: json['alamat'], // Ambil alamat dari JSON
    );
  }

  // Getter untuk mendapatkan tanggal lahir yang sudah diformat
  String get formattedTanggalLahir {
    return format.format(tanggalLahir);
  }

  // Method untuk mengkonversi instance Pasien ke JSON
  Map<String, dynamic> toJson() {
    return {
      'nomor_rm': nomorRM, // Set nomor rekam medis ke JSON
      'nama': nama, // Set nama ke JSON
      'tanggal_lahir': tanggalLahir.toString(), // Konversi tanggal lahir ke String dan set ke JSON
      'nomor_telepon': nomorTelepon, // Set nomor telepon ke JSON
      'alamat': alamat, // Set alamat ke JSON
    };
  }
}
