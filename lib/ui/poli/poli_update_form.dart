import 'package:klinik_app/model/poli.dart';
import 'package:klinik_app/service/poli_service.dart';
import 'package:klinik_app/ui/poli/poli_detail.dart';
import 'package:flutter/material.dart';

// StatefulWidget untuk form update Poli
class PoliUpdateForm extends StatefulWidget {
  final Poli poli;
  const PoliUpdateForm({Key? key, required this.poli}) : super(key: key);

  @override
  State<PoliUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final formKey = GlobalKey<FormState>();
  final namaPoliController = TextEditingController();

  // Method untuk mengambil data Poli berdasarkan id
  Future<Poli> getData() async {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    setState(() {
      namaPoliController.text = data.namaPoli; // Mengatur nilai controller dengan nama Poli yang ada
    });

    return data;
  }

  @override
  void initState() {
    super.initState();
    getData(); // Memanggil method getData() pada initState untuk mengisi form
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Poli")), // Judul halaman
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              fieldNamaPoli(), // Widget input nama Poli
              const SizedBox(height: 20),
              tombolSimpan() // Widget tombol simpan perubahan
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk input nama Poli
  Widget fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: namaPoliController,
    );
  }

  // Widget tombol simpan perubahan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (namaPoliController.text.trim().isEmpty) {
          // Menampilkan dialog jika input nama Poli kosong
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

        Poli poli = Poli(namaPoli: namaPoliController.text); // Membuat objek Poli baru dengan nama dari input
        String id = widget.poli.id.toString(); // Mendapatkan id Poli yang akan diubah

        await PoliService().ubah(poli, id).then((value) {
          Navigator.pop(context); // Menutup halaman form update Poli
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoliDetail(poli: value), // Navigasi ke halaman detail Poli setelah berhasil diubah
            ),
          );
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      child: const Text("Simpan Perubahan"),
    );
  }
}
