import 'package:klinik_app/model/jadwal_dokter.dart'; // Mengimpor model JadwalDokter
import 'package:klinik_app/service/jadwal_dokter_service.dart'; // Mengimpor service JadwalDokterService
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_form.dart'; // Mengimpor form JadwalDokter
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_item.dart'; // Mengimpor item JadwalDokter
import 'package:klinik_app/widget/sidebar.dart'; // Mengimpor widget Sidebar
import 'package:flutter/material.dart'; // Mengimpor package Flutter

// Halaman untuk menampilkan jadwal dokter
class JadwalDokterPage extends StatefulWidget {
  const JadwalDokterPage({Key? key}) : super(key: key);

  @override
  State<JadwalDokterPage> createState() => _JadwalDokterPageState();
}

class _JadwalDokterPageState extends State<JadwalDokterPage> {
  late Stream<List<JadwalDokter>> _poliStream;

  // Method untuk mendapatkan list data jadwal dokter
  Stream<List<JadwalDokter>> getList() async* {
    List<JadwalDokter> data = await JadwalDokterService().listData();
    yield data;
  }

  @override
  void initState() {
    _poliStream = getList(); // Inisialisasi stream data jadwal dokter
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(), // Widget Sidebar untuk navigasi
      appBar: AppBar(
        title: const Text('Data Jadwal Dokter'), // Judul AppBar
        actions: [
          GestureDetector(
            child: const Icon(Icons.add), // Ikon untuk menambah data
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const JadwalDokterForm())); // Navigasi ke halaman form JadwalDokter
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: StreamBuilder(
          stream: _poliStream, // Stream data jadwal dokter
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString()); // Menampilkan error jika ada
            }
        
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(), // Menampilkan loading indicator jika data belum selesai dimuat
              );
            }
        
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text('Data Kosong'); // Menampilkan pesan jika data kosong
            }
        
            return ListView.builder(
              itemCount: snapshot.data.length, // Jumlah item dalam list
              itemBuilder: (context, index) {
                return JadwalDokterItem(jadwal_dokter: snapshot.data[index]); // Menampilkan item jadwal dokter
              },
            );
          },
        ),
      ),
    );
  }
}
