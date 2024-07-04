import 'package:klinik_app/helper/user_info.dart';
import 'package:klinik_app/ui/beranda.dart';
import 'package:klinik_app/ui/login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  runApp(
    MaterialApp(
      title: 'Klinik',
      home: token != null ? Beranda() : Login(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito'
      ),
      debugShowCheckedModeBanner: false,
    )
  );
}
