import 'package:klinik_app/model/jadwal_dokter.dart'; // Import model JadwalDokter
import 'package:klinik_app/model/poli.dart'; // Import model Poli
import 'package:klinik_app/service/jadwal_dokter_service.dart'; // Import service JadwalDokterService
import 'package:klinik_app/service/poli_service.dart'; // Import service PoliService
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_detail.dart'; // Import halaman detail JadwalDokter
import 'package:flutter/material.dart'; // Import package Flutter
import 'package:intl/intl.dart'; // Import package untuk formatting tanggal

final formatter = DateFormat('yyyy/MM/dd'); // Format tanggal

// Halaman untuk mengubah detail JadwalDokter
class JadwalDokterUpdateForm extends StatefulWidget {
  final JadwalDokter jadwal_dokter; // Data JadwalDokter yang akan diubah

  const JadwalDokterUpdateForm({super.key, required this.jadwal_dokter});

  @override
  State<JadwalDokterUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<JadwalDokterUpdateForm> {
  final formKey = GlobalKey<FormState>(); // Key untuk form
  final namaDokterController = TextEditingController(); // Controller untuk input nama dokter
  String? _selectedPoli; // Poli yang dipilih
  DateTime? _selectedDate; // Tanggal yang dipilih

  List<Poli> _availablePoli = []; // Daftar poli yang tersedia

  // Mengambil data JadwalDokter berdasarkan ID
  Future<JadwalDokter> getData() async {
    JadwalDokter data =
        await JadwalDokterService().getById(widget.jadwal_dokter.id.toString());

    // Update state dengan data yang didapatkan
    setState(() {
      _selectedPoli =
          _availablePoli.contains(data.namaPoli) ? data.namaPoli : null; // Set nilai poli terpilih
      namaDokterController.text = data.namaDokter; // Set nilai nama dokter pada input controller
      _selectedDate = data.tanggal; // Set nilai tanggal terpilih
    });

    return data; // Mengembalikan data JadwalDokter
  }

  // Mengambil daftar poli yang tersedia
  void getPoli() async {
    List<Poli> dataPoli = await PoliService().listData();

    setState(() {
      _availablePoli = dataPoli; // Set daftar poli yang tersedia
    });
  }

  // Menampilkan halaman form ubah JadwalDokter
  @override
  void initState() {
    super.initState();
    getData(); // Ambil data JadwalDokter saat inisialisasi
    getPoli(); // Ambil daftar poli saat inisialisasi
  }

  // Membangun tampilan halaman
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah JadwalDokter")), // Judul AppBar
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              fieldNamaPoli(), // Field untuk memilih poli
              const SizedBox(height: 20),
              fieldNamaDokter(), // Field untuk input nama dokter
              const SizedBox(height: 20),
              fieldTanggal(), // Field untuk memilih tanggal
              const SizedBox(height: 20),
              tombolSimpan() // Tombol untuk menyimpan perubahan
            ],
          ),
        ),
      ),
    );
  }

  // Widget dropdown untuk memilih poli
  fieldNamaPoli() {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: const Text(
          'Pilih Poli', // Hint untuk dropdown poli
          style: TextStyle(fontSize: 17, color: Colors.black87),
        ),
        value: _selectedPoli, // Nilai poli yang dipilih
        isExpanded: true,
        items: _availablePoli
            .map((poli) => DropdownMenuItem(
                  value: poli.namaPoli,
                  child: Text(poli.namaPoli), // Nama poli dalam dropdown
                ))
            .toList(),
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _selectedPoli = value; // Update nilai poli yang dipilih
          });
        },
      ),
    );
  }

  // Widget input untuk nama dokter
  fieldNamaDokter() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Dokter"), // Label input nama dokter
      controller: namaDokterController,
    );
  }

  // Widget untuk memilih tanggal
  fieldTanggal() {
    return Row(
      children: [
        Text(
          _selectedDate == null
              ? 'Tanggal Belum Dipilih' // Teks jika tanggal belum dipilih
              : formatter.format(_selectedDate!), // Format tanggal yang dipilih
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: _showDatePicker,
          icon: const Icon(Icons.calendar_month), // Icon untuk memilih tanggal dari kalender
        )
      ],
    );
  }

  // Tombol untuk menyimpan perubahan
  tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_selectedPoli == null ||
            namaDokterController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'), // Judul dialog input tidak valid
              content: const Text(
                  'Pastikan Nama Dokter, Poli, dan Tanggal Sudah Terisi!'), // Pesan konten dialog
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Mengerti'), // Tombol untuk menutup dialog
                )
              ],
            ),
          );

          return;
        }

        JadwalDokter jadwal_dokter = JadwalDokter(
          namaPoli: _selectedPoli!, // Set poli dari nilai terpilih
          namaDokter: namaDokterController.text, // Set nama dokter dari input controller
          tanggal: _selectedDate!, // Set tanggal dari nilai terpilih
        );
        String id = widget.jadwal_dokter.id.toString(); // Ambil ID JadwalDokter yang akan diubah

        await JadwalDokterService().ubah(jadwal_dokter, id).then((value) {
          Navigator.pop(context); // Tutup halaman ubah JadwalDokter setelah perubahan disimpan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  JadwalDokterDetail(jadwal_dokter: value), // Navigasi ke halaman detail JadwalDokter setelah perubahan disimpan
            ),
          );
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna teks tombol
      ),
      child: const Text("Simpan Perubahan"), // Teks pada tombol
    );
  }
}
