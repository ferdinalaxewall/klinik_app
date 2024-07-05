import 'package:klinik_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

// Widget Stateless untuk halaman beranda
class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold untuk struktur dasar halaman
    return Scaffold(
      // Sidebar menu yang dapat diakses dengan menggeser dari kiri layar
      drawer: const Sidebar(),
      // AppBar sebagai header halaman
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      // Bagian utama halaman yang menampilkan pesan selamat datang
      body: const Center(
        child: Text('Selamat Datang'),
      ),
    );
  }
}
