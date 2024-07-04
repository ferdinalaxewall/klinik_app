import 'package:first_mobile_app/model/pasien.dart';
import 'package:first_mobile_app/service/pasien_service.dart';
import 'package:first_mobile_app/ui/pasien/pasien_form.dart';
import 'package:first_mobile_app/ui/pasien/pasien_item.dart';
import 'package:first_mobile_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);

  @override
  State<PasienPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PasienPage> {
  late Stream<List<Pasien>> _poliStream;

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
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Data Pasien'),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasienForm(),
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
              return PasienItem(pasien: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
