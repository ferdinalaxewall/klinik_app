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
      onTap: () {
        // Navigasi ke halaman detail poli ketika kartu ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PoliDetail(poli: poli),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 0, // Spread radius
              blurRadius: 0, // Blur radius
              offset: const Offset(3, 3), // Shadow position (x, y)
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.local_hospital,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  poli.namaPoli,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  poli.deskripsi,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
