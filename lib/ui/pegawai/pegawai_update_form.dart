import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import 'package:klinik_app/ui/pegawai/pegawai_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Format tanggal yang akan digunakan dalam form
final formatter = DateFormat('yyyy/MM/dd');

// Form untuk mengubah data pegawai
class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);

  @override
  State<PegawaiUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PegawaiUpdateForm> {
  final formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nipController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  DateTime? _selectedDate;

  // Mendapatkan data pegawai dari service dan menampilkan pada form
  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      _namaController.text = data.nama;
      _nipController.text = data.nip;
      _nomorTeleponController.text = data.nomorTelepon;
      _emailController.text = data.email;
      _passwordController.text = data.password;
      _selectedDate = data.tanggalLahir;
    });

    return data;
  }

  // Menampilkan date picker untuk memilih tanggal lahir
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
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pegawai")),
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
                fieldNama(),
                const SizedBox(height: 20),
                fieldNip(),
                const SizedBox(height: 20),
                fieldNomorTelp(),
                const SizedBox(height: 20),
                fieldEmail(),
                const SizedBox(height: 20),
                fieldPassword(),
                const SizedBox(height: 20),
                fieldTanggalLahir(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: tombolSimpan(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk input field Nama Pegawai
  Widget fieldNama() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Nama Pegawai",
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _namaController,
    );
  }

  // Widget untuk input field NIP
  Widget fieldNip() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Nomor Induk Pegawai (NIP)',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _nipController,
      keyboardType: TextInputType.number,
    );
  }

  // Widget untuk input field Nomor Telepon
  Widget fieldNomorTelp() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Nomor Telepon',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _nomorTeleponController,
      keyboardType: TextInputType.phone,
    );
  }

  // Widget untuk input field Tanggal Lahir dengan date picker
  Widget fieldTanggalLahir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Lahir:',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              _selectedDate == null
                  ? 'Pilih Tanggal Lahir'
                  : formatter.format(_selectedDate!),
             style: const TextStyle(
                fontSize: 14,
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
        ),
      ],
    );
  }

  // Widget untuk input field Email
  Widget fieldEmail() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  // Widget untuk input field Password
  Widget fieldPassword() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
        ),
      ),
      controller: _passwordController,
      obscureText: true,
    );
  }

  // Widget untuk tombol Simpan Perubahan
  Widget tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        // Validasi input sebelum menyimpan perubahan
        if (_namaController.text.trim().isEmpty ||
            _nipController.text.trim().isEmpty ||
            _emailController.text.trim().isEmpty ||
            _nomorTeleponController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Input Tidak Valid'),
              content: const Text(
                  'Pastikan Nama Pegawai, NIP, Email, Password, Nomor Telepon, dan Tanggal Lahir Sudah Terisi!'),
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

        // Membuat objek pegawai baru dari input form
        Pegawai pegawai = Pegawai(
          nama: _namaController.text.trim(),
          nip: _nipController.text.trim(),
          nomorTelepon: _nomorTeleponController.text.trim(),
          tanggalLahir: _selectedDate!,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Mengirim data perubahan ke service untuk diubah di database
        String id = widget.pegawai.id.toString();
        await PegawaiService().ubah(pegawai, id).then((value) {
          // Kembali ke halaman detail pegawai setelah berhasil menyimpan
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PegawaiDetail(pegawai: value),
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
