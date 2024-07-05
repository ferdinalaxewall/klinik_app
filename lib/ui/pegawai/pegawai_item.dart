import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/ui/pegawai/pegawai_detail.dart';
import 'package:flutter/material.dart';

// Widget untuk menampilkan item pegawai dalam bentuk card
class PegawaiItem extends StatelessWidget {
  final Pegawai pegawai;

  // Constructor untuk menerima data pegawai
  const PegawaiItem({Key? key, required this.pegawai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Widget GestureDetector untuk menangani gesture onTap
      onTap: () {
        // Navigasi ke halaman detail pegawai saat card ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PegawaiDetail(pegawai: pegawai),
          ),
        );
      },
      child: Card(
        // Widget Card sebagai kontainer utama item pegawai
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan nama pegawai dengan style tebal
              Text(
                pegawai.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menampilkan NIP pegawai dengan warna teks hitam
                  Text(
                    pegawai.nip,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      // Menampilkan ikon kalender dan tanggal lahir pegawai
                      const Icon(
                        Icons.calendar_month,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(pegawai.formattedTanggalLahir)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
