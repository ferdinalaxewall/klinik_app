import 'package:klinik_app/model/pasien.dart';
import 'package:klinik_app/service/pasien_service.dart';
import 'package:klinik_app/ui/pasien/pasien_form.dart';
import 'package:klinik_app/ui/pasien/pasien_item.dart';
import 'package:klinik_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

// Halaman untuk menampilkan daftar pasien
class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);

  @override
  State<PasienPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PasienPage> {
  late Stream<List<Pasien>> _poliStream;

  // Method untuk mendapatkan data daftar pasien dari service
  Stream<List<Pasien>> getList() async* {
    List<Pasien> data = await PasienService().listData();
    yield data;
  }

  @override
  void initState() {
    _poliStream = getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(), // Sidebar di sebelah kiri
      appBar: AppBar(
        title: const Text('Data Pasien'), // Judul halaman
        actions: [
          GestureDetector(
            child: const Icon(Icons.add), // Tombol tambah data pasien
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasienForm(), // Navigasi ke halaman tambah pasien
                ),
              );
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
          stream: _poliStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString()); // Tampilkan pesan jika terjadi error
            }
        
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(), // Tampilkan indikator loading saat memuat data
              );
            }
        
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text('Data Kosong'); // Tampilkan pesan jika data kosong
            }
        
            // Tampilkan daftar pasien dalam ListView
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return PasienItem(pasien: snapshot.data[index]); // Item pasien
              },
            );
          },
        ),
      ),
    );
  }
}
