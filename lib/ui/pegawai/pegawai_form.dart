import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import 'package:klinik_app/ui/pegawai/pegawai_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy/MM/dd');

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({super.key});

  @override
  State<PegawaiForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PegawaiForm> {
  final formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nipController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                fieldNama(),
                const SizedBox(height: 20),
                fieldNIP(),
                const SizedBox(height: 20),
                fieldNomorTelp(),
                const SizedBox(height: 20),
                fieldTanggalLahir(),
                const SizedBox(height: 20),
                fieldEmail(),
                const SizedBox(height: 20),
                fieldPassword(),
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
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaController,
    );
  }

  Widget fieldNIP() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Nomor Induk Pegawai (NIP)'),
      controller: _nipController,
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

  Widget fieldEmail() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Email'),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget fieldPassword() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Password'),
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_namaController.text.trim().isEmpty ||
            _nipController.text.trim().isEmpty ||
            _emailController.text.trim().isEmpty ||
            _nomorTeleponController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text('Pastikan Nama Pegawai, NIP, Email, Password, Nomor Telepon, dan Tanggal Lahir Sudah Terisi!'),
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

        Pegawai pegawai = Pegawai(
          nama: _namaController.text.trim(),
          nip: _nipController.text.trim(),
          nomorTelepon: _nomorTeleponController.text.trim(),
          tanggalLahir: _selectedDate!,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
        );

        await PegawaiService().simpan(pegawai).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PegawaiDetail(pegawai: value),
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
