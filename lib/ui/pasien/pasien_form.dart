import 'package:first_mobile_app/model/pasien.dart';
import 'package:first_mobile_app/service/pasien_service.dart';
import 'package:first_mobile_app/ui/pasien/pasien_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy/MM/dd');

class PasienForm extends StatefulWidget {
  const PasienForm({super.key});

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
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                tombolSimpan()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldNama() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pasien"),
      controller: _namaController,
    );
  }

  Widget fieldNomorRM() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Nomor RM'),
      controller: _nomorRMController,
      keyboardType: TextInputType.number,
    );
  }

  Widget fieldNomorTelp() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Nomor Telepon'),
      controller: _nomorTeleponController,
      keyboardType: TextInputType.phone,
    );
  }

  Widget fieldTanggalLahir() {
    return Row(
      children: [
        Text(
          _selectedDate == null
              ? 'Pilih Tanggal Lahir'
              : formatter.format(_selectedDate!),
          style: const TextStyle(
            fontSize: 16,
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
    );
  }

  Widget fieldAlamat() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Alamat'),
      controller: _alamatController,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_namaController.text.trim().isEmpty ||
            _nomorRMController.text.trim().isEmpty ||
            _alamatController.text.trim().isEmpty ||
            _nomorTeleponController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text('Pastikan Nama Pasien, Nomor RM, Alamat, Nomor Telepon, dan Tanggal Lahir Sudah Terisi!'),
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

        Pasien pasien = Pasien(
          nama: _namaController.text.trim(),
          nomorRM: _nomorRMController.text.trim(),
          nomorTelepon: _nomorTeleponController.text.trim(),
          tanggalLahir: _selectedDate!,
          alamat: _alamatController.text.trim(),
        );

        await PasienService().simpan(pasien).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasienDetail(pasien: value),
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
