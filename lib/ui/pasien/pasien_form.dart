import 'package:klinik_app/model/pasien.dart';
import 'package:klinik_app/service/pasien_service.dart';
import 'package:klinik_app/ui/pasien/pasien_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy/MM/dd');

// Formulir untuk menambah data pasien
class PasienForm extends StatefulWidget {
  const PasienForm({Key? key});

  @override
  State<PasienForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PasienForm> {
  final formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nomorRMController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _alamatController = TextEditingController();

  DateTime? _selectedDate;

  // Method untuk menampilkan date picker
  void _showDatePicker() async {
    DateTime now = DateTime.now();
    DateTime currentDate = _selectedDate ?? now;

    final DateTime firstDate = DateTime(
      currentDate.year - 1000,
      currentDate.month,
      currentDate.day,
    );

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pasien"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                fieldNama(),
                const SizedBox(height: 20),
                fieldNomorRM(),
                const SizedBox(height: 20),
                fieldNomorTelp(),
                const SizedBox(height: 20),
                fieldAlamat(),
                const SizedBox(height: 20),
                fieldTanggalLahir(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: tombolSimpan(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk input nama pasien
  Widget fieldNama() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Nama Pasien",
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _namaController,
    );
  }

  // Widget untuk input nomor RM pasien
  Widget fieldNomorRM() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Nomor RM',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _nomorRMController,
      keyboardType: TextInputType.number,
    );
  }

  // Widget untuk input nomor telepon pasien
  Widget fieldNomorTelp() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Nomor Telepon',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _nomorTeleponController,
      keyboardType: TextInputType.phone,
    );
  }

  // Widget untuk input alamat pasien
  Widget fieldAlamat() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Alamat',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _alamatController,
      keyboardType: TextInputType.streetAddress,
    );
  }

  // Widget untuk input tanggal lahir pasien
  Widget fieldTanggalLahir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Lahir:',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              _selectedDate == null
                  ? 'Pilih Tanggal Lahir'
                  : formatter.format(_selectedDate!),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: _showDatePicker,
              icon: const Icon(Icons.calendar_month),
            )
          ],
        ),
      ],
    );
  }

  // Widget untuk tombol simpan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        // Validasi input sebelum menyimpan data
        if (_namaController.text.trim().isEmpty ||
            _nomorRMController.text.trim().isEmpty ||
            _alamatController.text.trim().isEmpty ||
            _nomorTeleponController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text(
                  'Pastikan Nama Pasien, Nomor RM, Alamat, Nomor Telepon, dan Tanggal Lahir Sudah Terisi!'),
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

        // Membuat objek Pasien dari inputan pengguna
        Pasien pasien = Pasien(
          nama: _namaController.text.trim(),
          nomorRM: _nomorRMController.text.trim(),
          nomorTelepon: _nomorTeleponController.text.trim(),
          tanggalLahir: _selectedDate!,
          alamat: _alamatController.text.trim(),
        );

        // Menyimpan data pasien ke dalam database
        await PasienService().simpan(pasien).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PasienDetail(pasien: value),
            ),
          );
        });
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Tambah Pasien',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
