import 'package:klinik_app/model/poli.dart';
import 'package:klinik_app/ui/poli/poli_detail.dart';
import 'package:flutter/material.dart';
import 'package:klinik_app/widget/item_card.dart';

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
      child: ItemCard(
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
