import 'package:klinik_app/model/jadwal_dokter.dart'; // Import model JadwalDokter
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_detail.dart'; // Import halaman detail JadwalDokter
import 'package:flutter/material.dart';
import 'package:klinik_app/widget/item_card.dart'; // Import package Flutter

// Widget untuk menampilkan item JadwalDokter dalam bentuk card
class JadwalDokterItem extends StatelessWidget {
  final JadwalDokter jadwal_dokter; // Data JadwalDokter untuk ditampilkan

  const JadwalDokterItem({super.key, required this.jadwal_dokter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ItemCard(
        child: Row(
          children: [
            const Icon(
              Icons.book_rounded,
              size: 30,
              color: Colors.deepPurple,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jadwal_dokter.namaDokter, // Menampilkan nama dokter dengan gaya teks tebal dan ukuran 16
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        jadwal_dokter.namaPoli, // Menampilkan nama poli dengan gaya teks warna hitam
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month, // Menampilkan ikon kalender bulan dengan ukuran 16
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(jadwal_dokter.formattedTanggal) // Menampilkan tanggal format tanggal terformat
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                JadwalDokterDetail(jadwal_dokter: jadwal_dokter), // Navigasi ke halaman detail JadwalDokter ketika item diklik
          ),
        );
      },
    );
  }
}
