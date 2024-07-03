import 'package:first_mobile_app/model/jadwal_dokter.dart';
import 'package:first_mobile_app/service/jadwal_dokter_service.dart';
import 'package:first_mobile_app/service/poli_service.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_page.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_update_form.dart';
import 'package:flutter/material.dart';

class JadwalDokterDetail extends StatefulWidget {
  final JadwalDokter jadwal_dokter;

  const JadwalDokterDetail({super.key, required this.jadwal_dokter});

  @override
  State<JadwalDokterDetail> createState() => _JadwalDokterDetailState();
}

class _JadwalDokterDetailState extends State<JadwalDokterDetail> {
  Stream<JadwalDokter> getData() async* {
    JadwalDokter data = await JadwalDokterService().getById(widget.jadwal_dokter.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Jadwal Dokter"),
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
                Text("Nama Poli: ${snapshot.data.namaPoli}"),
                const SizedBox(height: 10),
                Text("Nama Dokter: ${snapshot.data.namaDokter}"),
                const SizedBox(height: 10),
                Text("Tanggal: ${snapshot.data.formattedTanggal}"),
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
              builder: (context) => JadwalDokterUpdateForm(jadwal_dokter: snapshot.data),
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
                            builder: (context) => const JadwalDokterPage(),
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
