import 'package:klinik_app/model/jadwal_dokter.dart';
import 'package:klinik_app/service/jadwal_dokter_service.dart';
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_form.dart';
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_item.dart';
import 'package:klinik_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

class JadwalDokterPage extends StatefulWidget {
  const JadwalDokterPage({Key? key}) : super(key: key);

  @override
  State<JadwalDokterPage> createState() => _JadwalDokterPageState();
}

class _JadwalDokterPageState extends State<JadwalDokterPage> {
  late Stream<List<JadwalDokter>> _poliStream;

  Stream<List<JadwalDokter>> getList() async* {
    List<JadwalDokter> data = await JadwalDokterService().listData();
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
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Data Jadwal Dokter'),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const JadwalDokterForm()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _poliStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return JadwalDokterItem(jadwal_dokter: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
