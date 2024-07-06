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
  final _namaPoliController = TextEditingController();
  final _deskripsiPoliController = TextEditingController();

  // Method untuk mengambil data Poli berdasarkan id
  Future<Poli> getData() async {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    setState(() {
      _namaPoliController.text =
          data.namaPoli; // Mengatur nilai controller dengan nama Poli yang ada
      _deskripsiPoliController.text = data
          .deskripsi; // Mengatur nilai controller dengan deskripsi Poli yang ada
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                fieldNamaPoli(), // Widget input nama Poli
                const SizedBox(height: 20),
                fieldDeskripsiPoli(), // Widget input deskripsi Poli
                const SizedBox(height: 20),
                tombolSimpan() // Widget tombol simpan perubahan
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk input nama Poli
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

  // Widget untuk input deskripsi Poli
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

  // Widget tombol simpan perubahan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_namaPoliController.text.trim().isEmpty) {
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

        // Membuat objek Poli baru dengan nama dari input
        Poli poli = Poli(
          namaPoli: _namaPoliController.text.trim(),
          deskripsi: _deskripsiPoliController.text.trim(),
        );

        String id =
            widget.poli.id.toString(); // Mendapatkan id Poli yang akan diubah

        await PoliService().ubah(poli, id).then((value) {
          Navigator.pop(context); // Menutup halaman form update Poli
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PoliDetail(
                poli: value,
              ), // Navigasi ke halaman detail Poli setelah berhasil diubah
            ),
          );
        });
      },style: ButtonStyle(
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
              Icons.save_outlined,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Simpan Perubahan',
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
