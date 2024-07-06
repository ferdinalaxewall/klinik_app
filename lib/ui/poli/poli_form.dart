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
  final _namaPoliController =
      TextEditingController(); // Controller untuk field nama poli
  final _deskripsiPoliController =
      TextEditingController(); // Controller untuk field deskripsi poli

  @override
  Widget build(BuildContext context) {
    // Scaffold untuk struktur dasar halaman
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Poli"),
      ), // AppBar dengan judul halaman
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Form(
            key: formKey, // Menggunakan kunci form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fieldNamaPoli(), // Field untuk input nama poli
                const SizedBox(height: 20),
                fieldDeskripsiPoli(), // Field untuk input deskripsi poli
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: tombolSimpan(),
                ) // Tombol untuk menyimpan data
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk field input nama poli
  Widget fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Nama Poli",
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _namaPoliController,
    );
  }

  // Widget untuk field input deskripsi poli
  Widget fieldDeskripsiPoli() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Deskripsi",
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _deskripsiPoliController,
    );
  }

  // Widget untuk tombol simpan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        // Validasi input
        if (_namaPoliController.text.trim().isEmpty ||
            _deskripsiPoliController.text.trim().isEmpty) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content:
                  const Text('Pastikan Nama & Deskripsi Poli Sudah Terisi!'),
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
        Poli poli = Poli(
          namaPoli: _namaPoliController.text.trim(),
          deskripsi: _deskripsiPoliController.text.trim(),
        );

        await PoliService().simpan(poli).then((value) {
          // Navigasi ke halaman detail poli setelah data disimpan
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PoliDetail(
                poli: value,
              ),
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
            'Tambah Poli',
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
