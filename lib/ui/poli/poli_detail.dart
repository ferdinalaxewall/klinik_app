import 'package:first_mobile_app/model/poli.dart';
import 'package:first_mobile_app/service/poli_service.dart';
import 'package:first_mobile_app/ui/poli/poli_page.dart';
import 'package:first_mobile_app/ui/poli/poli_update_form.dart';
import 'package:flutter/material.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({super.key, required this.poli});

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  Stream<Poli> getData() async* {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Poli"),
        ),
        body: StreamBuilder(
          stream: getData(),
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
              return const Text('Data Tidak Ditemukan');
            }

            return Column(
              children: [
                const SizedBox(height: 20),
                Text("Nama Poli: ${snapshot.data.namaPoli}"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [tombolUbah(), tombolHapus()],
                )
              ],
            );
          },
        ));
  }

  tombolUbah() {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoliUpdateForm(poli: snapshot.data),
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("Ubah"),
      ),
    );
  }

  tombolHapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              StreamBuilder(
                stream: getData(),
                builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                  onPressed: () async {
                    await PoliService().hapus(snapshot.data).then(
                      (value) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PoliPage(),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Ya"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Tidak"),
              )
            ],
          );

          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }
}
