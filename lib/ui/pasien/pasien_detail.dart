import 'package:klinik_app/model/pasien.dart';
import 'package:klinik_app/service/pasien_service.dart';
import 'package:klinik_app/ui/pasien/pasien_page.dart';
import 'package:klinik_app/ui/pasien/pasien_update_form.dart';
import 'package:flutter/material.dart';

// Halaman untuk menampilkan detail pasien
class PasienDetail extends StatefulWidget {
  final Pasien pasien;

  const PasienDetail({Key? key, required this.pasien}) : super(key: key);

  @override
  State<PasienDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PasienDetail> {
  // Method untuk mendapatkan data pasien dari service
  Stream<Pasien> getData() async* {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pasien"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: StreamBuilder(
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

            // Menampilkan detail pasien
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Menampilkan Nama Pasien
                Text(
                  snapshot.data!.nama,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                // Menampilkan Nomor RM Pasien
                Row(
                  children: [
                    const Icon(
                      Icons.discount_outlined,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      snapshot.data!.nomorRM,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Menampilkan Nomor Telepon Pasien
                Row(
                  children: [
                    const Icon(
                      Icons.call,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.data!.nomorTelepon),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),

                // Menampilkan Tanggal Lahir Pasien
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.data!.formattedTanggalLahir),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),

                // Menampilkan Alamat Pasien
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop_outlined,
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.data!.alamat),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: tombolUbah(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: tombolHapus(),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  // Widget untuk tombol Ubah
  Widget tombolUbah() {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasienUpdateForm(pasien: snapshot.data),
            ),
          );
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.green),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_outlined,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Ubah')
          ],
        ),
      ),
    );
  }

  // Widget untuk tombol Hapus
  Widget tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        // Dialog konfirmasi hapus data
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
                  // Menghapus data pasien dari database
                  await PasienService().hapus(snapshot.data).then(
                    (value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasienPage(),
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
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.red),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ],
      ),
    );
  }
}
