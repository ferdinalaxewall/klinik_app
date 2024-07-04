import 'package:intl/intl.dart';

// Kelas untuk jadwal dokter
class JadwalDokter {
  String? id;
  String namaPoli;
  String namaDokter;
  DateTime tanggal;
  
  // Format tanggal untuk ditampilkan
  final DateFormat format = DateFormat("dd MMMM yyyy"); 

  // Konstruktor untuk inisialisasi atribut
  JadwalDokter({
    this.id,
    required this.namaPoli,
    required this.namaDokter,
    required this.tanggal,
  });

  // Konstruktor pabrik untuk membuat instance dari map JSON
  factory JadwalDokter.fromJson(Map<String, dynamic> json) {
    return JadwalDokter(
      id: json['id'].toString(), // Ubah id ke string
      namaPoli: json['nama_poli'], // Set namaPoli dari JSON
      namaDokter: json['nama_dokter'], // Set namaDokter dari JSON
      tanggal: DateFormat('yyyy-MM-dd').parse(json['tanggal']), // Parse tanggal dari string ke DateTime
    );
  }

  // Getter untuk mendapatkan tanggal yang diformat
  String get formattedTanggal {
    return format.format(tanggal); // Format tanggal ke string yang bisa dibaca
  }

  // Method untuk mengubah instance ke map JSON
  Map<String, dynamic> toJson() {
    return {
      "nama_poli": namaPoli, // Set namaPoli ke map JSON
      "nama_dokter": namaDokter, // Set namaDokter ke map JSON
      "tanggal": tanggal.toString() // Ubah tanggal ke string
    };
  }
}
