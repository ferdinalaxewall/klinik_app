import 'package:first_mobile_app/model/jadwal_dokter.dart';
import 'package:first_mobile_app/service/jadwal_dokter_service.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JadwalDokterForm extends StatefulWidget {
  const JadwalDokterForm({super.key});

  @override
  State<JadwalDokterForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<JadwalDokterForm> {
  final formKey = GlobalKey<FormState>();
  final namaPoliController = TextEditingController();
  final namaDokterController = TextEditingController();
  final tanggalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Jadwal Dokter")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                fieldNamaPoli(),
                const SizedBox(height: 20),
                fieldNamaDokter(),
                const SizedBox(height: 20),
                fieldTanggal(),
                const SizedBox(height: 20),
                tombolSimpan()
              ],
            ),
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

  fieldNamaDokter() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Dokter"),
      controller: namaDokterController,
    );
  }

  fieldTanggal() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal (YYYY-MM-DD)"),
      controller: tanggalController,
    );
  }

  tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          JadwalDokter jadwal_dokter = JadwalDokter(
            namaPoli: namaPoliController.text,
            namaDokter: namaDokterController.text,
            tanggal: DateFormat('yyyy-MM-dd').parse(tanggalController.text),
          );

          await JadwalDokterService().simpan(jadwal_dokter).then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JadwalDokterDetail(jadwal_dokter: value),
              ),
            );
          });
        },
        child: const Text("Simpan"));
  }
}
