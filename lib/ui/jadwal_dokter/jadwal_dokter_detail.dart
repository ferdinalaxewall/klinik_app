import 'package:klinik_app/model/jadwal_dokter.dart'; // Import model JadwalDokter
import 'package:klinik_app/service/jadwal_dokter_service.dart'; // Import service JadwalDokterService
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_page.dart'; // Import halaman JadwalDokterPage
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_update_form.dart'; // Import form untuk update JadwalDokter
import 'package:flutter/material.dart'; // Import package Flutter

// Halaman detail untuk JadwalDokter
class JadwalDokterDetail extends StatefulWidget {
  final JadwalDokter jadwal_dokter; // Data jadwal dokter yang akan ditampilkan

  const JadwalDokterDetail({super.key, required this.jadwal_dokter});

  @override
  State<JadwalDokterDetail> createState() => _JadwalDokterDetailState();
}

class _JadwalDokterDetailState extends State<JadwalDokterDetail> {
  // Method untuk mengambil data jadwal dokter berdasarkan ID
  Stream<JadwalDokter> getData() async* {
    JadwalDokter data =
        await JadwalDokterService().getById(widget.jadwal_dokter.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Jadwal Dokter"), // Judul AppBar
        ),
        body: StreamBuilder(
          stream: getData(), // Stream data jadwal dokter
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString()); // Tampilkan error jika ada
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(), // Tampilkan loading indicator jika data belum selesai dimuat
              );
            }

            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text('Data Tidak Ditemukan'); // Tampilkan pesan jika data tidak ditemukan
            }

            return Column(
              children: [
                const SizedBox(height: 10),
                Text("Nama Poli: ${snapshot.data.namaPoli}"), // Tampilkan nama poli
                const SizedBox(height: 10),
                Text("Nama Dokter: ${snapshot.data.namaDokter}"), // Tampilkan nama dokter
                const SizedBox(height: 10),
                Text("Tanggal: ${snapshot.data.formattedTanggal}"), // Tampilkan tanggal
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [tombolUbah(), tombolHapus()], // Tombol untuk mengubah dan menghapus data
                )
              ],
            );
          },
        ));
  }

  // Widget tombol untuk mengubah data
  tombolUbah() {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  JadwalDokterUpdateForm(jadwal_dokter: snapshot.data), // Navigasi ke form update JadwalDokter
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
            SizedBox(width: 5,),
            Text('Ubah')
          ],
        ),
      ),
    );
  }

  // Widget tombol untuk menghapus data
  tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text(
            "Yakin ingin menghapus data ini?", // Pesan konfirmasi
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            StreamBuilder(
              stream: getData(),
              builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                onPressed: () async {
                  await JadwalDokterService().hapus(snapshot.data).then(
                    (value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JadwalDokterPage(), // Kembali ke halaman JadwalDokterPage
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Ya"), // Tombol konfirmasi "Ya"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Tidak"), // Tombol konfirmasi "Tidak"
            )
          ],
        );

        showDialog(context: context, builder: (context) => alertDialog); // Tampilkan dialog konfirmasi
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
          SizedBox(
            width: 5,
          ),
          Text(
            'Hapus',
          )
        ],
      ),
    );
  }
}
