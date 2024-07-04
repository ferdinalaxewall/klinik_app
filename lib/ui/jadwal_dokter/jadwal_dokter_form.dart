import 'package:first_mobile_app/model/jadwal_dokter.dart';
import 'package:first_mobile_app/model/poli.dart';
import 'package:first_mobile_app/service/jadwal_dokter_service.dart';
import 'package:first_mobile_app/service/poli_service.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy/MM/dd');

class JadwalDokterForm extends StatefulWidget {
  const JadwalDokterForm({super.key});

  @override
  State<JadwalDokterForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<JadwalDokterForm> {
  final formKey = GlobalKey<FormState>();
  final namaDokterController = TextEditingController();
  String? _selectedPoli;
  DateTime? _selectedDate;

  List<Poli> _availablePoli = [];

  void getPoli() async {
    List<Poli> dataPoli = await PoliService().listData();

    setState(() {
      _availablePoli = dataPoli;
    });
  }

  void _showDatePicker() async {
    DateTime now = DateTime.now();
    DateTime currentDate = _selectedDate ?? now;

    final DateTime firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );

    final DateTime lastDate = DateTime(now.year, now.month + 1, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void initState() {
    getPoli();
    super.initState();
  }

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
                fieldNamaDokter(),
                const SizedBox(height: 20),
                fieldNamaPoli(),
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
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: const Text(
          'Pilih Poli',
          style: TextStyle(fontSize: 17, color: Colors.black87),
        ),
        value: _selectedPoli,
        isExpanded: true,
        items: _availablePoli
            .map((poli) => DropdownMenuItem(
                  value: poli.namaPoli,
                  child: Text(poli.namaPoli),
                ))
            .toList(),
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _selectedPoli = value;
          });
        },
      ),
    );
  }

  fieldNamaDokter() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Dokter"),
      controller: namaDokterController,
    );
  }

  fieldTanggal() {
    return Row(
      children: [
        Text(
          _selectedDate == null
              ? 'Tanggal Belum Dipilih'
              : formatter.format(_selectedDate!),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
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

  tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_selectedPoli == null ||
            namaDokterController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text(
                  'Pastikan Nama Dokter, Poli, dan Tanggal Sudah Terisi!'),
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

        JadwalDokter jadwal_dokter = JadwalDokter(
          namaPoli: _selectedPoli!,
          namaDokter: namaDokterController.text,
          tanggal: _selectedDate!,
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
      child: const Text("Simpan"),
    );
  }
}
