import 'package:intl/intl.dart'; // Import package intl untuk format tanggal

// Class model Pegawai yang merepresentasikan data pegawai
class Pegawai {
  // Deklarasi atribut untuk class Pegawai
  String? id;
  String nip;
  String nama;
  DateTime tanggalLahir;
  String nomorTelepon;
  String email;
  String password;

  // Konstruktor untuk class Pegawai
  Pegawai({
    this.id,
    required this.nip,
    required this.nama,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.email,
    required this.password,
  });

  // Inisialisasi DateFormat untuk format tanggal
  final DateFormat format = DateFormat("dd MMMM yyyy");

  // Factory method untuk membuat instance Pegawai dari JSON
  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'].toString(), // Konversi id dari JSON ke String
      nip: json['nip'], // Ambil nip dari JSON
      nama: json['nama'], // Ambil nama dari JSON
      tanggalLahir: DateTime.parse(json['tanggal_lahir']), // Konversi tanggal lahir dari JSON ke DateTime
      nomorTelepon: json['nomor_telepon'], // Ambil nomor telepon dari JSON
      email: json['email'], // Ambil email dari JSON
      password: json['password'], // Ambil password dari JSON
    );
  }
  
  // Getter untuk mendapatkan tanggal lahir yang sudah diformat
  String get formattedTanggalLahir {
    return format.format(tanggalLahir);
  }

  // Method untuk mengkonversi instance Pegawai ke JSON
  Map<String, dynamic> toJson() {
    return {
      'nip': nip, // Set nip ke JSON
      'nama': nama, // Set nama ke JSON
      'tanggal_lahir': tanggalLahir.toString(), // Konversi tanggal lahir ke String dan set ke JSON
      'nomor_telepon': nomorTelepon, // Set nomor telepon ke JSON
      'email': email, // Set email ke JSON
      'password': password, // Set password ke JSON
    };
  }
}
