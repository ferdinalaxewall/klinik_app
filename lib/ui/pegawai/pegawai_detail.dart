import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/service/pegawai_service.dart';
import 'package:klinik_app/ui/pegawai/pegawai_page.dart';
import 'package:klinik_app/ui/pegawai/pegawai_update_form.dart';
import 'package:flutter/material.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({super.key, required this.pegawai});

  @override
  State<PegawaiDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PegawaiDetail> {
  Stream<Pegawai> getData() async* {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Pegawai"),
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
                const SizedBox(height: 10),
                Text("Nama Pegawai: ${snapshot.data.nama}"),
                const SizedBox(height: 10),
                Text("NIP: ${snapshot.data.nip}"),
                const SizedBox(height: 10),
                Text("Nomor Telepon: ${snapshot.data.nomorTelepon}"),
                const SizedBox(height: 10),
                Text("Email: ${snapshot.data.email}"),
                const SizedBox(height: 10),
                Text("Tanggal Lahir: ${snapshot.data.formattedTanggalLahir}"),
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
              builder: (context) => PegawaiUpdateForm(pegawai: snapshot.data),
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

  tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text(
            "Yakin ingin menghapus data ini?",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          actions: [
            StreamBuilder(
              stream: getData(),
              builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                onPressed: () async {
                  await PegawaiService().hapus(snapshot.data).then(
                    (value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PegawaiPage(),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Ya"),
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
              child: const Text("Tidak"),
            )
          ],
        );

        showDialog(context: context, builder: (context) => alertDialog);
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
