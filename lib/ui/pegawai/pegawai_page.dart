import 'package:first_mobile_app/model/pegawai.dart';
import 'package:first_mobile_app/service/pegawai_service.dart';
import 'package:first_mobile_app/ui/pegawai/pegawai_form.dart';
import 'package:first_mobile_app/ui/pegawai/pegawai_item.dart';
import 'package:first_mobile_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({Key? key}) : super(key: key);

  @override
  State<PegawaiPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PegawaiPage> {
  late Stream<List<Pegawai>> _poliStream;

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
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Data Pegawai'),
        actions: [
          GestureDetector(
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
              return PegawaiItem(pegawai: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
