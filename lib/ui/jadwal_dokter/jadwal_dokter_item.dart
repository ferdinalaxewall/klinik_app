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
        child: ListTile(
          title: Text(jadwal_dokter.namaPoli),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JadwalDokterDetail(jadwal_dokter: jadwal_dokter),
          ),
        );
      },
    );
  }
}
