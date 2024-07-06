// Class model Poli yang merepresentasikan data poli
class Poli {
  // Deklarasi atribut untuk class Poli
  String? id;
  String namaPoli;
  String deskripsi;

  // Konstruktor untuk class Poli
  Poli({
    this.id,
    required this.namaPoli,
    required this.deskripsi
  });

  // Factory method untuk membuat instance Poli dari JSON
  factory Poli.fromJson(Map<String, dynamic> json) {
    return Poli(
      id: json['id'].toString(), // Konversi id dari JSON ke String
      namaPoli: json['nama_poli'], // Ambil nama poli dari JSON
      deskripsi: json['deskripsi'] // Ambil deskripsi poli dari JSON
    );
  }

  // Method untuk mengkonversi instance Poli ke JSON
  Map<String, dynamic> toJson() {
    return {
      "nama_poli": namaPoli, // Set nama poli ke JSON
      "deskripsi": deskripsi
    };
  }
}
