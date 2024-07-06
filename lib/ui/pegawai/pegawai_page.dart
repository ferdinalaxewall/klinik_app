import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import 'package:klinik_app/ui/pegawai/pegawai_form.dart';
import 'package:klinik_app/ui/pegawai/pegawai_item.dart';
import 'package:klinik_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

// Halaman untuk menampilkan data pegawai
class PegawaiPage extends StatefulWidget {
  const PegawaiPage({Key? key}) : super(key: key);

  @override
  State<PegawaiPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PegawaiPage> {
  late Stream<List<Pegawai>> _poliStream;

  // Method untuk mendapatkan data pegawai dalam bentuk stream
  Stream<List<Pegawai>> getList() async* {
    List<Pegawai> data = await PegawaiService().listData();
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
      // Widget Scaffold menyediakan struktur dasar visual untuk halaman
      drawer: const Sidebar(), // Widget Sidebar untuk navigasi
      appBar: AppBar(
        title: const Text('Data Pegawai'),
        actions: [
          GestureDetector(
            // Ikon tambah untuk navigasi ke form penambahan pegawai baru
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PegawaiForm(),
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
          // StreamBuilder untuk menampilkan stream data pegawai
          stream: _poliStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              // Menampilkan pesan error jika terjadi kesalahan
              return Text(snapshot.error.toString());
            }
        
            if (snapshot.connectionState != ConnectionState.done) {
              // Menampilkan indikator loading saat data masih diambil
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              // Menampilkan pesan jika tidak ada data
              return const Text('Data Kosong');
            }
        
            // Menampilkan data pegawai dalam bentuk ListView
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return PegawaiItem(pegawai: snapshot.data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
