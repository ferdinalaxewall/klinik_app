import 'package:first_mobile_app/model/jadwal_dokter.dart';
import 'package:first_mobile_app/ui/jadwal_dokter/jadwal_dokter_detail.dart';
import 'package:flutter/material.dart';

class JadwalDokterItem extends StatelessWidget {
  final JadwalDokter jadwal_dokter;
  const JadwalDokterItem({super.key, required this.jadwal_dokter});

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
              Text(
                jadwal_dokter.namaDokter,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    jadwal_dokter.namaPoli,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(jadwal_dokter.formattedTanggal)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                JadwalDokterDetail(jadwal_dokter: jadwal_dokter),
          ),
        );
      },
    );
  }
}
