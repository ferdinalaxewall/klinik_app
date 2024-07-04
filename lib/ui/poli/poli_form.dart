import 'package:first_mobile_app/model/poli.dart';
import 'package:first_mobile_app/service/poli_service.dart';
import 'package:first_mobile_app/ui/poli/poli_detail.dart';
import 'package:flutter/material.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({super.key});

  @override
  State<PoliForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final formKey = GlobalKey<FormState>();
  final namaPoliController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Poli")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              fieldNamaPoli(),
              const SizedBox(height: 20),
              tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: namaPoliController,
    );
  }

  tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
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

        Poli poli = Poli(namaPoli: namaPoliController.text);
        await PoliService().simpan(poli).then((value) {
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
