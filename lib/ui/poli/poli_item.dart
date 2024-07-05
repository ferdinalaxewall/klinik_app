import 'package:klinik_app/model/poli.dart';
import 'package:klinik_app/ui/poli/poli_detail.dart';
import 'package:flutter/material.dart';

// Stateless widget untuk menampilkan item poli dalam bentuk kartu
class PoliItem extends StatelessWidget {
  final Poli poli;
  
  const PoliItem({
    super.key,
    required this.poli,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector untuk mendeteksi gestur tap pada kartu
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(poli.namaPoli), // Menampilkan nama poli
        ),
      ),
      onTap: () {
        // Navigasi ke halaman detail poli ketika kartu ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PoliDetail(poli: poli),
          ),
        );
      },
    );
  }
}
