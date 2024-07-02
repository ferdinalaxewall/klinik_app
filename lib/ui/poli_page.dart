import 'package:first_mobile_app/model/poli.dart';
import 'package:first_mobile_app/service/poli_service.dart';
import 'package:first_mobile_app/ui/poli_form.dart';
import 'package:first_mobile_app/ui/poli_item.dart';
import 'package:first_mobile_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({Key? key}) : super(key: key);

  @override
  _PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  late Stream<List<Poli>> _poliStream;
  
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  void initState() {
    _poliStream = getList();
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      _poliStream = getList();  // Refresh the stream
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Sidebar(),
        appBar: AppBar(
          title: const Text('Data Poli'),
          actions: [
            GestureDetector(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PoliForm()));
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: StreamBuilder(
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
        
              if (!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return const Text('Data Kosong');
              }
        
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return PoliItem(poli: snapshot.data[index]);
                },
              );
            },
          ),
        ));
  }
}
