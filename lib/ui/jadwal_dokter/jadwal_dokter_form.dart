import 'package:klinik_app/model/jadwal_dokter.dart'; // Import model JadwalDokter
import 'package:klinik_app/model/poli.dart'; // Import model Poli
import 'package:klinik_app/service/jadwal_dokter_service.dart'; // Import service JadwalDokterService
import 'package:klinik_app/service/poli_service.dart'; // Import service PoliService
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_detail.dart'; // Import halaman detail JadwalDokter
import 'package:flutter/material.dart'; // Import package Flutter
import 'package:intl/intl.dart'; // Import package untuk format tanggal

final formatter = DateFormat('yyyy/MM/dd'); // Format tanggal

// Halaman form untuk menambah atau mengubah JadwalDokter
class JadwalDokterForm extends StatefulWidget {
  const JadwalDokterForm({super.key});

  @override
  State<JadwalDokterForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<JadwalDokterForm> {
  final formKey = GlobalKey<FormState>();
  final namaDokterController = TextEditingController();
  String? _selectedPoli;
  DateTime? _selectedDate;

  List<Poli> _availablePoli = [];

  // Method untuk mendapatkan data poli
  void getPoli() async {
    List<Poli> dataPoli = await PoliService().listData();

    setState(() {
      _availablePoli = dataPoli;
    });
  }

  // Method untuk menampilkan date picker
  void _showDatePicker() async {
    DateTime now = DateTime.now();
    DateTime currentDate = _selectedDate ?? now;

    final DateTime firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );

    final DateTime lastDate = DateTime(
      now.year,
      now.month + 1,
      now.day,
    );

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void initState() {
    getPoli();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Jadwal Dokter")), // AppBar dengan judul
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                fieldNamaDokter(), // Field untuk memasukkan nama dokter
                const SizedBox(height: 20),
                fieldNamaPoli(), // Field untuk memilih nama poli
                const SizedBox(height: 20),
                fieldTanggal(), // Field untuk memilih tanggal
                const SizedBox(height: 20),
                tombolSimpan() // Tombol untuk menyimpan data
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Field untuk memilih nama poli
  fieldNamaPoli() {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: const Text(
          'Pilih Poli',
          style: TextStyle(fontSize: 17, color: Colors.black87),
        ),
        value: _selectedPoli,
        isExpanded: true,
        items: _availablePoli
            .map((poli) => DropdownMenuItem(
                  value: poli.namaPoli,
                  child: Text(poli.namaPoli),
                ))
            .toList(),
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _selectedPoli = value;
          });
        },
      ),
    );
  }

  // Field untuk memasukkan nama dokter
  fieldNamaDokter() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Dokter"),
      controller: namaDokterController,
    );
  }

  // Field untuk memilih tanggal
  fieldTanggal() {
    return Row(
      children: [
        Text(
          _selectedDate == null
              ? 'Tanggal Belum Dipilih'
              : formatter.format(_selectedDate!),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: _showDatePicker, // Ketika tombol kalender ditekan
          icon: const Icon(Icons.calendar_month),
        )
      ],
    );
  }

  // Tombol untuk menyimpan data jadwal dokter
  tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_selectedPoli == null ||
            namaDokterController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text(
                  'Pastikan Nama Dokter, Poli, dan Tanggal Sudah Terisi!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Mengerti'),
                )
              ],
            ),
          );

          return;
        }

        JadwalDokter jadwal_dokter = JadwalDokter(
          namaPoli: _selectedPoli!,
          namaDokter: namaDokterController.text,
          tanggal: _selectedDate!,
        );

        await JadwalDokterService().simpan(jadwal_dokter).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JadwalDokterDetail(jadwal_dokter: value), // Navigasi ke halaman detail JadwalDokter
            ),
          );
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      child: const Text("Simpan"),
    );
  }
}
