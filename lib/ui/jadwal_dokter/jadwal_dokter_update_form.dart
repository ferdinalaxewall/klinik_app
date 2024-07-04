import 'package:first_mobile_app/model/jadwal_dokter.dart';
import 'package:first_mobile_app/model/poli.dart';
import 'package:first_mobile_app/service/jadwal_dokter_service.dart';
import 'package:first_mobile_app/service/poli_service.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy/MM/dd');

class JadwalDokterUpdateForm extends StatefulWidget {
  final JadwalDokter jadwal_dokter;
  const JadwalDokterUpdateForm({super.key, required this.jadwal_dokter});

  @override
  State<JadwalDokterUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<JadwalDokterUpdateForm> {
  final formKey = GlobalKey<FormState>();
  final namaDokterController = TextEditingController();
  String? _selectedPoli;
  DateTime? _selectedDate;

  List<Poli> _availablePoli = [];

  Future<JadwalDokter> getData() async {
    JadwalDokter data =
        await JadwalDokterService().getById(widget.jadwal_dokter.id.toString());
    setState(() {
      _selectedPoli =
          _availablePoli.contains(data.namaPoli) ? data.namaPoli : null;
      namaDokterController.text = data.namaDokter;
      _selectedDate = data.tanggal;
    });

    return data;
  }

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
    super.initState();
    getData();
    getPoli();
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      child: const Text("Simpan Perubahan"),
    );
  }
}
