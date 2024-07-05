import 'package:flutter/material.dart';
import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import 'package:klinik_app/ui/pegawai/pegawai_page.dart';
import 'package:klinik_app/ui/pegawai/pegawai_update_form.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({Key? key, required this.pegawai}) : super(key: key);

  @override
  State<PegawaiDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PegawaiDetail> {
  late Stream<Pegawai> _pegawaiStream;

  @override
  void initState() {
    _pegawaiStream = _getDataStream(); // Memuat data pegawai saat inisialisasi
    super.initState();
  }

  // Mengambil data pegawai berdasarkan ID dari service
  Stream<Pegawai> _getDataStream() async* {
    Pegawai data =
        await PegawaiService().getById(widget.pegawai.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pegawai"),
      ),
      body: StreamBuilder<Pegawai>(
        stream: _pegawaiStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString()); // Tampilkan pesan jika terjadi error
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Tampilkan indikator loading saat menunggu data
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Tidak Ditemukan'); // Tampilkan pesan jika data tidak ditemukan
          }

          // Tampilan detail pegawai
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text("Nama Pegawai: ${snapshot.data!.nama}"), // Menampilkan nama pegawai
              const SizedBox(height: 10),
              Text("NIP: ${snapshot.data!.nip}"), // Menampilkan NIP pegawai
              const SizedBox(height: 10),
              Text("Nomor Telepon: ${snapshot.data!.nomorTelepon}"), // Menampilkan nomor telepon pegawai
              const SizedBox(height: 10),
              Text("Email: ${snapshot.data!.email}"), // Menampilkan email pegawai
              const SizedBox(height: 10),
              Text("Tanggal Lahir: ${snapshot.data!.formattedTanggalLahir}"), // Menampilkan tanggal lahir pegawai
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEditButton(snapshot.data!), // Tombol untuk mengubah data pegawai
                  _buildDeleteButton(snapshot.data!), // Tombol untuk menghapus data pegawai
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget untuk tombol ubah
  Widget _buildEditButton(Pegawai pegawai) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PegawaiUpdateForm(pegawai: pegawai), // Beralih ke halaman update data pegawai
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: const Row(
        children: [
          Icon(
            Icons.edit_outlined,
            size: 15,
          ),
          SizedBox(width: 5),
          Text('Ubah'),
        ],
      ),
    );
  }

  // Widget untuk tombol hapus
  Widget _buildDeleteButton(Pegawai pegawai) {
    return ElevatedButton(
      onPressed: () {
        _showDeleteConfirmationDialog(pegawai); // Menampilkan dialog konfirmasi hapus data pegawai
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      child: const Row(
        children: [
          Icon(
            Icons.delete_outline_rounded,
            size: 15,
          ),
          SizedBox(width: 5),
          Text('Hapus'),
        ],
      ),
    );
  }

  // Method untuk menampilkan dialog konfirmasi hapus
  void _showDeleteConfirmationDialog(Pegawai pegawai) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await PegawaiService().hapus(pegawai).then((value) {
                Navigator.pop(context); // Menutup dialog konfirmasi
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PegawaiPage(), // Beralih kembali ke halaman data pegawai setelah menghapus
                  ),
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Ya"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Menutup dialog konfirmasi
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text("Tidak"),
          ),
        ],
      ),
    );
  }
}
