import 'package:klinik_app/model/poli.dart';
import 'package:klinik_app/service/poli_service.dart';
import 'package:klinik_app/ui/poli/poli_form.dart';
import 'package:klinik_app/ui/poli/poli_item.dart';
import 'package:klinik_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

// StatefulWidget untuk halaman Poli
class PoliPage extends StatefulWidget {
  const PoliPage({Key? key}) : super(key: key);

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  late Stream<List<Poli>> _poliStream; // Stream untuk data Poli

  // Mengambil data Poli dari service dalam bentuk Stream
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  void initState() {
    _poliStream = getList(); // Inisialisasi Stream pada initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(), // Widget Sidebar di sisi kiri
      appBar: AppBar(
        title: const Text('Data Poli'), // Judul halaman
        actions: [
          GestureDetector(
            child: const Icon(Icons.add), // Tombol tambah poli
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PoliForm()));
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
          stream: _poliStream, // Menggunakan StreamBuilder untuk data Poli
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error
                  .toString()); // Menampilkan pesan error jika terjadi
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child:
                    CircularProgressIndicator(), // Menampilkan indikator loading jika belum selesai fetching data
              );
            }

            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text(
                  'Data Kosong'); // Menampilkan pesan jika data kosong
            }

            // Menampilkan daftar Poli dalam ListView
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return PoliItem(
                    poli: snapshot.data[index]); // Menampilkan item Poli
              },
            );
          },
        ),
      ),
    );
  }
}
