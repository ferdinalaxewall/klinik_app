import 'package:klinik_app/model/poli.dart';
import 'package:klinik_app/service/poli_service.dart';
import 'package:klinik_app/ui/poli/poli_detail.dart';
import 'package:flutter/material.dart';

// Stateful widget untuk form penambahan data poli
class PoliForm extends StatefulWidget {
  const PoliForm({super.key});

  @override
  State<PoliForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final formKey = GlobalKey<FormState>(); // Kunci untuk form
  final namaPoliController = TextEditingController(); // Controller untuk field nama poli

  @override
  Widget build(BuildContext context) {
    // Scaffold untuk struktur dasar halaman
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Poli")), // AppBar dengan judul halaman
      body: SingleChildScrollView(
        child: Form(
          key: formKey, // Menggunakan kunci form
          child: Column(
            children: [
              fieldNamaPoli(), // Field untuk input nama poli
              const SizedBox(height: 20),
              tombolSimpan() // Tombol untuk menyimpan data
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk field input nama poli
  Widget fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: namaPoliController,
    );
  }

  // Widget untuk tombol simpan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        // Validasi input
        if (namaPoliController.text.trim().isEmpty) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text('Pastikan Nama Poli Sudah Terisi!'),
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

        // Membuat objek poli dan menyimpannya melalui service
        Poli poli = Poli(namaPoli: namaPoliController.text);
        await PoliService().simpan(poli).then((value) {
          // Navigasi ke halaman detail poli setelah data disimpan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PoliDetail(poli: value)),
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
