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
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pegawai"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: StreamBuilder<Pegawai>(
          stream: _pegawaiStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error
                  .toString()); // Tampilkan pesan jika terjadi error
            }

            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(), // Tampilkan indikator loading saat menunggu data
              );
            }

            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text(
                  'Data Tidak Ditemukan'); // Tampilkan pesan jika data tidak ditemukan
            }

            // Tampilan detail pegawai
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Menampilkan Nama pegawai
                Text(
                  snapshot.data!.nama,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                // Menampilkan NIP pegawai
                Row(
                  children: [
                    const Icon(
                      Icons.discount_outlined,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      snapshot.data!.nip,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Menampilkan Nomor Telepon pegawai
                Row(
                  children: [
                    const Icon(
                      Icons.call,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.data!.nomorTelepon),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),

                // Menampilkan Email pegawai
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.data!.email),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),

                // Menampilkan Tanggal Lahir pegawai
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.data!.formattedTanggalLahir),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: tombolUbah(snapshot.data!),
                    ), 
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: tombolHapus(snapshot.data!),
                    ), 
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Widget untuk tombol ubah
  Widget tombolUbah(Pegawai pegawai) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PegawaiUpdateForm(
              pegawai: pegawai,
            ), // Beralih ke halaman update data pegawai
          ),
        );
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.green),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_outlined,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text('Ubah')
        ],
      ),
    );
  }

  // Widget untuk tombol hapus
  Widget tombolHapus(Pegawai pegawai) {
    return ElevatedButton(
      onPressed: () {
        _showDeleteConfirmationDialog(
            pegawai); // Menampilkan dialog konfirmasi hapus data pegawai
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.red),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline_rounded,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Hapus',
          ),
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
                    builder: (context) =>
                        const PegawaiPage(), // Beralih kembali ke halaman data pegawai setelah menghapus
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
