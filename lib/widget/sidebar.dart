import 'package:klinik_app/ui/beranda.dart';
import 'package:klinik_app/ui/jadwal_dokter/jadwal_dokter_page.dart';
import 'package:klinik_app/ui/login.dart';
import 'package:klinik_app/ui/pasien/pasien_page.dart';
import 'package:klinik_app/ui/pegawai/pegawai_page.dart';
import 'package:klinik_app/ui/poli/poli_page.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           const UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text('admin@example.com'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Beranda()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessible),
            title: const Text('Poli'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PoliPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Pegawai'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PegawaiPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box_sharp),
            title: const Text('Pasien'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasienPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Jadwal Dokter'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const JadwalDokterPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}