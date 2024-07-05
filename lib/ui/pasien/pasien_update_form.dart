import 'package:klinik_app/model/pasien.dart';
import 'package:klinik_app/service/pasien_service.dart';
import 'package:klinik_app/ui/pasien/pasien_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy/MM/dd');

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;
  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);

  @override
  State<PasienUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PasienUpdateForm> {
  final formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nomorRMController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _alamatController = TextEditingController();

  DateTime? _selectedDate;

  // Method untuk mengambil data pasien dari service dan mengisi controller
  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    setState(() {
      _namaController.text = data.nama;
      _nomorRMController.text = data.nomorRM;
      _nomorTeleponController.text = data.nomorTelepon;
      _alamatController.text = data.alamat;
      _selectedDate = data.tanggalLahir;
    });

    return data;
  }

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
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pasien")), // Judul halaman
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              fieldNama(), // Field untuk nama pasien
              const SizedBox(height: 20),
              fieldNomorRM(), // Field untuk nomor RM
              const SizedBox(height: 20),
              fieldNomorTelp(), // Field untuk nomor telepon
              const SizedBox(height: 20),
              fieldAlamat(), // Field untuk alamat
              const SizedBox(height: 20),
              fieldTanggalLahir(), // Field untuk tanggal lahir
              const SizedBox(height: 20),
              tombolSimpan() // Tombol untuk menyimpan perubahan
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk field nama
  Widget fieldNama() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Pasien"),
      controller: _namaController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Pasien tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Widget untuk field nomor RM
  Widget fieldNomorRM() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nomor RM'),
      controller: _nomorRMController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor RM tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Widget untuk field nomor telepon
  Widget fieldNomorTelp() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nomor Telepon'),
      controller: _nomorTeleponController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor Telepon tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Widget untuk field tanggal lahir
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
          icon: const Icon(Icons.calendar_today),
        )
      ],
    );
  }

  // Widget untuk field alamat
  Widget fieldAlamat() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Alamat'),
      controller: _alamatController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Alamat tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Widget untuk tombol simpan perubahan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Pasien pasien = Pasien(
            id: widget.pasien.id,
            nama: _namaController.text.trim(),
            nomorRM: _nomorRMController.text.trim(),
            nomorTelepon: _nomorTeleponController.text.trim(),
            tanggalLahir: _selectedDate!,
            alamat: _alamatController.text.trim(),
          );

          await PasienService().ubah(pasien, widget.pasien.id.toString()).then((value) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PasienDetail(pasien: value),
              ),
            );
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      child: const Text("Simpan Perubahan"),
    );
  }
}
