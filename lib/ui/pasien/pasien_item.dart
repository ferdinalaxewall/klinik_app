import 'package:klinik_app/model/pasien.dart';
import 'package:klinik_app/ui/pasien/pasien_detail.dart';
import 'package:flutter/material.dart';

// Widget untuk menampilkan item daftar pasien dalam bentuk Card
class PasienItem extends StatelessWidget {
  final Pasien pasien;
  const PasienItem({Key? key, required this.pasien});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan nama pasien dengan gaya teks tebal
              Text(
                pasien.nama,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              // Baris info nomor RM dan tanggal lahir
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menampilkan nomor RM
                  Text(
                    pasien.nomorRM,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Menampilkan ikon kalender dan tanggal lahir
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(pasien.formattedTanggalLahir)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        // Menavigasi ke halaman detail pasien saat item diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasienDetail(pasien: pasien),
          ),
        );
      },
    );
  }
}
