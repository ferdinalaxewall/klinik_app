import 'package:first_mobile_app/model/jadwal_dokter.dart';
import 'package:first_mobile_app/service/jadwal_dokter_service.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JadwalDokterUpdateForm extends StatefulWidget {
  final JadwalDokter jadwal_dokter;
  const JadwalDokterUpdateForm({super.key, required this.jadwal_dokter});

  @override
  State<JadwalDokterUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<JadwalDokterUpdateForm> {
  final formKey = GlobalKey<FormState>();
  final namaPoliController = TextEditingController();
  final namaDokterController = TextEditingController();
  final tanggalController = TextEditingController();

  Future<JadwalDokter> getData() async {
    JadwalDokter data =
        await JadwalDokterService().getById(widget.jadwal_dokter.id.toString());
    setState(() {
      namaPoliController.text = data.namaPoli;
      namaDokterController.text = data.namaDokter;
      tanggalController.text = DateFormat('yyyy-MM-dd').format(data.tanggal);
    });

    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah JadwalDokter")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
          String id = widget.jadwal_dokter.id.toString();

          await JadwalDokterService().ubah(jadwal_dokter, id).then((value) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JadwalDokterDetail(jadwal_dokter: value),
              ),
            );
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
