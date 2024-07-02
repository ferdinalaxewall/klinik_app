import 'package:first_mobile_app/helper/user_info.dart';
import 'package:first_mobile_app/ui/beranda.dart';
import 'package:first_mobile_app/ui/login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  runApp(
    MaterialApp(
      title: 'Klinik',
      home: token != null ? Beranda() : Login(),
      theme: ThemeData.light(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
    )
  );
}
